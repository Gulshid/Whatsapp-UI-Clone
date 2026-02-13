enum CallType { voice, video }

enum CallStatus { incoming, outgoing, missed }

class Call {
  final String id;
  final String name;
  final String? profilePic;
  final DateTime timestamp;
  final CallType type;
  final CallStatus status;
  final String? duration;

  Call({
    required this.id,
    required this.name,
    this.profilePic,
    required this.timestamp,
    required this.type,
    required this.status,
    this.duration,
  });

  String getInitials() {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();
  }

  String getCallTypeText() {
    if (status == CallStatus.incoming) {
      return 'Incoming';
    } else if (status == CallStatus.outgoing) {
      return 'Outgoing';
    } else {
      return 'Missed';
    }
  }
}
