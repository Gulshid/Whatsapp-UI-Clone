import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
      body: ListView(
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.tealGreen,
                  child: Icon(Icons.person, size: 35.sp, color: Colors.white),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Name',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Hey there! I am using WhatsApp.',
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.qr_code, color: AppColors.tealGreen, size: 24.sp),
              ],
            ),
          ),
          Divider(color: AppColors.dividerColor, thickness: 1),
          
          // Settings Options
          _buildSettingTile(
            context,
            icon: Icons.key,
            title: 'Account',
            subtitle: 'Security notifications, change number',
          ),
          _buildSettingTile(
            context,
            icon: Icons.lock,
            title: 'Privacy',
            subtitle: 'Block contacts, disappearing messages',
          ),
          _buildSettingTile(
            context,
            icon: Icons.favorite,
            title: 'Avatar',
            subtitle: 'Create, edit, profile photo',
          ),
          _buildSettingTile(
            context,
            icon: Icons.chat,
            title: 'Chats',
            subtitle: 'Theme, wallpapers, chat history',
          ),
          _buildSettingTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Message, group & call tones',
          ),
          _buildSettingTile(
            context,
            icon: Icons.data_usage,
            title: 'Storage and data',
            subtitle: 'Network usage, auto-download',
          ),
          _buildSettingTile(
            context,
            icon: Icons.language,
            title: 'App language',
            subtitle: 'English (device\'s language)',
          ),
          _buildSettingTile(
            context,
            icon: Icons.help,
            title: 'Help',
            subtitle: 'Help center, contact us, privacy policy',
          ),
          _buildSettingTile(
            context,
            icon: Icons.group,
            title: 'Invite a friend',
            subtitle: '',
          ),
          
          SizedBox(height: 20.h),
          Center(
            child: Column(
              children: [
                Text(
                  'from',
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, color: AppColors.greyColor, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Meta',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.greyColor, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textColor,
          fontSize: 16.sp,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 13.sp,
              ),
            )
          : null,
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
