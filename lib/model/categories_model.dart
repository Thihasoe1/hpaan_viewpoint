import 'package:hpaan_viewpoint/model/categories_list_model.dart';

class Category {
  final String id;
  final String name;
  final String count;
  final String icon;
  final List<dynamic> places;

  Category({
    required this.id,
    required this.name,
    required this.count,
    required this.icon,
    required this.places,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var placesFromJson = json['place'] as List;
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
      'place': places.map((i) => i.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return "category id $id : category name $name";
  }
}
