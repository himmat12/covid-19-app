import 'dart:convert';

import 'package:covid_app/model/api/district_model.dart';
import 'package:http/http.dart' as http;

class DistrictDataService {
  static String url;
  static List data;
  static var response;

  static List<District> districts = [];

  static Future<List<District>> getDistrict() async {
    url = "https://data.nepalcorona.info/api/v1/districts";
    response = await http.get(url);
    data = json.decode(response.body);

    districts = data.map((json) => District.fromJson(json)).toList();
    return districts;
  }
}
