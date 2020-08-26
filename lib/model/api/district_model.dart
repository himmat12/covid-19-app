import 'package:covid_app/model/api/district_centroid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'district_model.g.dart';

@JsonSerializable()
class District {
  int id;
  List<double> bbox = [];
  Centroid centroid;
  String title;
  String title_en;
  String title_ne;
  String code;
  int province;

  District({
    this.id,
    this.bbox,
    this.centroid,
    this.title,
    this.title_en,
    this.title_ne,
    this.code,
    this.province,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);
}
