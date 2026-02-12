import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupChatPage extends ConsumerWidget {
  final String groupId;
  final String groupName;
  final String? groupImage;

  const GroupChatPage({
    super.key,
    required this.groupId,
    required this.groupName,
    this.groupImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: const Center(
        child: Text('Group chat page'),
      ),
    );
  }
}
