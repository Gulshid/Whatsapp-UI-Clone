import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/chat.dart';
import '../utils/app_colors.dart';

class ContactInfoScreen extends StatelessWidget {
  final Chat chat;

  const ContactInfoScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact info',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              color: AppColors.appBarColor,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80.r,
                    backgroundColor: _getAvatarColor(chat.getAvatarColorIndex()),
                    child: Text(
                      chat.getInitials(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    chat.name,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    chat.phoneNumber,
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.call,
                        label: 'Audio',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Voice call feature coming soon!'),
                              backgroundColor: AppColors.appBarColor,
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.videocam,
                        label: 'Video',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Video call feature coming soon!'),
                              backgroundColor: AppColors.appBarColor,
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.search,
                        label: 'Search',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Search feature coming soon!'),
                              backgroundColor: AppColors.appBarColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // About Section
            Container(
              color: AppColors.appBarColor,
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    chat.about ?? 'Hey there! I am using WhatsApp.',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // Media Section
            Container(
              color: AppColors.appBarColor,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.image, color: AppColors.greyColor),
                    title: Text(
                      'Media, links, and docs',
                      style: TextStyle(color: AppColors.textColor, fontSize: 16.sp),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(color: AppColors.greyColor, fontSize: 14.sp),
                        ),
                        Icon(Icons.chevron_right, color: AppColors.greyColor),
                      ],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Media feature coming soon!'),
                          backgroundColor: AppColors.appBarColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // Options Section
            Container(
              color: AppColors.appBarColor,
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.notifications,
                    title: chat.isMuted ? 'Unmute notifications' : 'Mute notifications',
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.music_note,
                    title: 'Custom notifications',
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.photo,
                    title: 'Media visibility',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // Encryption Section
            Container(
              color: AppColors.appBarColor,
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(Icons.lock, color: AppColors.greyColor, size: 20.sp),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Encryption',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Messages and calls are end-to-end encrypted. Tap to verify.',
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // Disappearing Messages
            Container(
              color: AppColors.appBarColor,
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.timelapse,
                    title: 'Disappearing messages',
                    subtitle: 'Off',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // Group Section
            Container(
              color: AppColors.appBarColor,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.group, color: AppColors.greyColor),
                    title: Text(
                      '0 groups in common',
                      style: TextStyle(color: AppColors.textColor, fontSize: 16.sp),
                    ),
                    trailing: Icon(Icons.chevron_right, color: AppColors.greyColor),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Groups feature coming soon!'),
                          backgroundColor: AppColors.appBarColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            
            // Action Buttons
            Container(
              color: AppColors.appBarColor,
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.block,
                    title: 'Block ${chat.name}',
                    titleColor: AppColors.errorRed,
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.thumb_down,
                    title: 'Report ${chat.name}',
                    titleColor: AppColors.errorRed,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
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

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.chatBarMessage,
            child: Icon(icon, color: AppColors.tealGreen, size: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: titleColor ?? AppColors.greyColor),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? AppColors.textColor,
          fontSize: 16.sp,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 13.sp,
              ),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: AppColors.greyColor),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title feature coming soon!'),
            backgroundColor: AppColors.appBarColor,
          ),
        );
      },
    );
  }
}
