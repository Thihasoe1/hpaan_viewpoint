import 'package:hpaan_viewpoint/model/popular_place.dart';

class PopularPlaceData {
  final List<dynamic> data;

  PopularPlaceData({required this.data});

  factory PopularPlaceData.fromJson(Map<String, dynamic> json) =>
      PopularPlaceData(
        data: List<PopularPlaceModel>.from(
          json["data"].map(
            (placeJson) => PopularPlaceModel.fromJson(placeJson),
          ),
        ),
      );

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((x) => x.json())),
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$data";
  }
}
