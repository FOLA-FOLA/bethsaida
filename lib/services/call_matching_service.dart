import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class CallRequest {
  final String id;
  final String userId;
  final String userLanguage;
  final Position? userLocation;
  final DateTime timestamp;
  final String status; // 'waiting', 'matched', 'completed', 'cancelled'
  
  CallRequest({
    required this.id,
    required this.userId,
    required this.userLanguage,
    this.userLocation,
    required this.timestamp,
    required this.status,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userLanguage': userLanguage,
      'userLocation': userLocation != null 
        ? GeoPoint(userLocation!.latitude, userLocation!.longitude)
        : null,
      'timestamp': timestamp,
      'status': status,
    };
  }
  
  factory CallRequest.fromMap(Map<String, dynamic> map) {
    GeoPoint? geoPoint = map['userLocation'];
    Position? position;
    if (geoPoint != null) {
      position = Position(
        longitude: geoPoint.longitude,
        latitude: geoPoint.latitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    }
    
    return CallRequest(
      id: map['id'],
      userId: map['userId'],
      userLanguage: map['userLanguage'],
      userLocation: position,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      status: map['status'],
    );
  }
}

class CallMatchingService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const double _maxDistanceKm = 50.0; // Maximum distance for matching
  
  // Create a new call request
  static Future<String> createCallRequest({
    required String userId,
    required String language,
    Position? userLocation,
  }) async {
    final callRequest = CallRequest(
      id: _firestore.collection('calls').doc().id,
      userId: userId,
      userLanguage: language,
      userLocation: userLocation,
      timestamp: DateTime.now(),
      status: 'waiting',
    );
    
    await _firestore
        .collection('calls')
        .doc(callRequest.id)
        .set(callRequest.toMap());
    
    return callRequest.id;
  }
  
  // Find available volunteers
  static Future<List<String>> findAvailableVolunteers({
    required String language,
    Position? userLocation,
  }) async {
    Query query = _firestore
        .collection('users')
        .where('role', isEqualTo: 'volunteer')
        .where('isAvailable', isEqualTo: true)
        .where('preferredLanguages', arrayContains: language);
    
    final querySnapshot = await query.get();
    List<String> availableVolunteers = [];
    
    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      
      // If location is available, check distance
      if (userLocation != null && data['location'] != null) {
        final volunteerLocation = data['location'] as GeoPoint;
        final distance = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          volunteerLocation.latitude,
          volunteerLocation.longitude,
        ) / 1000; // Convert to kilometers
        
        if (distance <= _maxDistanceKm) {
          availableVolunteers.add(doc.id);
        }
      } else {
        // If no location, add all volunteers with matching language
        availableVolunteers.add(doc.id);
      }
    }
    
    return availableVolunteers;
  }
  
  // Match user with volunteer
  static Future<String?> matchWithVolunteer({
    required String callId,
    required String userId,
    required String language,
    Position? userLocation,
  }) async {
    final availableVolunteers = await findAvailableVolunteers(
      language: language,
      userLocation: userLocation,
    );
    
    if (availableVolunteers.isEmpty) {
      return null;
    }
    
    // Select random volunteer from available ones
    final selectedVolunteer = availableVolunteers[
      Random().nextInt(availableVolunteers.length)
    ];
    
    // Update call with matched volunteer
    await _firestore.collection('calls').doc(callId).update({
      'volunteerId': selectedVolunteer,
      'status': 'matched',
      'matchedAt': DateTime.now(),
    });
    
    // Set volunteer as unavailable
    await _firestore.collection('users').doc(selectedVolunteer).update({
      'isAvailable': false,
      'currentCallId': callId,
    });
    
    return selectedVolunteer;
  }
  
  // End call and cleanup
  static Future<void> endCall(String callId, String volunteerId) async {
    // Update call status
    await _firestore.collection('calls').doc(callId).update({
      'status': 'completed',
      'endedAt': DateTime.now(),
    });
    
    // Set volunteer as available again
    await _firestore.collection('users').doc(volunteerId).update({
      'isAvailable': true,
      'currentCallId': null,
    });
  }
  
  // Listen to call status updates
  static Stream<CallRequest> listenToCallUpdates(String callId) {
    return _firestore
        .collection('calls')
        .doc(callId)
        .snapshots()
        .map((snapshot) => CallRequest.fromMap(snapshot.data()!));
  }
  
  // Listen for incoming calls (for volunteers)
  static Stream<CallRequest?> listenForIncomingCalls(String volunteerId) {
    return _firestore
        .collection('calls')
        .where('volunteerId', isEqualTo: volunteerId)
        .where('status', isEqualTo: 'matched')
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            return CallRequest.fromMap(snapshot.docs.first.data());
          }
          return null;
        });
  }
}

// services/location_service.dart
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
  
  static Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }
  
  static Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }
  
  static Future<Position?> getCurrentPosition() async {
    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }
    
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      return null;
    }
  }
  
  static double calculateDistance(Position pos1, Position pos2) {
    return Geolocator.distanceBetween(
      pos1.latitude,
      pos1.longitude,
      pos2.latitude,
      pos2.longitude,
    ) / 1000; // Convert to kilometers
  }
}