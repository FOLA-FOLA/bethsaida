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
  
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }
  
  static Future<Map<String, bool>> requestAllPermissions() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.location,
    ].request();
    
    return {
      'camera': statuses[Permission.camera]!.isGranted,
      'microphone': statuses[Permission.microphone]!.isGranted,
      'location': statuses[Permission.location]!.isGranted,
    };
  }
}