class Status {
  final String id;
  final String userName;
  final String? profilePic;
  final List<StatusItem> statusItems;
  final DateTime timestamp;

  Status({
    required this.id,
    required this.userName,
    this.profilePic,
    required this.statusItems,
    required this.timestamp,
  });

  String getInitials() {
    final names = userName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return userName.length >= 2 ? userName.substring(0, 2).toUpperCase() : userName.toUpperCase();
  }

  bool get hasUnviewed => statusItems.any((item) => !item.isViewed);
  
  int get unviewedCount => statusItems.where((item) => !item.isViewed).length;
}

class StatusItem {
  final String id;
  final String? imageUrl;
  final String? caption;
  final DateTime timestamp;
  final bool isViewed;

  StatusItem({
    required this.id,
    this.imageUrl,
    this.caption,
    required this.timestamp,
    this.isViewed = false,
  });

  StatusItem copyWith({
    String? id,
    String? imageUrl,
    String? caption,
    DateTime? timestamp,
    bool? isViewed,
  }) {
    return StatusItem(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      timestamp: timestamp ?? this.timestamp,
      isViewed: isViewed ?? this.isViewed,
    );
  }
}
