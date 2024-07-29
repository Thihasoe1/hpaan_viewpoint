class MarkerData {
  final int id;
  final String name;
  final String addres;
  final double latitude;
  final double longitude;
  final String description;
  final String image;

  MarkerData({
    required this.id,
    required this.name,
    required this.addres,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.image,
  });

  factory MarkerData.fromJson(Map<String, dynamic> json) {
    return MarkerData(
      id: json['id'],
      name: json['name'],
      addres: json['address'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': addres,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'image': image,
    };
  }

  static List<MarkerData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MarkerData.fromJson(json)).toList();
  }
}
