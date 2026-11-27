import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String role;
  final String? profileImage;
  final DateTime createdAt;

  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    required this.role,
    this.profileImage,
    required this.createdAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'role': role,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }


  factory UserModel.fromMap(Map<String, dynamic> map) {
    final createdAtValue = map['createdAt'];

    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String?,
      role: map['role'] as String? ?? 'customer',
      profileImage: map['profileImage'] as String?,
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : DateTime.parse(createdAtValue as String),
    );
  }
}
