class PopularPlaceModel {
  final String id;
  final String name;
  final String address;
  final String lat;
  final String long;
  final String description;
  final String image;

  PopularPlaceModel({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.description,
    required this.image,
  });

  factory PopularPlaceModel.fromJson(Map<String, dynamic> json) {
    return PopularPlaceModel(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      lat: json["lat"],
      long: json["long"],
      description: json["description"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "lat": lat,
      "long": long,
      "description": description,
      "image": image,
    };
  }

  @override
  String toString() {
    return "name ====> ${name}";
  }
}
