class ServiceModel {
  final String serviceId;
  final String name;
  final String icon;
  final String image;
  final String description;

  ServiceModel ({
    required this.serviceId,
    required this.name,
    required this.icon,
    required this.image,
    required this.description,
});

  Map<String, dynamic> toJson(){
    return {
      'serviceId': serviceId,
      'name': name,
      'icon': icon,
      'image': image,
      'description': description,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json){
    return ServiceModel(
      serviceId: json['serviceId'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}