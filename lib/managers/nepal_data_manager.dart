import 'package:covid_app/model/nepal_status_model.dart';
import 'package:covid_app/model/services/nepal_data_service.dart';

class NepalDataManager {
  Stream<NepalStatusModel> get nepalDataStream =>
      Stream.fromFuture(NepalDataService.getNepalData());
}
