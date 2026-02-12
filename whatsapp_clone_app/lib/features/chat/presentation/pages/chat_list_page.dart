import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:whatsapp_clone_app/core/router/app_router.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/providers/chat_provider.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatContactsAsync = ref.watch(chatContactsStreamProvider);

    return chatContactsAsync.when(
      data: (chatContacts) {
        if (chatContacts.isEmpty) {
          return const Center(
            child: Text('No chats yet. Start a conversation!'),
          );
        }

        return ListView.builder(
          itemCount: chatContacts.length,
          itemBuilder: (context, index) {
            final chatContact = chatContacts[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.chat,
                      arguments: {
                        'userId': chatContact.contactId,
                        'userName': chatContact.name,
                        'userImage': chatContact.profilePic,
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: chatContact.profilePic.isNotEmpty
                            ? NetworkImage(chatContact.profilePic)
                            : null,
                        radius: 30.r,
                        backgroundColor: AppColors.greyLight,
                        child: chatContact.profilePic.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 30.sp,
                                color: AppColors.greyDark,
                              )
                            : null,
                      ),
                      title: Text(
                        chatContact.name,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          chatContact.lastMessage,
                          style: TextStyle(fontSize: 15.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Text(
                        timeago.format(chatContact.timeSent),
                        style: TextStyle(
                          color: AppColors.greyDark,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.divider,
                  indent: 85.w,
                ),
              ],
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.tealGreen),
      ),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
