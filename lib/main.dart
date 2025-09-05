import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'services/camera_service.dart';
import 'services/notification_service.dart';
import 'providers/user_provider.dart';
import 'providers/call_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize services
  await CameraService.initializeCameras();
  await NotificationService.initialize();
  
  runApp(const Bethsaida());
}

class Bethsaida extends StatelessWidget {
  const Bethsaida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CallProvider()),
      ],
      child: MaterialApp(
        title: 'Bethsaida',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF00D4AA),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF00D4AA),
            secondary: Color(0xFF4ECDC4),
            surface: Color(0xFF1E1E1E),
            background: Color(0xFF121212),
            onPrimary: Colors.black,
            onSecondary: Colors.black,
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E1E1E),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4AA),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}