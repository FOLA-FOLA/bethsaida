import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../services/accessibility_service.dart';

class VoiceControlWidget extends StatefulWidget {
  final Function(String) onVoiceCommand;
  final String language;
  
  const VoiceControlWidget({
    Key? key,
    required this.onVoiceCommand,
    required this.language,
  }) : super(key: key);
  
  @override
  State<VoiceControlWidget> createState() => _VoiceControlWidgetState();
}

class _VoiceControlWidgetState extends State<VoiceControlWidget> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  bool _speechEnabled = false;
  
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }
  
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
  
  void _startListening() async {
    if (!_speechEnabled) return;
    
    await _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          widget.onVoiceCommand(result.recognizedWords);
          _stopListening();
        }
      },
      localeId: _getLocaleId(widget.language),
    );
    setState(() {
      _isListening = true;
    });
  }
  
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }
  
  String _getLocaleId(String language) {
    switch (language) {
      case 'Yoruba':
        return 'yo-NG';
      case 'Igbo':
        return 'ig-NG';
      case 'Hausa':
        return 'ha-NG';
      default:
        return 'en-NG';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Voice command button',
      hint: 'Double tap to start voice command',
      button: true,
      child: GestureDetector(
        onTap: _speechEnabled
            ? (_isListening ? _stopListening : _startListening)
            : null,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isListening 
                ? const Color(0xFF00D4AA)
                : const Color(0xFF2A2A2A),
            border: Border.all(
              color: const Color(0xFF00D4AA),
              width: 2,
            ),
          ),
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
            color: _isListening ? Colors.black : const Color(0xFF00D4AA),
            size: 30,
          ),
        ),
      ),
    );
  }
}