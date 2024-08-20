import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Category.fromJson(
          Map<String, dynamic> json, String docId, List<Place> places) =>
      Category(
        count: json["count"],
        icon: json["icon"],
        id: docId,
        name: json["name"],
        place: json["place"],
      );

  factory Category.fromDocumentSnapshot(
      DocumentSnapshot doc, List<Place> places) {
    return Category.fromJson(
        doc.data() as Map<String, dynamic>, doc.id, places);
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'icon': icon,
      'id': id,
      'name': name,
      'place': List<dynamic>.from(place.map((x) => x.json())),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
      'icon': icon,
      'name': name,
      'place': place,
    };
  }

  @override
  String toString() {
    return "places $place";
  }
}
