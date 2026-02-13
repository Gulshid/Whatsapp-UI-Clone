import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../widgets/chats_tab.dart';
import '../widgets/status_tab.dart';
import '../widgets/calls_tab.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'Search',
          style: TextStyle(color: AppColors.textColor),
        ),
        content: TextField(
          style: TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            hintText: 'Search for messages...',
            hintStyle: TextStyle(color: AppColors.greyColor),
            prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.tealGreen),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.tealGreen)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Search feature coming soon!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
            child: Text('Search', style: TextStyle(color: AppColors.tealGreen)),
          ),
        ],
      ),
    );
  }

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.textColor),
              title: Text('Take Photo', style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Camera feature coming soon!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam, color: AppColors.textColor),
              title: Text('Take Video', style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Video camera feature coming soon!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined, color: AppColors.greyColor, size: 24.sp),
            onPressed: _showCameraOptions,
          ),
          IconButton(
            icon: Icon(Icons.search, color: AppColors.greyColor, size: 24.sp),
            onPressed: _showSearchDialog,
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.greyColor, size: 24.sp),
            color: AppColors.appBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              switch (value) {
                case 'new_group':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('New group feature coming soon!'),
                      backgroundColor: AppColors.appBarColor,
                    ),
                  );
                  break;
                case 'new_broadcast':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('New broadcast feature coming soon!'),
                      backgroundColor: AppColors.appBarColor,
                    ),
                  );
                  break;
                case 'linked_devices':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Linked devices feature coming soon!'),
                      backgroundColor: AppColors.appBarColor,
                    ),
                  );
                  break;
                case 'starred':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Starred messages feature coming soon!'),
                      backgroundColor: AppColors.appBarColor,
                    ),
                  );
                  break;
                case 'payments':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Payments feature coming soon!'),
                      backgroundColor: AppColors.appBarColor,
                    ),
                  );
                  break;
                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'new_group',
                  child: Row(
                    children: [
                      Icon(Icons.group, color: AppColors.greyColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text('New group', style: TextStyle(color: AppColors.textColor, fontSize: 14.sp)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'new_broadcast',
                  child: Row(
                    children: [
                      Icon(Icons.broadcast_on_home, color: AppColors.greyColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text('New broadcast', style: TextStyle(color: AppColors.textColor, fontSize: 14.sp)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'linked_devices',
                  child: Row(
                    children: [
                      Icon(Icons.devices, color: AppColors.greyColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text('Linked devices', style: TextStyle(color: AppColors.textColor, fontSize: 14.sp)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'starred',
                  child: Row(
                    children: [
                      Icon(Icons.star, color: AppColors.greyColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text('Starred messages', style: TextStyle(color: AppColors.textColor, fontSize: 14.sp)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'payments',
                  child: Row(
                    children: [
                      Icon(Icons.payment, color: AppColors.greyColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text('Payments', style: TextStyle(color: AppColors.textColor, fontSize: 14.sp)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: AppColors.greyColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text('Settings', style: TextStyle(color: AppColors.textColor, fontSize: 14.sp)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.h,
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'UPDATES'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatsTab(),
          StatusTab(),
          CallsTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_currentIndex) {
      case 0: // Chats
        return FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('New chat feature coming soon!'),
                backgroundColor: AppColors.appBarColor,
              ),
            );
          },
          child: const Icon(Icons.chat),
        );
      case 1: // Updates
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              mini: true,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Text status feature coming soon!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              },
              backgroundColor: AppColors.appBarColor,
              child: Icon(Icons.edit, color: AppColors.greyColor),
            ),
            SizedBox(height: 10.h),
            FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Camera status feature coming soon!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              },
              child: const Icon(Icons.camera_alt),
            ),
          ],
        );
      case 2: // Calls
        return FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('New call feature coming soon!'),
                backgroundColor: AppColors.appBarColor,
              ),
            );
          },
          child: const Icon(Icons.add_ic_call),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
