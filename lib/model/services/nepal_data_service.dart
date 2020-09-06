import 'dart:convert';
import 'package:covid_app/model/nepal_status_model.dart';
import 'package:http/http.dart' as http;

class NepalDataService {
  static String url;
  static var data;
  static var response;
  static NepalStatusModel nepalData;

  static Future<NepalStatusModel> getNepalData() async {
    url = "https://nepalcorona.info/api/v1/data/nepal";
    response = await http.get(url);
    data = json.decode(response.body);
    nepalData = NepalStatusModel.fromJson(data);
    return nepalData;
  }
}
