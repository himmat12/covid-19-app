import 'package:covid_app/model/api/news_model.dart';
import 'package:covid_app/model/services/news_data_service.dart';

class NewsManager {
  Stream<List<News>> get newsStream => Stream.fromFuture(NewsService.getNews());
}
