import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/status.dart';

class StatusNotifier extends StateNotifier<List<Status>> {
  StatusNotifier() : super(_initialStatuses);

  static final List<Status> _initialStatuses = [
    Status(
      id: 'my_status',
      userName: 'My status',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'Having a great day!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isViewed: true,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Status(
      id: '1',
      userName: 'Mom ❤️',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'Beautiful sunset 🌅',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          isViewed: false,
        ),
        StatusItem(
          id: '2',
          caption: 'Family dinner tonight',
          timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
          isViewed: false,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Status(
      id: '2',
      userName: 'Alex Thompson',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'At the gym 💪',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          isViewed: false,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Status(
      id: '3',
      userName: 'Emma Wilson',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'Coffee time ☕',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isViewed: false,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Status(
      id: '4',
      userName: 'Sarah Martinez',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'Weekend vibes!',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          isViewed: true,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Status(
      id: '5',
      userName: 'James Rodriguez',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'New project launch 🚀',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          isViewed: true,
        ),
        StatusItem(
          id: '2',
          caption: 'Team celebration',
          timestamp: DateTime.now().subtract(const Duration(hours: 7)),
          isViewed: true,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Status(
      id: '6',
      userName: 'Mike Johnson',
      statusItems: [
        StatusItem(
          id: '1',
          caption: 'Coding session',
          timestamp: DateTime.now().subtract(const Duration(hours: 10)),
          isViewed: true,
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(hours: 10)),
    ),
  ];

  void markAsViewed(String statusId, String itemId) {
    state = state.map((status) {
      if (status.id == statusId) {
        final updatedItems = status.statusItems.map((item) {
          if (item.id == itemId) {
            return item.copyWith(isViewed: true);
          }
          return item;
        }).toList();
        return Status(
          id: status.id,
          userName: status.userName,
          profilePic: status.profilePic,
          statusItems: updatedItems,
          timestamp: status.timestamp,
        );
      }
      return status;
    }).toList();
  }

  void addMyStatus(String caption) {
    state = state.map((status) {
      if (status.id == 'my_status') {
        final newItem = StatusItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          caption: caption,
          timestamp: DateTime.now(),
          isViewed: true,
        );
        return Status(
          id: status.id,
          userName: status.userName,
          profilePic: status.profilePic,
          statusItems: [...status.statusItems, newItem],
          timestamp: DateTime.now(),
        );
      }
      return status;
    }).toList();
  }

  Status get myStatus => state.firstWhere((s) => s.id == 'my_status');
  
  List<Status> get recentUpdates => 
      state.where((s) => s.id != 'my_status' && s.hasUnviewed).toList();
  
  List<Status> get viewedUpdates => 
      state.where((s) => s.id != 'my_status' && !s.hasUnviewed).toList();
}

final statusProvider = StateNotifierProvider<StatusNotifier, List<Status>>((ref) {
  return StatusNotifier();
});
