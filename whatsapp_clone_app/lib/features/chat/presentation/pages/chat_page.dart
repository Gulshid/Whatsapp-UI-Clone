import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';


class ChatPage extends ConsumerStatefulWidget {
  final String userId;
  final String userName;
  final String? userImage;

  const ChatPage({
    super.key,
    required this.userId,
    required this.userName,
    this.userImage,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.userImage != null
                  ? NetworkImage(widget.userImage!)
                  : null,
              radius: 20.r,
              backgroundColor: AppColors.greyLight,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Text(
                    'online',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text('Messages will appear here'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.greyLight,
                      prefixIcon: const Icon(Icons.emoji_emotions),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.attach_file),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  backgroundColor: AppColors.tealGreen,
                  radius: 25.r,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
