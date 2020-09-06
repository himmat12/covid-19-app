import 'dart:convert';
import 'package:covid_app/model/api/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static String url;
  static List data = [];
  static var response;
  static List<News> newsList = [];

  static Future<List<News>> getNews() async {
    url = "https://nepalcorona.info/api/v1/news";
    response = await http.get(url, headers: {"Accept": "application/json"});
    data = json.decode(response.body)['data'];
    newsList = data.map((json) => News.fromJson(json)).toList();

    return newsList;
  }
}
