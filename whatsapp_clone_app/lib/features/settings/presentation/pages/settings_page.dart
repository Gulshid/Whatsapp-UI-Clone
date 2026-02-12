import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.greyLight,
              child: Icon(Icons.person, size: 30.sp),
            ),
            title: const Text('User Name'),
            subtitle: const Text('Hey there! I am using WhatsApp.'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.key),
            title: Text('Account'),
            subtitle: Text('Security notifications, change number'),
          ),
          const ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy'),
            subtitle: Text('Block contacts, disappearing messages'),
          ),
          const ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chats'),
            subtitle: Text('Theme, wallpapers, chat history'),
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Message, group & call tones'),
          ),
          const ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Storage and data'),
            subtitle: Text('Network usage, auto-download'),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            subtitle: Text('Help center, contact us, privacy policy'),
          ),
        ],
      ),
    );
  }
}
