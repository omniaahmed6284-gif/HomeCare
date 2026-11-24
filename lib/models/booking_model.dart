import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum BookingStatus { pending, accepted, rejected, completed, cancelled }

extension BookingStatusX on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'قيد الانتظار';
      case BookingStatus.accepted:
        return 'مقبول';
      case BookingStatus.rejected:
        return 'مرفوض';
      case BookingStatus.completed:
        return 'مكتمل';
      case BookingStatus.cancelled:
        return 'ملغي';
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.accepted:
        return Colors.blue;
      case BookingStatus.rejected:
        return Colors.red;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.grey;
    }
  }
}

class BookingModel {
  final String id;
  final String customerId;
  final String providerId;
  final DateTime date;
  final String time;
  final String address;
  final String description;
  final BookingStatus status;

  // بيانات إضافية للعرض فقط (عشان منعملش query تاني لكل كارت)
  final String customerName;
  final String providerName;
  final String serviceName;
  final DateTime? createdAt;

  BookingModel({
    this.id = '',
    required this.customerId,
    required this.providerId,
    required this.date,
    required this.time,
    required this.address,
    this.description = '',
    this.status = BookingStatus.pending,
    this.customerName = '',
    this.providerName = '',
    this.serviceName = '',
    this.createdAt,
  });

  String get formattedDate => '${date.year}/${date.month}/${date.day}';

  factory BookingModel.fromJson(String id, Map<String, dynamic> json) {
    return BookingModel(
      id: id,
      customerId: json['customerId'] ?? '',
      providerId: json['providerId'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      time: json['time'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      status: BookingStatus.values.firstWhere(
            (s) => s.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      customerName: json['customerName'] ?? '',
      providerName: json['providerName'] ?? '',
      serviceName: json['serviceName'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'providerId': providerId,
      'date': Timestamp.fromDate(date),
      'time': time,
      'address': address,
      'description': description,
      'status': status.name,
      'customerName': customerName,
      'providerName': providerName,
      'serviceName': serviceName,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
