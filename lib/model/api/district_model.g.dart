// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) {
  return District(
    id: json['id'] as int,
    bbox: (json['bbox'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    centroid: json['centroid'] == null
        ? null
        : Centroid.fromJson(json['centroid'] as Map<String, dynamic>),
    title: json['title'] as String,
    title_en: json['title_en'] as String,
    title_ne: json['title_ne'] as String,
    code: json['code'] as String,
    province: json['province'] as int,
  );
}

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'bbox': instance.bbox,
      'centroid': instance.centroid,
      'title': instance.title,
      'title_en': instance.title_en,
      'title_ne': instance.title_ne,
      'code': instance.code,
      'province': instance.province,
    };
