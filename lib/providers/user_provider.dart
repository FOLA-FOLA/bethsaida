import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  User? _firebaseUser;
  UserModel? _userModel;
  bool _isLoading = false;
  String? _error;
  
  User? get firebaseUser => _firebaseUser;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _firebaseUser != null;
  
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    required String language,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _firebaseUser = await FirebaseService.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
        role: role,
        language: language,
      );
      
      if (_firebaseUser != null) {
        _userModel = await FirebaseService.getUserProfile(_firebaseUser!.uid);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> signOut() async {
    await FirebaseService.signOut();
    _firebaseUser = null;
    _userModel = null;
    notifyListeners();
  }
  
  Future<void> updateAvailability(bool isAvailable) async {
    if (_userModel != null) {
      await FirebaseService.updateUserAvailability(
        userId: _userModel!.id,
        isAvailable: isAvailable,
      );
      _userModel = _userModel!.copyWith(isAvailable: isAvailable);
      notifyListeners();
    }
  }
}