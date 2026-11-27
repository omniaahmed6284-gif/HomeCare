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

  Map<String, dynamic> toMap(){
    return {
      'serviceId': serviceId,
      'name': name,
      'icon': icon,
      'image': image,
      'description': description,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map){
    return ServiceModel(
      serviceId: map['serviceId'] ?? '',
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
    );
  }
}