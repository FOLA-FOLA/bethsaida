import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  final CameraDescription camera;
  final Function(CameraController)? onCameraInitialized;
  
  const CameraPreviewWidget({
    Key? key,
    required this.camera,
    this.onCameraInitialized,
  }) : super(key: key);
  
  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: true,
    );
    
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (widget.onCameraInitialized != null) {
        widget.onCameraInitialized!(_controller);
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else if (snapshot.hasError) {
          return Container(
            color: const Color(0xFF1E1E1E),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 80,
                    color: Colors.white54,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Camera not available',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            color: const Color(0xFF1E1E1E),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00D4AA),
              ),
            ),
          );
        }
      },
    );
  }
}