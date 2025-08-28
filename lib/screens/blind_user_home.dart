import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'call_screen.dart';
import 'settings_screen.dart';
import '../widgets/custom_button.dart';

class BlindUserHomeScreen extends StatefulWidget {
  final String language;
  final Map<String, String> translations;
  
  const BlindUserHomeScreen({
    Key? key,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  State<BlindUserHomeScreen> createState() => _BlindUserHomeScreenState();
}

class _BlindUserHomeScreenState extends State<BlindUserHomeScreen> {
  bool _isCalling = false;
  
  @override
  Widget build(BuildContext context) {
    final t = widget.translations;
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(t['appTitle']!),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    language: widget.language,
                    translations: widget.translations,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Illustration
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1E1E1E),
                    border: Border.all(
                      color: const Color(0xFF00D4AA),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.remove_red_eye,
                    size: 60,
                    color: Color(0xFF00D4AA),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                const Text(
                  'Need assistance?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                const Text(
                  'Connect with a volunteer who can help you with visual tasks',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFB0B0B0),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const Spacer(),
                
                CustomButton(
                  text: 'Call for Help',
                  onPressed: () {
                    setState(() {
                      _isCalling = true;
                    });
                    
                    // Simulate connecting to a volunteer
                    Future.delayed(const Duration(seconds: 3), () {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallScreen(
                              camera: const CameraDescription(
                                name: 'mock_camera',
                                lensDirection: CameraLensDirection.back,
                                sensorOrientation: 0,
                              ),
                              isVolunteer: false,
                              language: widget.language,
                              translations: widget.translations,
                            ),
                          ),
                        ).then((_) {
                          if (mounted) {
                            setState(() {
                              _isCalling = false;
                            });
                          }
                        });
                      }
                    });
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextButton(
                  onPressed: () {
                    // Re-read guidelines
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reading guidelines aloud...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Review Guidelines'),
                ),
              ],
            ),
          ),
          
          if (_isCalling)
            Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4AA)),
                        strokeWidth: 3,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Connecting you to a volunteer...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isCalling = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}