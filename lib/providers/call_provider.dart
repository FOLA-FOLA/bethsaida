import 'package:flutter/material.dart';
import '../services/call_matching_service.dart';
import '../services/firebase_service.dart';

class CallProvider extends ChangeNotifier {
  String? _currentCallId;
  String? _matchedVolunteerId;
  CallRequest? _currentCall;
  bool _isSearchingForVolunteer = false;
  
  String? get currentCallId => _currentCallId;
  String? get matchedVolunteerId => _matchedVolunteerId;
  CallRequest? get currentCall => _currentCall;
  bool get isSearchingForVolunteer => _isSearchingForVolunteer;
  bool get hasActiveCall => _currentCallId != null;
  
  Future<void> requestHelp({
    required String userId,
    required String language,
  }) async {
    try {
      _isSearchingForVolunteer = true;
      notifyListeners();
      
      _currentCallId = await CallMatchingService.createCallRequest(
        userId: userId,
        language: language,
      );
      
      // Try to match with volunteer
      _matchedVolunteerId = await CallMatchingService.matchWithVolunteer(
        callId: _currentCallId!,
        userId: userId,
        language: language,
      );
      
      if (_matchedVolunteerId != null) {
        // Listen for call updates
        CallMatchingService.listenToCallUpdates(_currentCallId!).listen((call) {
          _currentCall = call;
          notifyListeners();
        });
      }
    } finally {
      _isSearchingForVolunteer = false;
      notifyListeners();
    }
  }
  
  Future<void> endCall() async {
    if (_currentCallId != null && _matchedVolunteerId != null) {
      await CallMatchingService.endCall(_currentCallId!, _matchedVolunteerId!);
      _currentCallId = null;
      _matchedVolunteerId = null;
      _currentCall = null;
      notifyListeners();
    }
  }
}