import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallsListPage extends ConsumerWidget {
  const CallsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Recent calls will appear here'),
    );
  }
}
