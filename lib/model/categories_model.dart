import 'package:hpaan_viewpoint/model/categories_list_model.dart';

class Category {
  final String count;
  final String icon;
  final String id;
  final String name;
  final List<dynamic> place;

  Category({
    required this.count,
    required this.icon,
    required this.id,
    required this.name,
    required this.place,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        count: json["count"],
        icon: json["icon"],
        id: json["id"],
        name: json["name"],
        place: List<Place>.from(
          json["place"].map(
            (placeJson) => Place.fromJson(placeJson),
          ),
        ),
      );

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'icon': icon,
      'id': id,
      'name': name,
      'place': List<dynamic>.from(place.map((x) => x.json())),
    };
  }
}
