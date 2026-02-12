import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusConfirmPage extends ConsumerWidget {
  final dynamic file;
  final String type;

  const StatusConfirmPage({
    super.key,
    required this.file,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const Center(
        child: Text('Status confirm'),
      ),
    );
  }
}
