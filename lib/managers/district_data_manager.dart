import 'package:covid_app/model/api/district_model.dart';
import 'package:covid_app/model/services/district_data_service.dart';

class DistrictManager {
  Stream<List<District>> get districtStream =>
      Stream.fromFuture(DistrictDataService.getDistrict());
}
