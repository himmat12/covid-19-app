class NepalStatusModel {
  int tested;
  int rdtTested;
  int testedPositive;
  int testedNegative;
  int isoloation;
  int quarantined;
  int totalRecovered;
  int totalDeaths;

  NepalStatusModel.fromJson(Map<String, dynamic> json)
      : tested = json['tested_total'],
        rdtTested = json['tested_rdt'],
        testedPositive = json['tested_positive'],
        testedNegative = json['tested_negative'],
        isoloation = json['in_isolation'],
        quarantined = json['quarantined'],
        totalRecovered = json['recovered'],
        totalDeaths = json['deaths'];
}
