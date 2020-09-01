import 'dart:convert';
import 'package:covid_app/model/world_status.dart';
import 'package:http/http.dart' as http;

class WorldDataService {
  static String url;
  static var data;
  static var response;
  static WorldStatusModel worldData;

  static Future<WorldStatusModel> getWorldData() async {
    url = "https://data.nepalcorona.info/api/v1/world";
    response = await http.get(url);
    data = json.decode(response.body);
    worldData = WorldStatusModel.fromJson(data);
    return worldData;
  }
}
