import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/call.dart';
import '../providers/call_provider.dart';
import '../utils/app_colors.dart';
import '../utils/date_util.dart';

class CallsTab extends ConsumerWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calls = ref.watch(callProvider);

    if (calls.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.call,
              size: 80.sp,
              color: AppColors.greyDarkColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'No calls yet',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Make a call to get started',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        return _buildCallItem(context, ref, call);
      },
    );
  }

  Widget _buildCallItem(BuildContext context, WidgetRef ref, Call call) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Calling ${call.name}...'),
            backgroundColor: AppColors.appBarColor,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      onLongPress: () => _showCallOptions(context, ref, call),
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
            CircleAvatar(
              radius: 28.r,
              backgroundColor: _getAvatarColor(call.name.codeUnitAt(0) % 8),
              child: Text(
                call.getInitials(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.name,
                    style: TextStyle(
                      color: call.status == CallStatus.missed
                          ? AppColors.errorRed
                          : AppColors.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        _getCallStatusIcon(call),
                        size: 16.sp,
                        color: call.status == CallStatus.missed
                            ? AppColors.errorRed
                            : AppColors.tealGreen,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          call.duration != null
                              ? '${DateUtil.formatCallTime(call.timestamp)}, ${call.duration}'
                              : DateUtil.formatCallTime(call.timestamp),
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                call.type == CallType.video
                    ? Icons.videocam
                    : Icons.call,
                color: AppColors.tealGreen,
                size: 24.sp,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${call.type == CallType.video ? 'Video' : 'Voice'} calling ${call.name}...',
                    ),
                    backgroundColor: AppColors.appBarColor,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCallStatusIcon(Call call) {
    switch (call.status) {
      case CallStatus.incoming:
        return Icons.call_received;
      case CallStatus.outgoing:
        return Icons.call_made;
      case CallStatus.missed:
        return Icons.call_missed;
    }
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

  void _showCallOptions(BuildContext context, WidgetRef ref, Call call) {
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
            leading: Icon(Icons.info_outline, color: AppColors.textColor),
            title: Text(
              'Call info',
              style: TextStyle(color: AppColors.textColor),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Call info feature coming soon!'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: AppColors.errorRed),
            title: Text(
              'Delete call log',
              style: TextStyle(color: AppColors.errorRed),
            ),
            onTap: () {
              ref.read(callProvider.notifier).deleteCall(call.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Call log deleted'),
                  backgroundColor: AppColors.appBarColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
