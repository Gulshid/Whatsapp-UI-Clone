import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallScreenPage extends ConsumerWidget {
  final String callId;
  final bool isGroupCall;
  final bool isVideoCall;

  const CallScreenPage({
    super.key,
    required this.callId,
    required this.isGroupCall,
    required this.isVideoCall,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const Center(
        child: Text('Call screen'),
      ),
    );
  }
}
