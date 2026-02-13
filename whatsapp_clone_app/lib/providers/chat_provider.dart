import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat.dart';
import '../models/message.dart';

class ChatNotifier extends StateNotifier<List<Chat>> {
  ChatNotifier() : super(_initialChats);

  static final List<Chat> _initialChats = [
    Chat(
      id: '1',
      name: 'Mom ❤️',
      phoneNumber: '+1 234 567 8901',
      lastMessage: 'Don\'t forget to call me tonight!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 3,
      isOnline: true,
      isPinned: true,
      about: 'Available',
      messages: [
        Message(
          id: '1',
          text: 'Hi sweetie! How are you?',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'Hey Mom! I\'m doing great, how about you?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '3',
          text: 'I\'m good! Just wanted to check on you',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '4',
          text: 'That\'s sweet of you! I\'ll call you later today',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '5',
          text: 'Sounds good!',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '6',
          text: 'Don\'t forget to call me tonight!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isSentByMe: false,
        ),
      ],
    ),
    Chat(
      id: '2',
      name: 'Best Friends 🎉',
      phoneNumber: '+1 234 567 8902',
      lastMessage: 'Sarah: Can\'t wait for the weekend!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      unreadCount: 12,
      isOnline: false,
      isPinned: true,
      lastSeen: 'last seen today at 10:30 AM',
      about: 'Friends forever! 💕',
      messages: [
        Message(
          id: '1',
          text: 'Hey everyone! What are the plans for this weekend?',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'I was thinking we could go to the beach!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 55)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '3',
          text: 'That sounds amazing! Count me in',
          timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 50)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '4',
          text: 'Perfect! Let\'s meet at 10 AM on Saturday',
          timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 45)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '5',
          text: 'Can\'t wait for the weekend!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          isSentByMe: false,
        ),
      ],
    ),
    Chat(
      id: '3',
      name: 'Alex Thompson',
      phoneNumber: '+1 234 567 8903',
      lastMessage: 'See you tomorrow! 👋',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
      isOnline: true,
      about: 'Busy',
      messages: [
        Message(
          id: '1',
          text: 'Hey! Are we still on for tomorrow?',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'Yes! Looking forward to it',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '3',
          text: 'Great! I\'ll pick you up at 2 PM',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '4',
          text: 'Perfect, see you then!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '5',
          text: 'See you tomorrow! 👋',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      id: '4',
      name: 'Emma Wilson',
      phoneNumber: '+1 234 567 8904',
      lastMessage: 'Thanks for the help!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 0,
      isOnline: false,
      lastSeen: 'last seen today at 9:15 AM',
      about: 'At work',
      messages: [
        Message(
          id: '1',
          text: 'Hey, I need your help with something',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'Sure! What do you need?',
          timestamp: DateTime.now().subtract(const Duration(hours: 5, minutes: 55)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '3',
          text: 'Can you review this document for me?',
          timestamp: DateTime.now().subtract(const Duration(hours: 5, minutes: 50)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '4',
          text: 'Of course! Send it over',
          timestamp: DateTime.now().subtract(const Duration(hours: 5, minutes: 45)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '5',
          text: 'Thanks for the help!',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      id: '5',
      name: 'Dad',
      phoneNumber: '+1 234 567 8905',
      lastMessage: 'Drive safely!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
      lastSeen: 'last seen yesterday at 8:30 PM',
      about: 'Hey there! I am using WhatsApp.',
      messages: [
        Message(
          id: '1',
          text: 'Hi Dad! I\'m heading home now',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'Okay son, what time will you arrive?',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '3',
          text: 'Around 7 PM',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '4',
          text: 'Drive safely!',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      id: '6',
      name: 'James Rodriguez',
      phoneNumber: '+1 234 567 8906',
      lastMessage: 'The meeting went well!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      unreadCount: 0,
      isOnline: false,
      lastSeen: 'last seen 2 days ago',
      isMuted: true,
      about: 'Coffee enthusiast ☕',
      messages: [
        Message(
          id: '1',
          text: 'How did the meeting go?',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'The meeting went well!',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      id: '7',
      name: 'Sarah Martinez',
      phoneNumber: '+1 234 567 8907',
      lastMessage: 'You: Perfect, thanks!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
      isOnline: false,
      lastSeen: 'last seen 3 days ago',
      about: 'Living my best life 🌟',
      messages: [
        Message(
          id: '1',
          text: 'Can you send me the photos from last week?',
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 2)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'Sure! I\'ll send them in a moment',
          timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '3',
          text: 'Perfect, thanks!',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      id: '8',
      name: 'Mike Johnson',
      phoneNumber: '+1 234 567 8908',
      lastMessage: 'Good luck! 🍀',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
      unreadCount: 0,
      isOnline: false,
      lastSeen: 'last seen 4 days ago',
      about: 'Tech geek 💻',
      messages: [
        Message(
          id: '1',
          text: 'I have an interview tomorrow',
          timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
          isSentByMe: true,
          status: MessageStatus.read,
        ),
        Message(
          id: '2',
          text: 'Good luck! 🍀',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          isSentByMe: false,
          status: MessageStatus.read,
        ),
      ],
    ),
  ];

  void sendMessage(String chatId, String text) {
    state = state.map((chat) {
      if (chat.id == chatId) {
        final newMessage = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          timestamp: DateTime.now(),
          isSentByMe: true,
          status: MessageStatus.sent,
        );

        // Simulate message delivery after 1 second
        Future.delayed(const Duration(seconds: 1), () {
          updateMessageStatus(chatId, newMessage.id, MessageStatus.delivered);
        });

        // Simulate message read after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          updateMessageStatus(chatId, newMessage.id, MessageStatus.read);
        });

        return chat.copyWith(
          messages: [...chat.messages, newMessage],
          lastMessage: text,
          lastMessageTime: DateTime.now(),
        );
      }
      return chat;
    }).toList();

    // Sort chats by last message time
    _sortChats();
  }

  void updateMessageStatus(String chatId, String messageId, MessageStatus status) {
    state = state.map((chat) {
      if (chat.id == chatId) {
        final updatedMessages = chat.messages.map((msg) {
          if (msg.id == messageId) {
            return msg.copyWith(status: status);
          }
          return msg;
        }).toList();
        return chat.copyWith(messages: updatedMessages);
      }
      return chat;
    }).toList();
  }

  void markAsRead(String chatId) {
    state = state.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(unreadCount: 0);
      }
      return chat;
    }).toList();
  }

  void togglePin(String chatId) {
    state = state.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(isPinned: !chat.isPinned);
      }
      return chat;
    }).toList();
    _sortChats();
  }

  void toggleMute(String chatId) {
    state = state.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(isMuted: !chat.isMuted);
      }
      return chat;
    }).toList();
  }

  void archiveChat(String chatId) {
    state = state.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(isArchived: true);
      }
      return chat;
    }).toList();
  }

  void deleteChat(String chatId) {
    state = state.where((chat) => chat.id != chatId).toList();
  }

  void _sortChats() {
    state = List.from(state)
      ..sort((a, b) {
        // Pinned chats come first
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        // Then sort by last message time
        return b.lastMessageTime.compareTo(a.lastMessageTime);
      });
  }

  List<Chat> get pinnedChats => state.where((chat) => chat.isPinned && !chat.isArchived).toList();
  
  List<Chat> get regularChats => state.where((chat) => !chat.isPinned && !chat.isArchived).toList();
  
  List<Chat> get archivedChats => state.where((chat) => chat.isArchived).toList();
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<Chat>>((ref) {
  return ChatNotifier();
});

final selectedChatProvider = StateProvider<Chat?>((ref) => null);
