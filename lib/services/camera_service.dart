import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraService {
  static List<CameraDescription>? _cameras;
  
  static Future<void> initializeCameras() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      debugPrint('Error initializing cameras: $e');
    }
  }
  
  static List<CameraDescription>? get cameras => _cameras;
  
  static CameraDescription? get frontCamera {
    return _cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => _cameras!.first,
    );
  }
  
  static CameraDescription? get backCamera {
    return _cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras!.first,
    );
  }
}