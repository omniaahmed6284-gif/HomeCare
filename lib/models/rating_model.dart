import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String id;
  final String bookingId;
  final String customerId;
  final String providerId;
  final double rating;
  final String comment;
  final String customerName;
  final DateTime? createdAt;

  static const double minRating = 1;
  static const double maxRating = 5;
  static const int maxCommentLength = 300;

  RatingModel({
    String? id,
    required this.bookingId,
    required this.customerId,
    required this.providerId,
    required double rating,
    String comment = '',
    this.customerName = '',
    this.createdAt,
  })  : id = id ?? bookingId,
        rating = rating.clamp(minRating, maxRating).toDouble(),
        comment = comment.trim().length > maxCommentLength
            ? comment.trim().substring(0, maxCommentLength)
            : comment.trim();
  String? validate() {
    if (bookingId.isEmpty || customerId.isEmpty || providerId.isEmpty) {
      return 'يوجد نقص في بيانات التقيم';
    }
    if (rating < minRating || rating > maxRating) {
      return 'حدث خطأ,التقييم من 1 لـ 5';
    }
    return null;
  }
  factory RatingModel.fromMap(String id, Map<String, dynamic> map) {
    return RatingModel(
      id: id,
      bookingId: map['bookingId'] ?? '',
      customerId: map['customerId'] ?? '',
      providerId: map['providerId'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? minRating,
      comment: map['comment'] ?? '',
      customerName: map['customerName'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'customerId': customerId,
      'providerId': providerId,
      'rating': rating,
      'comment': comment,
      'customerName': customerName,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
