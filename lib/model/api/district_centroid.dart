import 'package:json_annotation/json_annotation.dart';

part 'district_centroid.g.dart';

@JsonSerializable()
class Centroid {
  String type;
  List<double> coordinates = [];

  Centroid({this.type, this.coordinates});

  factory Centroid.fromJson(Map<String, dynamic> json) =>
      _$CentroidFromJson(json);
}
