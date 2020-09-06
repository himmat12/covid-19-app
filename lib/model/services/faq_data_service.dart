import 'dart:convert';
import 'package:covid_app/model/api/faq_model.dart';
import 'package:http/http.dart' as http;

class FAQService {
  static String url;
  static List data = [];
  static var response;

  static List<FAQ> faqList = [];

  static Future<List<FAQ>> getFAQ() async {
    url = "https://nepalcorona.info/api/v1/faqs";
    response = await http.get(url);
    data = json.decode(response.body)['data'];
    faqList = data.map((json) => FAQ.fromJson(json)).toList();
    return faqList;
  }
}
