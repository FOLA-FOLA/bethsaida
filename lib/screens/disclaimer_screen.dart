import 'package:flutter/material.dart';
import 'blind_user_home.dart';
import '../widgets/custom_button.dart';

class DisclaimerScreen extends StatelessWidget {
  final String language;
  final Map<String, String> translations;
  
  const DisclaimerScreen({
    Key? key,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final t = translations;
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(t['appTitle']!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            Text(
              'Important Guidelines',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00D4AA),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Expanded(
              child: ListView(
                children: [
                  _buildGuidelineItem(
                    icon: Icons.people,
                    title: 'Respect Privacy',
                    description: 'Do not ask volunteers personal questions or request access to private information.',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildGuidelineItem(
                    icon: Icons.thumb_up,
                    title: 'Be Polite',
                    description: 'Always be respectful and patient with volunteers who are donating their time to help you.',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildGuidelineItem(
                    icon: Icons.money_off,
                    title: 'No Solicitation',
                    description: 'Never ask volunteers for money, gifts, or any form of financial assistance.',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildGuidelineItem(
                    icon: Icons.timer,
                    title: 'Reasonable Requests',
                    description: 'Keep your requests reasonable and limited to visual assistance tasks.',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildGuidelineItem(
                    icon: Icons.security,
                    title: 'Stay Safe',
                    description: 'Never share personal information like passwords, bank details, or home address.',
                  ),
                ],
              ),
            ),
            
            CustomButton(
              text: 'I Understand',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlindUserHomeScreen(
                      language: language,
                      translations: translations,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 8),
            
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Text-to-speech functionality would be implemented here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reading guidelines aloud...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Read Aloud'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGuidelineItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF00D4AA), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}