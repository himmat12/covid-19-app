// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    id: json['id'] as int,
    country: json['country'] as String,
    countryCode: json['countryCode'] as String,
    totalCases: json['totalCases'] as int,
    newCases: json['newCases'] as int,
    totalDeaths: json['totalDeaths'] as int,
    newDeaths: json['newDeaths'] as int,
    activeCases: json['activeCases'] as int,
    totalRecovered: json['totalRecovered'] as int,
    criticalCases: json['criticalCases'] as int,
    casesPerOneMillion: (json['casesPerOneMillion'] as num)?.toDouble(),
    deathsPerOneMillion: (json['deathsPerOneMillion'] as num)?.toDouble(),
    tests: json['tests'] as int,
    testsPerOneMillion: (json['testsPerOneMillion'] as num)?.toDouble(),
    continent: json['continent'] as String,
    countryInfo: json['countryInfo'] == null
        ? null
        : CountryInfo.fromJson(json['countryInfo'] as Map<String, dynamic>),
    updated: json['updated'] as String,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'totalCases': instance.totalCases,
      'newCases': instance.newCases,
      'totalDeaths': instance.totalDeaths,
      'newDeaths': instance.newDeaths,
      'activeCases': instance.activeCases,
      'totalRecovered': instance.totalRecovered,
      'criticalCases': instance.criticalCases,
      'casesPerOneMillion': instance.casesPerOneMillion,
      'deathsPerOneMillion': instance.deathsPerOneMillion,
      'tests': instance.tests,
      'testsPerOneMillion': instance.testsPerOneMillion,
      'continent': instance.continent,
      'countryInfo': instance.countryInfo,
      'updated': instance.updated,
    };
