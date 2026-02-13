import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/call.dart';

class CallNotifier extends StateNotifier<List<Call>> {
  CallNotifier() : super(_initialCalls);

  static final List<Call> _initialCalls = [
    Call(
      id: '1',
      name: 'Mom ❤️',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      type: CallType.video,
      status: CallStatus.incoming,
      duration: '15:23',
    ),
    Call(
      id: '2',
      name: 'Alex Thompson',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: CallType.voice,
      status: CallStatus.outgoing,
      duration: '8:45',
    ),
    Call(
      id: '3',
      name: 'Emma Wilson',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      type: CallType.video,
      status: CallStatus.missed,
    ),
    Call(
      id: '4',
      name: 'Dad',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: CallType.voice,
      status: CallStatus.outgoing,
      duration: '25:10',
    ),
    Call(
      id: '5',
      name: 'Sarah Martinez',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      type: CallType.video,
      status: CallStatus.incoming,
      duration: '42:33',
    ),
    Call(
      id: '6',
      name: 'James Rodriguez',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: CallType.voice,
      status: CallStatus.outgoing,
      duration: '5:20',
    ),
    Call(
      id: '7',
      name: 'Mike Johnson',
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      type: CallType.video,
      status: CallStatus.missed,
    ),
    Call(
      id: '8',
      name: 'Emma Wilson',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      type: CallType.voice,
      status: CallStatus.incoming,
      duration: '12:15',
    ),
  ];

  void addCall(Call call) {
    state = [call, ...state];
  }

  void deleteCall(String callId) {
    state = state.where((call) => call.id != callId).toList();
  }

  void clearAllCalls() {
    state = [];
  }
}

final callProvider = StateNotifierProvider<CallNotifier, List<Call>>((ref) {
  return CallNotifier();
});
