import 'dart:convert';
import 'package:covid_app/model/api/country_model.dart';
import 'package:http/http.dart' as http;

class CountryDataService {
  static String url;
  static List data;
  static var response;
  static Iterable<Country> countryList = [];

  static Future<List<Country>> getCountryData({String query}) async {
    url = "https://nepalcorona.info/api/v1/data/world";
    response = await http.get(url, headers: {'Accept': 'application/json'});
    data = json.decode(response.body);
    countryList = data.map((json) => Country.fromJson(json));

    if (query != null && query.isNotEmpty) {
      countryList = countryList
          .where((element) => element.country.toLowerCase().contains(query));
    }

    return countryList.toList();
  }
}
