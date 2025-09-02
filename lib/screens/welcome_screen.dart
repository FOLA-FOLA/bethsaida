import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../widgets/role_card.dart';
import '../widgets/language_selector.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Yoruba', 'Igbo', 'Hausa', 'Pidgin'];

  final Map<String, Map<String, String>> _translations = {
    'English': {
      'appTitle': 'Bethsaida',
      'welcome': 'Be the light for someone else',
      'roleSelection': 'How would you like to help?',
      'blindUser': 'I need help seeing',
      'volunteer': 'I want to help someone see',
      'language': 'Language',
    },
    'Yoruba': {
      'appTitle': 'Bethsaida',
      'welcome': 'Je imole fun elomiran',
      'roleSelection': 'Bawo ni o fe se ranlo?',
      'blindUser': 'Mo nilo iranlo lati ri',
      'volunteer': 'Mo fe ran eniyan lo lati ri',
      'language': 'Ede',
    },
    'Igbo': {
      'appTitle': 'Bethsaida',
      'welcome': 'Huru site n\'anya onye ozo',
      'roleSelection': 'Kedu ka i choro isi nyere aka?',
      'blindUser': 'Achoro m enyemaka ihu ihe',
      'volunteer': 'Achoro m inyere mmadu aka ihu ihe',
      'language': 'Asusu',
    },
    'Hausa': {
      'appTitle': 'Bethsaida',
      'welcome': 'Ga ta hanyar idanun wani',
      'roleSelection': 'Ta yaya kuke so ku taimaka?',
      'blindUser': 'Ina bukatar taimako wajen gani',
      'volunteer': 'Ina son in taimaki wani ya gani',
      'language': 'Harshe',
    },
    'Pidgin': {
      'appTitle': 'Bethsaida',
      'welcome': 'See through person eye',
      'roleSelection': 'How you wan help?',
      'blindUser': 'I need help to see',
      'volunteer': 'I wan help person see',
      'language': 'Language',
    },
  };

  @override
  Widget build(BuildContext context) {
    final t = _translations[_selectedLanguage]!;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header with logo and language selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t['appTitle']!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF00D4AA),
                    ),
                  ),
                  LanguageSelector(
                    selectedLanguage: _selectedLanguage,
                    languages: _languages,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 60),
              
              // Welcome text
              Text(
                t['welcome']!,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                t['roleSelection']!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFB0B0B0),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              
              const Spacer(),
              
              // Role selection cards
              Column(
                children: [
                  RoleCard(
                    icon: Icons.remove_red_eye,
                    title: t['blindUser']!,
                    description: 'Get live assistance from volunteers in Nigeria',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(
                            isVolunteer: false,
                            language: _selectedLanguage,
                            translations: _translations[_selectedLanguage]!,
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  RoleCard(
                    icon: Icons.volunteer_activism,
                    title: t['volunteer']!,
                    description: 'Help visually impaired people in your community',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(
                            isVolunteer: true,
                            language: _selectedLanguage,
                            translations: _translations[_selectedLanguage]!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Footer text
              const Text(
                'Good Samaritan',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF808080),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}