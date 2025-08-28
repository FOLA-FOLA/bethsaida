import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final String language;
  final Map<String, String> translations;
  
  const SettingsScreen({
    Key? key,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 20),
          
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 24),
          
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF00D4AA)),
            title: const Text('Profile Information', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          
          ListTile(
            leading: const Icon(Icons.language, color: Color(0xFF00D4AA)),
            title: const Text('Language', style: TextStyle(color: Colors.white)),
            trailing: Text(language, style: const TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          
          ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF00D4AA)),
            title: const Text('Notifications', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          
          ListTile(
            leading: const Icon(Icons.volume_up, color: Color(0xFF00D4AA)),
            title: const Text('Sound & Vibration', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const SizedBox(height: 32),
          
          const Text(
            'Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 24),
          
          ListTile(
            leading: const Icon(Icons.help, color: Color(0xFF00D4AA)),
            title: const Text('Help Center', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          
          ListTile(
            leading: const Icon(Icons.feedback, color: Color(0xFF00D4AA)),
            title: const Text('Send Feedback', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          
          ListTile(
            leading: const Icon(Icons.shield, color: Color(0xFF00D4AA)),
            title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const Divider(color: Color(0xFF2A2A2A), height: 1),
          
          ListTile(
            leading: const Icon(Icons.description, color: Color(0xFF00D4AA)),
            title: const Text('Terms of Service', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {},
          ),
          
          const SizedBox(height: 32),
          
          ElevatedButton(
            onPressed: () {
              // Sign out logic
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}