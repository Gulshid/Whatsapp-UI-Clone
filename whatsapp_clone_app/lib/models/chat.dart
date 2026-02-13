import 'message.dart';

class Chat {
  final String id;
  final String name;
  final String? profilePic;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final String? lastSeen;
  final List<Message> messages;
  final bool isPinned;
  final bool isMuted;
  final bool isArchived;
  final String? about;
  final String phoneNumber;

  Chat({
    required this.id,
    required this.name,
    this.profilePic,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
    this.lastSeen,
    this.messages = const [],
    this.isPinned = false,
    this.isMuted = false,
    this.isArchived = false,
    this.about,
    required this.phoneNumber,
  });

  Chat copyWith({
    String? id,
    String? name,
    String? profilePic,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isOnline,
    String? lastSeen,
    List<Message>? messages,
    bool? isPinned,
    bool? isMuted,
    bool? isArchived,
    String? about,
    String? phoneNumber,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      messages: messages ?? this.messages,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      isArchived: isArchived ?? this.isArchived,
      about: about ?? this.about,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  String getInitials() {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();
  }

  // Generate random color for avatar based on name
  int getAvatarColorIndex() {
    return name.codeUnitAt(0) % 8;
  }
}
