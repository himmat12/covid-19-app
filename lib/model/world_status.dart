class WorldStatusModel {
  int cases;
  int active;
  int critical;
  int recovered;
  int deaths;

  WorldStatusModel({
    this.cases,
    this.active,
    this.recovered,
    this.deaths,
  });

  WorldStatusModel.fromJson(parsedData) {
    cases = parsedData['cases'];
    active = parsedData['active'];
    critical = parsedData['critical'];
    recovered = parsedData['recovered'];
    deaths = parsedData['deaths'];
  }
}
