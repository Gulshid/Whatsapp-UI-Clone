import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/status_provider.dart';
import '../utils/app_colors.dart';
import '../utils/date_util.dart';

class StatusTab extends ConsumerWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusNotifier = ref.read(statusProvider.notifier);
    final myStatus = statusNotifier.myStatus;
    final recentUpdates = statusNotifier.recentUpdates;
    final viewedUpdates = statusNotifier.viewedUpdates;

    return ListView(
      children: [
        // My Status
        Container(
          color: AppColors.backgroundColor,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: AppColors.tealGreen,
                  child: Icon(Icons.person, size: 30.sp, color: Colors.white),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: AppColors.tealGreen,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundColor,
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              'My status',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              myStatus.statusItems.isNotEmpty
                  ? DateUtil.formatStatusTime(myStatus.timestamp)
                  : 'Tap to add status update',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14.sp,
              ),
            ),
            onTap: () {
              _showAddStatusDialog(context, ref);
            },
          ),
        ),
        
        SizedBox(height: 8.h),

        // Recent updates
        if (recentUpdates.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Text(
              'Recent updates',
              style: TextStyle(
                color: AppColors.greyDarkColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...recentUpdates.map((status) => _buildStatusItem(context, ref, status)),
        ],

        // Viewed updates
        if (viewedUpdates.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Text(
              'Viewed updates',
              style: TextStyle(
                color: AppColors.greyDarkColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...viewedUpdates.map((status) => _buildStatusItem(context, ref, status)),
        ],
      ],
    );
  }

  Widget _buildStatusItem(BuildContext context, WidgetRef ref, status) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: status.hasUnviewed
                  ? AppColors.tealGreen
                  : AppColors.greyDarkColor,
              width: 2.5.w,
            ),
          ),
          child: CircleAvatar(
            radius: 25.r,
            backgroundColor: _getAvatarColor(status.userName.codeUnitAt(0) % 8),
            child: Text(
              status.getInitials(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        title: Text(
          status.userName,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          DateUtil.formatStatusTime(status.timestamp),
          style: TextStyle(
            color: AppColors.greyColor,
            fontSize: 14.sp,
          ),
        ),
        onTap: () {
          // Mark first unviewed item as viewed
          if (status.hasUnviewed) {
            final firstUnviewed = status.statusItems.firstWhere((item) => !item.isViewed);
            ref.read(statusProvider.notifier).markAsViewed(status.id, firstUnviewed.id);
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing ${status.userName}\'s status'),
              backgroundColor: AppColors.appBarColor,
              duration: const Duration(seconds: 1),
            ),
          );
        },
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

  void _showAddStatusDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.appBarColor,
        title: Text('Add status', style: TextStyle(color: AppColors.textColor)),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.textColor),
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Type a status...',
            hintStyle: TextStyle(color: AppColors.greyColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
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
              if (controller.text.trim().isNotEmpty) {
                ref.read(statusProvider.notifier).addMyStatus(controller.text.trim());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Status added successfully!'),
                    backgroundColor: AppColors.appBarColor,
                  ),
                );
              }
            },
            child: Text('Add', style: TextStyle(color: AppColors.tealGreen)),
          ),
        ],
      ),
    );
  }
}
