import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String phoneNumber;
  final String? profilePic;
  final String? about;
  final bool isOnline;
  final DateTime? lastSeen;
  final List<String> groupIds;
  
  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    this.profilePic,
    this.about,
    required this.isOnline,
    this.lastSeen,
    this.groupIds = const [],
  });
  
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'about': about ?? 'Hey there! I am using WhatsApp.',
      'isOnline': isOnline,
      'lastSeen': lastSeen?.millisecondsSinceEpoch,
      'groupIds': groupIds,
    };
  }
  
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePic: map['profilePic'],
      about: map['about'],
      isOnline: map['isOnline'] ?? false,
      lastSeen: map['lastSeen'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastSeen'])
          : null,
      groupIds: List<String>.from(map['groupIds'] ?? []),
    );
  }
}
