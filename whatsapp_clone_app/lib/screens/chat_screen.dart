import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../providers/chat_provider.dart';
import '../utils/app_colors.dart';
import '../utils/date_util.dart';
import 'contact_info_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isRecording = false;
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).markAsRead(widget.chat.id);
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      ref.read(chatProvider.notifier).sendMessage(
            widget.chat.id,
            _messageController.text.trim(),
          );
      _messageController.clear();

      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    }
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetOption(
            icon: Icons.volume_off,
            title: widget.chat.isMuted ? 'Unmute notifications' : 'Mute notifications',
            onTap: () {
              ref.read(chatProvider.notifier).toggleMute(widget.chat.id);
              Navigator.pop(context);
            },
          ),
          _buildBottomSheetOption(
            icon: Icons.wallpaper,
            title: 'Wallpaper',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Wallpaper feature coming soon!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          _buildBottomSheetOption(
            icon: Icons.archive,
            title: 'Archive chat',
            onTap: () {
              ref.read(chatProvider.notifier).archiveChat(widget.chat.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          _buildBottomSheetOption(
            icon: Icons.delete,
            title: 'Delete chat',
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation();
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.appBarColor,
        title: Text('Delete chat?', style: TextStyle(color: AppColors.textColor)),
        content: Text(
          'Are you sure you want to delete this chat?',
          style: TextStyle(color: AppColors.greyColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: TextStyle(color: AppColors.tealGreen)),
          ),
          TextButton(
            onPressed: () {
              ref.read(chatProvider.notifier).deleteChat(widget.chat.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('DELETE', style: TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textColor),
      title: Text(title, style: TextStyle(color: AppColors.textColor)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatProvider);
    final currentChat = chats.firstWhere((c) => c.id == widget.chat.id, 
        orElse: () => widget.chat);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70.w,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.textColor),
              onPressed: () => Navigator.pop(context),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactInfoScreen(chat: currentChat),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: _getAvatarColor(currentChat.getAvatarColorIndex()),
                child: Text(
                  currentChat.getInitials(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactInfoScreen(chat: currentChat),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentChat.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                currentChat.isOnline
                    ? 'online'
                    : currentChat.lastSeen ?? 'last seen recently',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: AppColors.greyColor, size: 24.sp),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Video call feature coming soon!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.call, color: AppColors.greyColor, size: 24.sp),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Voice call feature coming soon!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.greyColor, size: 24.sp),
            color: AppColors.appBarColor,
            onSelected: (value) {
              if (value == 'view_contact') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactInfoScreen(chat: currentChat),
                  ),
                );
              } else if (value == 'more') {
                _showChatOptions();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$value feature coming soon!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'view_contact',
                  child: Text('View contact', style: TextStyle(color: AppColors.textColor)),
                ),
                PopupMenuItem(
                  value: 'media',
                  child: Text('Media, links, and docs', style: TextStyle(color: AppColors.textColor)),
                ),
                PopupMenuItem(
                  value: 'search',
                  child: Text('Search', style: TextStyle(color: AppColors.textColor)),
                ),
                PopupMenuItem(
                  value: 'disappearing',
                  child: Text('Disappearing messages', style: TextStyle(color: AppColors.textColor)),
                ),
                PopupMenuItem(
                  value: 'more',
                  child: Text('More', style: TextStyle(color: AppColors.textColor)),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          image: DecorationImage(
            image: const NetworkImage('https://i.imgur.com/qLXfQGX.png'),
            fit: BoxFit.cover,
            opacity: 0.06,
            colorFilter: ColorFilter.mode(
              AppColors.backgroundColor,
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                itemCount: currentChat.messages.length,
                itemBuilder: (context, index) {
                  final message = currentChat.messages[index];
                  final showDateDivider = index == 0 ||
                      !_isSameDay(
                        message.timestamp,
                        currentChat.messages[index - 1].timestamp,
                      );

                  return Column(
                    children: [
                      if (showDateDivider) _buildDateDivider(message.timestamp),
                      _buildMessageBubble(message),
                    ],
                  );
                },
              ),
            ),
            _buildInputArea(),
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

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildDateDivider(DateTime dateTime) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.senderMessageColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          DateUtil.getDateDivider(dateTime),
          style: TextStyle(
            color: AppColors.greyColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(message),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
            minWidth: 80.w,
          ),
          decoration: BoxDecoration(
            color: message.isSentByMe
                ? AppColors.messageColor
                : AppColors.senderMessageColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
              bottomLeft: message.isSentByMe ? Radius.circular(8.r) : Radius.zero,
              bottomRight: message.isSentByMe ? Radius.zero : Radius.circular(8.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 50.w, bottom: 4.h),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: TextStyle(
                      color: message.isSentByMe
                          ? AppColors.messageTimeColor
                          : AppColors.greyColor,
                      fontSize: 11.sp,
                    ),
                  ),
                  if (message.isSentByMe) ...[
                    SizedBox(width: 4.w),
                    _buildMessageStatusIcon(message.status),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.pending:
        return Icon(Icons.access_time, size: 14.sp, color: AppColors.greyColor);
      case MessageStatus.sent:
        return Icon(Icons.check, size: 16.sp, color: AppColors.greyColor);
      case MessageStatus.delivered:
        return Icon(Icons.done_all, size: 16.sp, color: AppColors.greyColor);
      case MessageStatus.read:
        return Icon(Icons.done_all, size: 16.sp, color: AppColors.messageReadColor);
    }
  }

  void _showMessageOptions(Message message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetOption(
            icon: Icons.reply,
            title: 'Reply',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Reply feature coming soon!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          _buildBottomSheetOption(
            icon: Icons.copy,
            title: 'Copy',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Text copied!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          _buildBottomSheetOption(
            icon: Icons.star,
            title: 'Star',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Message starred!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          if (message.isSentByMe)
            _buildBottomSheetOption(
              icon: Icons.delete,
              title: 'Delete',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Message deleted!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      color: AppColors.appBarColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.chatBarMessage,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined,
                        color: AppColors.greyColor, size: 24.sp),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Emoji picker coming soon!'),
                          backgroundColor: AppColors.appBarColor,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: AppColors.textColor, fontSize: 15.sp),
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 15.sp),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      onChanged: (text) => setState(() {}),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file, color: AppColors.greyColor, size: 24.sp),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Attach file feature coming soon!'),
                          backgroundColor: AppColors.appBarColor,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: AppColors.greyColor, size: 24.sp),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Camera feature coming soon!'),
                          backgroundColor: AppColors.appBarColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4.w),
          CircleAvatar(
            backgroundColor: AppColors.tealGreen,
            radius: 24.r,
            child: IconButton(
              icon: Icon(
                _messageController.text.trim().isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
                size: 22.sp,
              ),
              onPressed: () {
                if (_messageController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Voice message feature coming soon!'),
                      backgroundColor: AppColors.appBarColor,
                    ),
                  );
                } else {
                  _sendMessage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
