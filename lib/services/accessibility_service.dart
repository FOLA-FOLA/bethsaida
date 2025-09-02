// services/accessibility_service.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class AccessibilityService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isPlaying = false;
  
  // Audio file paths for different languages
  static const Map<String, Map<String, String>> _audioAssets = {
    'English': {
      'disclaimer': 'assets/audio/disclaimer_english.mp3',
      'welcome': 'assets/audio/welcome_english.mp3',
      'guidelines': 'assets/audio/guidelines_english.mp3',
    },
    'Yoruba': {
      'disclaimer': 'assets/audio/disclaimer_yoruba.mp3',
      'welcome': 'assets/audio/welcome_yoruba.mp3',
      'guidelines': 'assets/audio/guidelines_yoruba.mp3',
    },
    'Igbo': {
      'disclaimer': 'assets/audio/disclaimer_igbo.mp3',
      'welcome': 'assets/audio/welcome_igbo.mp3',
      'guidelines': 'assets/audio/guidelines_igbo.mp3',
    },
    'Hausa': {
      'disclaimer': 'assets/audio/disclaimer_hausa.mp3',
      'welcome': 'assets/audio/welcome_hausa.mp3',
      'guidelines': 'assets/audio/guidelines_hausa.mp3',
    },
    'Pidgin': {
      'disclaimer': 'assets/audio/disclaimer_pidgin.mp3',
      'welcome': 'assets/audio/welcome_pidgin.mp3',
      'guidelines': 'assets/audio/guidelines_pidgin.mp3',
    },
  };
  
  // Play voiceover for specific content
  static Future<void> playVoiceover({
    required String language,
    required String contentType, // 'disclaimer', 'welcome', 'guidelines'
  }) async {
    try {
      if (_isPlaying) {
        await stopVoiceover();
      }
      
      final audioPath = _audioAssets[language]?[contentType];
      if (audioPath == null) {
        debugPrint('Audio file not found for $language - $contentType');
        return;
      }
      
      _isPlaying = true;
      await _audioPlayer.play(AssetSource(audioPath.replaceFirst('assets/', '')));
    } catch (e) {
      debugPrint('Error playing voiceover: $e');
      _isPlaying = false;
    }
  }
  
  static Future<void> stopVoiceover() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
    }
  }
  
  static bool get isPlaying => _isPlaying;
  
  // Announce text using TTS or play audio
  static Future<void> announce(String text) async {
    try {
      // For screen readers to announce
      await SystemChannels.textInput.invokeMethod('TextInput.setClient', {
        'inputAction': 'TextInputAction.done',
        'inputType': 'TextInputType.text',
      });
      
      // Also provide haptic feedback
      HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Error with announcement: $e');
    }
  }
  
  // Custom gesture detector for accessibility
  static Widget accessibleButton({
    required Widget child,
    required VoidCallback onPressed,
    required String semanticLabel,
    String? semanticHint,
  }) {
    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      button: true,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onPressed();
        },
        onDoubleTap: () {
          announce('Double tapped: $semanticLabel');
          onPressed();
        },
        child: child,
      ),
    );
  }
}