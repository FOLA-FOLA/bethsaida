import 'package:flutter/material.dart';
import 'guidelines_screen.dart';
import 'call_screen.dart';
import 'settings_screen.dart';
import '../widgets/custom_button.dart';

class VolunteerHomeScreen extends StatefulWidget {
  final String language;
  final Map<String, String> translations;
  
  const VolunteerHomeScreen({
    Key? key,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> {
  bool _isAvailable = true;
  bool _hasCall = false;
  
  @override
  Widget build(BuildContext context) {
    final t = widget.translations;
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text('${t['appTitle']} Volunteer'),
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Status indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _isAvailable 
                    ? const Color(0xFF00D4AA).withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isAvailable ? const Color(0xFF00D4AA) : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isAvailable ? 'Available to help' : 'Not available',
                    style: TextStyle(
                      color: _isAvailable ? const Color(0xFF00D4AA) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
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
                Icons.visibility,
                size: 60,
                color: Color(0xFF00D4AA),
              ),
            ),
            
            const SizedBox(height: 32),
            
            Text(
              _hasCall ? 'Someone needs your help!' : 'Ready to help',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              _hasCall 
                  ? 'A user is waiting for assistance'
                  : 'You will be notified when someone needs help',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFB0B0B0),
              ),
              textAlign: TextAlign.center,
            ),
            
            const Spacer(),
            
            if (!_hasCall) ...[
              CustomButton(
                text: 'Learn How to Help',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuidelinesScreen(
                        language: widget.language,
                        translations: widget.translations,
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
            ],
            
            CustomButton(
              text: _hasCall ? 'Answer Call' : 'Waiting for call...',
              variant: _hasCall ? ButtonVariant.primary : ButtonVariant.secondary,
              onPressed: _hasCall
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(
                            camera: const CameraDescription(
                              name: 'mock_camera',
                              lensDirection: CameraLensDirection.back,
                              sensorOrientation: 0,
                            ),
                            isVolunteer: true,
                            language: widget.language,
                            translations: widget.translations,
                          ),
                        ),
                      );
                    }
                  : null,
            ),
            
            const SizedBox(height: 16),
            
            SwitchListTile(
              title: const Text(
                'Available to receive calls',
                style: TextStyle(color: Colors.white),
              ),
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value;
                });
              },
              activeColor: const Color(0xFF00D4AA),
            ),
          ],
        ),
      ),
    );
  }
}