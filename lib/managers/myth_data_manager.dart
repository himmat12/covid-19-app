import 'package:covid_app/model/api/myth_model.dart';
import 'package:covid_app/model/services/myth_data_service.dart';

class MythDataManager {
  Stream<List<Myth>> get mythStream =>
      Stream.fromFuture(MythDateService.getMyth());
}
