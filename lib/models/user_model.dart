import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? address;
  final String role;
  final String? profileImage;
  final DateTime createdAt;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
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
      'password': password,
      'phone': phone,
      'address': address,
      'role': role,
      'profileImage': profileImage,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'],
      role: map['role'] ?? 'customer',
      profileImage: map['profileImage'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

}