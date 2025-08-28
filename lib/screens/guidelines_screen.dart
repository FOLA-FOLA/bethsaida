import 'package:flutter/material.dart';

class GuidelinesScreen extends StatelessWidget {
  final String language;
  final Map<String, String> translations;
  
  const GuidelinesScreen({
    Key? key,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Volunteer Guidelines'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            
            const Text(
              'How to Help Effectively',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              'Follow these guidelines to provide the best assistance to visually impaired users',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB0B0B0),
              ),
            ),
            
            const SizedBox(height: 32),
            
            _buildGuidelineItem(
              number: 1,
              title: 'Introduce Yourself',
              description: 'Start by greeting the user and introducing yourself by your first name.',
            ),
            
            _buildGuidelineItem(
              number: 2,
              title: 'Be Patient',
              description: 'Understand that some tasks may take longer for the user to describe or complete.',
            ),
            
            _buildGuidelineItem(
              number: 3,
              title: 'Speak Clearly',
              description: 'Use clear, concise language and avoid speaking too quickly.',
            ),
            
            _buildGuidelineItem(
              number: 4,
              title: 'Ask for Permission',
              description: 'Before taking any action, ask for the user\'s permission and explain what you\'re doing.',
            ),
            
            _buildGuidelineItem(
              number: 5,
              title: 'Respect Privacy',
              description: 'Never ask for personal information and respect the user\'s privacy at all times.',
            ),
            
            _buildGuidelineItem(
              number: 6,
              title: 'Focus on the Task',
              description: 'Stay focused on the specific task the user needs help with.',
            ),
            
            _buildGuidelineItem(
              number: 7,
              title: 'Provide Clear Instructions',
              description: 'Give step-by-step instructions when needed, and confirm the user understands.',
            ),
            
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('I Understand'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGuidelineItem({
    required int number,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00D4AA),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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