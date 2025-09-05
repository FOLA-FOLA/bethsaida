import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/audio_manager.dart';

class AccessibleScreenWrapper extends StatefulWidget {
  final Widget child;
  final String screenName;
  final String language;
  final String? welcomeAudioType;
  final bool enableVoiceControl;
  final Function(String)? onVoiceCommand;
  
  const AccessibleScreenWrapper({
    Key? key,
    required this.child,
    required this.screenName,
    required this.language,
    this.welcomeAudioType,
    this.enableVoiceControl = false,
    this.onVoiceCommand,
  }) : super(key: key);
  
  @override
  State<AccessibleScreenWrapper> createState() => _AccessibleScreenWrapperState();
}

class _AccessibleScreenWrapperState extends State<AccessibleScreenWrapper> {
  bool _hasPlayedWelcome = false;
  
  @override
  void initState() {
    super.initState();
    _announceScreenEntry();
  }
  
  void _announceScreenEntry() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Announce screen name
      SystemChannels.accessibility.invokeMethod('announce', '${widget.screenName} screen loaded');
      
      // Play welcome audio if specified
      if (widget.welcomeAudioType != null && !_hasPlayedWelcome) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          AudioManager.playAudio(
            language: widget.language,
            contentType: widget.welcomeAudioType!,
          );
        });
        _hasPlayedWelcome = true;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.screenName,
      child: widget.child,
    );
  }
}