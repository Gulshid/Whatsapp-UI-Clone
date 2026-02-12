import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_app/features/chat/data/models/chat_contact_model.dart';
import 'package:whatsapp_clone_app/features/chat/data/models/message_model.dart';
import 'package:whatsapp_clone_app/features/chat/data/repositories/chat_repository.dart';


final chatRepositoryProvider = Provider((ref) => ChatRepository());

final chatContactsStreamProvider = StreamProvider<List<ChatContactModel>>((ref) {
  return ref.watch(chatRepositoryProvider).getChatContacts();
});

final chatMessagesStreamProvider = StreamProvider.family<List<MessageModel>, String>((ref, receiverId) {
  return ref.watch(chatRepositoryProvider).getMessages(receiverId);
});
