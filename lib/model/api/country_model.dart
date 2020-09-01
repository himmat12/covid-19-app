// import 'package:covid_app/model/api/country_info.dart';
import 'package:json_annotation/json_annotation.dart';

import 'country_info.dart';

part 'country_model.g.dart';

@JsonSerializable()
class Country {
  int id;
  String country;
  String countryCode;
  int totalCases;
  int newCases;
  int totalDeaths;
  int newDeaths;
  int activeCases;
  int totalRecovered;
  int criticalCases;
  double casesPerOneMillion;
  double deathsPerOneMillion;
  int tests;
  double testsPerOneMillion;
  String continent;
  CountryInfo countryInfo;
  String updated;

  Country({
    this.id,
    this.country,
    this.countryCode,
    this.totalCases,
    this.newCases,
    this.totalDeaths,
    this.newDeaths,
    this.activeCases,
    this.totalRecovered,
    this.criticalCases,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.continent,
    this.countryInfo,
    this.updated,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
