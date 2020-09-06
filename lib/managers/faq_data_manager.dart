import 'package:covid_app/model/api/faq_model.dart';
import 'package:covid_app/model/services/faq_data_service.dart';

class FAQManager {
  Stream<List<FAQ>> get faqStream => Stream.fromFuture(FAQService.getFAQ());
}
