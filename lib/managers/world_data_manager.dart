import 'dart:async';

import 'package:covid_app/components/components.dart';
import 'package:covid_app/model/services/world_data_service.dart';

class WorldDataManager {
  Stream<WorldStatusModel> get getWorldStream =>
      Stream.fromFuture(WorldDataService.getWorldData());
}
