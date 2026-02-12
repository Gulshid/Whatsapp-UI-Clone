class AppConstants {
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String chatsCollection = 'chats';
  static const String messagesCollection = 'messages';
  static const String statusCollection = 'status';
  static const String callsCollection = 'calls';
  static const String groupsCollection = 'groups';
  
  // Storage Paths
  static const String profilePicsPath = 'profilePics';
  static const String chatImagesPath = 'chatImages';
  static const String chatVideosPath = 'chatVideos';
  static const String chatDocumentsPath = 'chatDocuments';
  static const String chatAudiosPath = 'chatAudios';
  static const String statusImagesPath = 'statusImages';
  static const String statusVideosPath = 'statusVideos';
  
  // Message Types
  static const String textMessage = 'text';
  static const String imageMessage = 'image';
  static const String videoMessage = 'video';
  static const String audioMessage = 'audio';
  static const String documentMessage = 'document';
  static const String contactMessage = 'contact';
  static const String locationMessage = 'location';
  
  // Call Types
  static const String audioCall = 'audio';
  static const String videoCall = 'video';
  
  // Status Types
  static const String imageStatus = 'image';
  static const String videoStatus = 'video';
  static const String textStatus = 'text';
  
  // User Status
  static const String online = 'online';
  static const String offline = 'offline';
  static const String typing = 'typing';
  
  // Max File Sizes (in bytes)
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
  static const int maxDocumentSize = 100 * 1024 * 1024; // 100MB
  static const int maxAudioSize = 16 * 1024 * 1024; // 16MB
  
  // Status Duration
  static const Duration statusDuration = Duration(hours: 24);
  
  // Message Limits
  static const int messageLimit = 50;
  static const int groupMemberLimit = 256;
  
  // App Info
  static const String appName = 'WhatsApp Clone';
  static const String appVersion = '1.0.0';
  
  // Asset Paths
  static const String defaultUserImage = 'assets/images/default_user.png';
  static const String defaultGroupImage = 'assets/images/default_group.png';
  static const String chatBackground = 'assets/images/chat_background.png';
  
  // Sound Paths
  static const String messageSentSound = 'assets/sounds/message_sent.mp3';
  static const String messageReceivedSound = 'assets/sounds/message_received.mp3';
  static const String notificationSound = 'assets/sounds/notification.mp3';
}

class ErrorMessages {
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String authError = 'Authentication failed. Please try again.';
  static const String userNotFound = 'User not found.';
  static const String invalidCredentials = 'Invalid credentials.';
  static const String weakPassword = 'Password is too weak.';
  static const String emailInUse = 'Email is already in use.';
  static const String phoneInUse = 'Phone number is already in use.';
  static const String invalidPhoneNumber = 'Invalid phone number.';
  static const String invalidOTP = 'Invalid OTP code.';
  static const String permissionDenied = 'Permission denied.';
  static const String fileTooBig = 'File is too large.';
  static const String invalidFileType = 'Invalid file type.';
  static const String unknown = 'An unknown error occurred.';
}

class SuccessMessages {
  static const String accountCreated = 'Account created successfully!';
  static const String messageSent = 'Message sent successfully!';
  static const String statusUploaded = 'Status uploaded successfully!';
  static const String profileUpdated = 'Profile updated successfully!';
}
