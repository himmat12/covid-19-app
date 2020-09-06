import 'dart:convert';
import 'package:covid_app/model/api/myth_model.dart';
import 'package:http/http.dart' as http;

class MythDateService {
  static String url;
  static List data = [];
  static var response;
  static List<Myth> mythList = [];

  static Future<List<Myth>> getMyth() async {
    url = "https://nepalcorona.info/api/v1/myths";
    response = await http.get(url, headers: {'Accept': 'application/json'});
    data = json.decode(response.body)['data'];
    mythList = data.map((json) => Myth.fromJson(json)).toList();
    return mythList;
  }
}
