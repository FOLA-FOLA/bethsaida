import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_model.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Authentication
  static Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String role,
    required String language,
    Position? location,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        // Create user profile in Firestore
        final userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          role: role,
          preferredLanguage: language,
          supportedLanguages: role == 'volunteer' ? [language, 'English'] : [language],
          isAvailable: role == 'volunteer' ? true : false,
          location: location != null 
              ? {'lat': location.latitude, 'lng': location.longitude}
              : null,
          createdAt: DateTime.now(),
          lastActive: DateTime.now(),
        );
        
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toMap());
        
        return credential.user;
      }
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
    return null;
  }
  
  static Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update last active
      if (credential.user != null) {
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .update({'lastActive': DateTime.now()});
      }
      
      return credential.user;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }
  
  static Future<void> signOut() async {
    await _auth.signOut();
  }
  
  // User management
  static Future<UserModel?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
    return null;
  }
  
  static Future<void> updateUserAvailability({
    required String userId,
    required bool isAvailable,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'isAvailable': isAvailable,
      'lastActive': DateTime.now(),
    });
  }
  
  static Future<void> updateUserLocation({
    required String userId,
    required Position location,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'location': {'lat': location.latitude, 'lng': location.longitude},
      'lastActive': DateTime.now(),
    });
  }
  
  // Call management
  static Future<String> createCall({
    required String userId,
    required String language,
    Position? userLocation,
  }) async {
    final callDoc = _firestore.collection('calls').doc();
    
    await callDoc.set({
      'id': callDoc.id,
      'userId': userId,
      'userLanguage': language,
      'userLocation': userLocation != null 
          ? GeoPoint(userLocation.latitude, userLocation.longitude)
          : null,
      'status': 'waiting',
      'createdAt': DateTime.now(),
    });
    
    return callDoc.id;
  }
  
  static Stream<DocumentSnapshot> listenToCall(String callId) {
    return _firestore.collection('calls').doc(callId).snapshots();
  }
  
  static Stream<QuerySnapshot> listenForVolunteerCalls(String volunteerId) {
    return _firestore
        .collection('calls')
        .where('volunteerId', isEqualTo: volunteerId)
        .where('status', whereIn: ['matched', 'active'])
        .snapshots();
  }
  
  static Future<void> endCall(String callId) async {
    await _firestore.collection('calls').doc(callId).update({
      'status': 'ended',
      'endedAt': DateTime.now(),
    });
  }
}