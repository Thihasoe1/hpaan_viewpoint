// import 'package:hpaan_viewpoint/model/categories_list_model.dart';
//
// class Category {
//   final String id;
//   final String name;
//   final String count;
//   final String icon;
//   final List<dynamic> places;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.count,
//     required this.icon,
//     required this.places,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     // var placesFromJson = json['place'] as List;
//     // List<Place> placeList =
//     //     placesFromJson.map<Place>((place) => Place.fromJson(place)).toList();
//
//     // factory Economylist.fromJson(Map<String, dynamic> json) => Economylist(
//     //   success: json["success"],
//     //   result: json["result"].map<ResultClass>((x) => ResultClass.fromJson(x)).toList(),
//     // );
//     //
//     // Map<String, dynamic> toJson() => {
//     //   "success": success,
//     //   "result": result.map((x) => x.toJson()),
//     // };
//
//     return Category(
//       id: json['id'],
//       name: json['name'],
//       count: json['count'],
//       icon: json['icon'],
//       places: json['place'].map<Place>((place) => Place.fromJson(place)).toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'count': count,
//       'icon': icon,
//       'place': places.map((i) => i.toJson()).toList(),
//     };
//   }
//
//   @override
//   String toString() {
//     return "category id $id : category name $name";
//   }
// }



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
    place: List<Place>.from(json["place"].map((placeJson) => Place.fromJson(placeJson))),
    // success: json["success"],
    // result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
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

  // Map<String, dynamic> toJson() => {
  //   "success": success,
  //   "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  // };

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   var list = json['place'] as List;
  //   List<Place> placeList = list.map((i) => Place.fromJson(i)).toList();
  //
  //   return Category(
  //     count: json['count'] ?? '0',
  //     icon: json['icon'] ?? '',
  //     id: json['id'] ?? '',
  //     name: json['name'] ?? '',
  //     place: placeList,
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'count': count,
  //     'icon': icon,
  //     'id': id,
  //     'name': name,
  //     'place': place.map((i) => i.toJson()).toList(),
  //   };
  // }
}



