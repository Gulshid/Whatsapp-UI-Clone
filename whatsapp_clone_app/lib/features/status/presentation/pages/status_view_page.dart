import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusViewPage extends ConsumerWidget {
  final List statusList;
  final int initialIndex;

  const StatusViewPage({
    super.key,
    required this.statusList,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const Center(
        child: Text('Status view'),
      ),
    );
  }
}
