class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool isVolunteer;
  final String language;
  final DateTime createdAt;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isVolunteer,
    required this.language,
    required this.createdAt,
  });
  
  // Add fromMap and toMap methods for Firebase integration
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isVolunteer': isVolunteer,
      'language': language,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
  
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      isVolunteer: map['isVolunteer'],
      language: map['language'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}