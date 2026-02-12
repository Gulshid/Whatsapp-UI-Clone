import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
  
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
  
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
  
  static Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }
  
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions() async {
    return await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
      Permission.contacts,
    ].request();
  }
}
