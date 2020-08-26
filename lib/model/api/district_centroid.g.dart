// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_centroid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Centroid _$CentroidFromJson(Map<String, dynamic> json) {
  return Centroid(
    type: json['type'] as String,
    coordinates: (json['coordinates'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
  );
}

Map<String, dynamic> _$CentroidToJson(Centroid instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
