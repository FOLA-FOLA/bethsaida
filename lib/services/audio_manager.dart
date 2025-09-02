// services/audio_manager.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioManager {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;
  static String? _currentAudioPath;
  
  // Audio asset paths organized by language and content type
  static const Map<String, Map<String, String>> audioAssets = {
    'English': {
      'disclaimer': 'audio/en/disclaimer.mp3',
      'welcome': 'audio/en/welcome.mp3',
      'guidelines': 'audio/en/guidelines.mp3',
      'call_connected': 'audio/en/call_connected.mp3',
      'call_ended': 'audio/en/call_ended.mp3',
    },
    'Yoruba': {
      'disclaimer': 'audio/yo/disclaimer.mp3',
      'welcome': 'audio/yo/welcome.mp3',
      'guidelines': 'audio/yo/guidelines.mp3',
      'call_connected': 'audio/yo/call_connected.mp3',
      'call_ended': 'audio/yo/call_ended.mp3',
    },
    'Igbo': {
      'disclaimer': 'audio/ig/disclaimer.mp3',
      'welcome': 'audio/ig/welcome.mp3',
      'guidelines': 'audio/ig/guidelines.mp3',
      'call_connected': 'audio/ig/call_connected.mp3',
      'call_ended': 'audio/ig/call_ended.mp3',
    },
    'Hausa': {
      'disclaimer': 'audio/ha/disclaimer.mp3',
      'welcome': 'audio/ha/welcome.mp3',
      'guidelines': 'audio/ha/guidelines.mp3',
      'call_connected': 'audio/ha/call_connected.mp3',
      'call_ended': 'audio/ha/call_ended.mp3',
    },
    'Pidgin': {
      'disclaimer': 'audio/pid/disclaimer.mp3',
      'welcome': 'audio/pid/welcome.mp3',
      'guidelines': 'audio/pid/guidelines.mp3',
      'call_connected': 'audio/pid/call_connected.mp3',
      'call_ended': 'audio/pid/call_ended.mp3',
    },
  };
  
  static Future<bool> playAudio({
    required String language,
    required String contentType,
    VoidCallback? onComplete,
  }) async {
    try {
      if (_isPlaying) {
        await stopAudio();
      }
      
      final audioPath = audioAssets[language]?[contentType];
      if (audioPath == null) {
        debugPrint('Audio file not found: $language - $contentType');
        return false;
      }
      
      _currentAudioPath = audioPath;
      _isPlaying = true;
      
      // Set up completion listener
      _player.onPlayerComplete.listen((_) {
        _isPlaying = false;
        _currentAudioPath = null;
        onComplete?.call();
      });
      
      await _player.play(AssetSource(audioPath));
      return true;
    } catch (e) {
      debugPrint('Error playing audio: $e');
      _isPlaying = false;
      _currentAudioPath = null;
      return false;
    }
  }
  
  static Future<void> stopAudio() async {
    if (_isPlaying) {
      await _player.stop();
      _isPlaying = false;
      _currentAudioPath = null;
    }
  }
  
  static Future<void> pauseAudio() async {
    if (_isPlaying) {
      await _player.pause();
    }
  }
  
  static Future<void> resumeAudio() async {
    if (_currentAudioPath != null && !_isPlaying) {
      await _player.resume();
      _isPlaying = true;
    }
  }
  
  static bool get isPlaying => _isPlaying;
  static String? get currentAudioPath => _currentAudioPath;
  
  // Play short notification sounds
  static Future<void> playNotificationSound(String soundType) async {
    try {
      final soundPath = 'audio/notifications/$soundType.mp3';
      await AudioPlayer().play(AssetSource(soundPath));
    } catch (e) {
      debugPrint('Error playing notification sound: $e');
    }
  }
}