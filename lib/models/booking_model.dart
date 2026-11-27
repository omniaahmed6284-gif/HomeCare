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
  final String bookingId;
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
    this.bookingId = '',
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

  factory BookingModel.fromJMap(String id, Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map ['bookingId'] ?? '',
      customerId: map['customerId'] ?? '',
      providerId: map['providerId'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'] ?? '',
      address: map['address'] ?? '',
      description: map['description'] ?? '',
      status: BookingStatus.values.firstWhere(
            (s) => s.name == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      customerName: map['customerName'] ?? '',
      providerName: map['providerName'] ?? '',
      serviceName: map['serviceName'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
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
