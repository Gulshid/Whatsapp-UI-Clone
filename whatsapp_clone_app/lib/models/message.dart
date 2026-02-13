enum MessageType {
  text,
  image,
  audio,
  video,
  gif,
  contact,
}

enum MessageStatus {
  pending,
  sent,
  delivered,
  read,
}

class Message {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isSentByMe;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;
  final bool isStarred;
  final String? replyTo;

  Message({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isSentByMe,
    this.status = MessageStatus.sent,
    this.type = MessageType.text,
    this.mediaUrl,
    this.isStarred = false,
    this.replyTo,
  });

  Message copyWith({
    String? id,
    String? text,
    DateTime? timestamp,
    bool? isSentByMe,
    MessageStatus? status,
    MessageType? type,
    String? mediaUrl,
    bool? isStarred,
    String? replyTo,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isSentByMe: isSentByMe ?? this.isSentByMe,
      status: status ?? this.status,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      isStarred: isStarred ?? this.isStarred,
      replyTo: replyTo ?? this.replyTo,
    );
  }
}
