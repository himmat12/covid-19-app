import 'dart:async';

import 'package:covid_app/model/api/country_model.dart';
import 'package:covid_app/model/services/country_data_service.dart';

class CountryManager {
  Stream<List<Country>> get countryStream =>
      Stream.fromFuture(CountryDataService.getCountryData());

  Stream<List<Country>> countrySearchStream({query}) =>
      Stream.fromFuture(CountryDataService.getCountryData(query: query));
}
