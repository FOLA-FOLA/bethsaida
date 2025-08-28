import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CallScreen extends StatefulWidget {
  final CameraDescription camera;
  final bool isVolunteer;
  final String language;
  final Map<String, String> translations;
  
  const CallScreen({
    Key? key,
    required this.camera,
    required this.isVolunteer,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isVideoEnabled = true;
  bool _isAudioEnabled = true;
  Timer? _callTimer;
  int _callDuration = 0;
  
  @override
  void initState() {
    super.initState();
    _startCallTimer();
  }
  
  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _callDuration++;
      });
    });
  }
  
  String _formatCallDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  
  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final t = widget.translations;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera preview or volunteer view
            if (!widget.isVolunteer)
              Container(
                color: const Color(0xFF1E1E1E),
                child: const Center(
                  child: Icon(
                    Icons.videocam_off,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              )
            else
              Container(
                color: const Color(0xFF1E1E1E),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2A2A2A),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xFF00D4AA),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Connected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Language: ${widget.language}',
                        style: const TextStyle(
                          color: Color(0xFF00D4AA),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Top info bar for volunteer
            if (widget.isVolunteer)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF00D4AA),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Helping user from Nigeria',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _formatCallDuration(_callDuration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
            // Call controls
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Microphone toggle
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isAudioEnabled ? const Color(0xFF2A2A2A) : Colors.red,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isAudioEnabled ? Icons.mic : Icons.mic_off,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _isAudioEnabled = !_isAudioEnabled;
                        });
                      },
                    ),
                  ),
                  
                  // End call button
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  
                  // Camera toggle
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isVideoEnabled ? const Color(0xFF2A2A2A) : Colors.red,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _isVideoEnabled = !_isVideoEnabled;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Screen reader announcement for blind users
            if (!widget.isVolunteer)
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Call active. Double tap screen to speak.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}