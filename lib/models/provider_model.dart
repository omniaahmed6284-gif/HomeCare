class ProviderModel {
  final String providerId;
  final String userId;
  final String serviceId;
  final double price;

  ProviderModel ({
    required this.providerId,
    required this.userId,
    required this.serviceId,
    required this.price,
  });

  Map<String, dynamic> toMap(){
    return {
      'providerId': providerId,
      'userId': userId,
      'serviceId': serviceId,
      'price': price,
    };
  }

  factory ProviderModel.fromJMap(Map<String, dynamic> map){
    return ProviderModel(
      providerId: map['providerId'] ?? '',
      userId: map['userId'] ?? '',
      serviceId: map['serviceId'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
    );
  }
}