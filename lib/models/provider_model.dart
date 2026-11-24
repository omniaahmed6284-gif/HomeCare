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

  Map<String, dynamic> toJson(){
    return {
      'providerId': providerId,
      'userId': userId,
      'serviceId': serviceId,
      'price': price,
    };
  }

  factory ProviderModel.fromJson(Map<String, dynamic> json){
    return ProviderModel(
      providerId: json['providerId'] ?? '',
      userId: json['userId'] ?? '',
      serviceId: json['serviceId'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}