import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone_app/core/constants/app_constants.dart';
import 'package:whatsapp_clone_app/features/chat/data/models/chat_contact_model.dart';
import 'package:whatsapp_clone_app/features/chat/data/models/message_model.dart';


class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<ChatContactModel>> getChatContacts() {
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.chatsCollection)
        .snapshots()
        .asyncMap((event) async {
      List<ChatContactModel> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContactModel.fromMap(document.data());
        contacts.add(chatContact);
      }
      return contacts;
    });
  }

  Stream<List<MessageModel>> getMessages(String receiverId) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.chatsCollection)
        .doc(receiverId)
        .collection(AppConstants.messagesCollection)
        .orderBy('timestamp')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }
}
