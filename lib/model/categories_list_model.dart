class Place {
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  final double distance;
  final double lat;
  final double long;

  Place({
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
      name: json['name'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(), // Ensure double type
      reviewCount: json['reviewCount'],
      isOpen: json['isOpen'],
      distance: (json['distance'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(), // Ensure double type
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
