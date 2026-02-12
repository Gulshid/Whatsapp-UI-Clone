import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
  contact,
  location,
}

class MessageModel {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String text;
  final MessageType type;
  final DateTime timestamp;
  final bool isSeen;
  final String? repliedTo;
  final String? repliedMessage;
  final Map<String, dynamic>? metadata;
  
  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timestamp,
    required this.isSeen,
    this.repliedTo,
    this.repliedMessage,
    this.metadata,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'repliedTo': repliedTo,
      'repliedMessage': repliedMessage,
      'metadata': metadata,
    };
  }
  
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => MessageType.text,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      isSeen: map['isSeen'] ?? false,
      repliedTo: map['repliedTo'],
      repliedMessage: map['repliedMessage'],
      metadata: map['metadata'],
    );
  }
}
