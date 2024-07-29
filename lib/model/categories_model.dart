import 'package:hpaan_viewpoint/model/categories_list_model.dart';

class Category {
  final int id;
  final String name;
  final int count;
  final String icon;
  final List<Place> places;

  Category({
    required this.id,
    required this.name,
    required this.count,
    required this.icon,
    required this.places,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var placesFromJson = json['places'] as List;
    List<Place> placeList =
        placesFromJson.map((place) => Place.fromJson(place)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      icon: json['icon'],
      places: placeList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'count': count,
      'icon': icon,
      'places': places.map((i) => i.toJson()).toList(),
    };
  }
}
