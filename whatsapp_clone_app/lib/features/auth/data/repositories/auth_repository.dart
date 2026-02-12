import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/core/constants/app_constants.dart';
import 'package:whatsapp_clone_app/core/router/app_router.dart';
import 'package:whatsapp_clone_app/features/auth/data/models/user_model.dart';


class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithPhone({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          if (context.mounted) {
            context.pushNamed(
              AppRoutes.otp,
              arguments: {
                'verificationId': verificationId,
                'phoneNumber': phoneNumber,
              },
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        // Check if user data exists
        DocumentSnapshot userDoc = await _firestore
            .collection(AppConstants.usersCollection)
            .doc(userCredential.user!.uid)
            .get();
        
        if (context.mounted) {
          if (userDoc.exists) {
            context.pushNamedAndRemoveUntil(AppRoutes.home);
          } else {
            context.pushNamedAndRemoveUntil(AppRoutes.userInfo);
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> saveUserDataToFirebase({
    required String name,
    File? profilePic,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl = '';

      if (profilePic != null) {
        photoUrl = await _uploadToStorage(
          '${AppConstants.profilePicsPath}/$uid',
          profilePic,
        );
      }

      UserModel user = UserModel(
        uid: uid,
        name: name,
        profilePic: photoUrl,
        phoneNumber: _auth.currentUser!.phoneNumber!,
        isOnline: true,
        groupIds: [],
      );

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _uploadToStorage(String path, File file) async {
    UploadTask uploadTask = _storage.ref().child(path).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> setUserState(bool isOnline) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(_auth.currentUser!.uid)
        .update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> signOut() async {
    await setUserState(false);
    await _auth.signOut();
  }
}
