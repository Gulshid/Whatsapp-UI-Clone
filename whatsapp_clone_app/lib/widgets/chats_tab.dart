import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/chat_provider.dart';
import '../screens/chat_screen.dart';
import '../utils/app_colors.dart';
import '../utils/date_util.dart';

class ChatsTab extends ConsumerWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.read(chatProvider.notifier);
    final pinnedChats = chatNotifier.pinnedChats;
    final regularChats = chatNotifier.regularChats;

    return ListView(
      children: [
        // Archived Chats Button
        if (chatNotifier.archivedChats.isNotEmpty)
          Container(
            color: AppColors.backgroundColor,
            child: ListTile(
              leading: Icon(Icons.archive, color: AppColors.greyColor, size: 24.sp),
              title: Text(
                'Archived',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(
                '${chatNotifier.archivedChats.length}',
                style: TextStyle(
                  color: AppColors.tealGreen,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Archived chats feature coming soon!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              },
            ),
          ),

        // Pinned Chats
        if (pinnedChats.isNotEmpty) ...[
          ...pinnedChats.map((chat) => _buildChatTile(
                context,
                ref,
                chat,
                isPinned: true,
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Divider(color: AppColors.dividerColor, height: 1),
          ),
        ],

        // Regular Chats
        ...regularChats.map((chat) => _buildChatTile(context, ref, chat)),
      ],
    );
  }

  Widget _buildChatTile(
    BuildContext context,
    WidgetRef ref,
    chat, {
    bool isPinned = false,
  }) {
    return InkWell(
      onTap: () {
        ref.read(selectedChatProvider.notifier).state = chat;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(chat: chat),
          ),
        );
      },
      onLongPress: () => _showChatOptions(context, ref, chat),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border(
            bottom: BorderSide(color: AppColors.dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: _getAvatarColor(chat.getAvatarColorIndex()),
                  child: Text(
                    chat.getInitials(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: AppColors.onlineColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.backgroundColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (isPinned)
                            Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Icon(
                                Icons.push_pin,
                                color: AppColors.greyColor,
                                size: 14.sp,
                              ),
                            ),
                          Text(
                            chat.name,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateUtil.formatChatTime(chat.lastMessageTime),
                        style: TextStyle(
                          color: chat.unreadCount > 0
                              ? AppColors.tealGreen
                              : AppColors.greyColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (chat.isMuted)
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Icon(
                                  Icons.volume_off,
                                  color: AppColors.greyColor,
                                  size: 16.sp,
                                ),
                              ),
                            Expanded(
                              child: Text(
                                chat.lastMessage,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.tealGreen,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(int index) {
    final colors = [
      const Color(0xFFE91E63),
      const Color(0xFF9C27B0),
      const Color(0xFF3F51B5),
      const Color(0xFF2196F3),
      const Color(0xFF009688),
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
      const Color(0xFFFF5722),
    ];
    return colors[index % colors.length];
  }

  void _showChatOptions(BuildContext context, WidgetRef ref, chat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              chat.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
              color: AppColors.textColor,
            ),
            title: Text(
              chat.isPinned ? 'Unpin chat' : 'Pin chat',
              style: TextStyle(color: AppColors.textColor),
            ),
            onTap: () {
              ref.read(chatProvider.notifier).togglePin(chat.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              chat.isMuted ? Icons.volume_up : Icons.volume_off,
              color: AppColors.textColor,
            ),
            title: Text(
              chat.isMuted ? 'Unmute notifications' : 'Mute notifications',
              style: TextStyle(color: AppColors.textColor),
            ),
            onTap: () {
              ref.read(chatProvider.notifier).toggleMute(chat.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.archive, color: AppColors.textColor),
            title: Text(
              'Archive chat',
              style: TextStyle(color: AppColors.textColor),
            ),
            onTap: () {
              ref.read(chatProvider.notifier).archiveChat(chat.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: AppColors.errorRed),
            title: Text(
              'Delete chat',
              style: TextStyle(color: AppColors.errorRed),
            ),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, ref, chat);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, chat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.appBarColor,
        title: Text('Delete chat?', style: TextStyle(color: AppColors.textColor)),
        content: Text(
          'Are you sure you want to delete this chat with ${chat.name}?',
          style: TextStyle(color: AppColors.greyColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: TextStyle(color: AppColors.tealGreen)),
          ),
          TextButton(
            onPressed: () {
              ref.read(chatProvider.notifier).deleteChat(chat.id);
              Navigator.pop(context);
            },
            child: Text('DELETE', style: TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }
}
