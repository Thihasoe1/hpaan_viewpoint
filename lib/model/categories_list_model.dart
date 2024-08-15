class Place {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final String rating;
  final String reviewCount;
  final bool isOpen;
  final String distance;
  final String lat;
  final String long;

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    required this.distance,
    required this.lat,
    required this.long,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: (json['rating']), // Ensure double type
      reviewCount: json['reviewCount'],
      isOpen: json['isOpen'],
      distance: (json['distance']),
      lat: (json['lat']),
      long: (json['long']), // Ensure double type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'isOpen': isOpen,
      'distance': distance,
      'lat': lat,
      'long': long,
    };
  }
}
