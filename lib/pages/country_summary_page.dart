import 'dart:convert' as convert;
import 'package:covid_app/components/components.dart';
import 'package:covid_app/model/api/country_model.dart';
import 'package:covid_app/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class CountryWiseInfectionSummary extends StatefulWidget {
  @override
  _CountryWiseInfectionSummaryState createState() =>
      _CountryWiseInfectionSummaryState();
}

class _CountryWiseInfectionSummaryState
    extends State<CountryWiseInfectionSummary> {
  List data;
  var url;
  bool isloading = true;
  List<Country> countries = [];

  Future getDataByCountry() async {
    url = "https://nepalcorona.info/api/v1/data/world";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    data = convert.json.decode(response.body);
    setState(() {
      isloading = false;
      countries = data.map((json) => Country.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataByCountry();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Country wise data"),
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () {
          //       showSearch(
          //         context: context,
          //         delegate: SearchCountry(apiData: data),
          //       );
          //     },
          //     icon: Icon(
          //       FontAwesomeIcons.search,
          //       size: 18,
          //     ),
          //   )
          // ],
        ),
        body: isloading == true
            ? Column(
                children: <Widget>[
                  LoadingContainer(boxHeight: 80),
                  LoadingContainer(boxHeight: 70),
                  LoadingContainer(boxHeight: 60),
                  LoadingContainer(boxHeight: 50),
                  LoadingContainer(boxHeight: 40),
                  LoadingContainer(boxHeight: 30),
                  // LoadingContainer(boxHeight: 20),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length - 2,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ExpansionTile(
                              leading: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 50,
                                width: 50,
                                child: Image.network(
                                  countries[index + 2].countryInfo.flag,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              title: Text(
                                countries[index + 2].country,
                              ),
                              subtitle: Text(
                                countries[index + 2].continent,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              children: <Widget>[
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    // country wise data covid
                                    Row(
                                      children: <Widget>[
                                        CostomCard(
                                          title: "Tested",
                                          jsonData: countries[index + 2].tests,
                                        ),
                                        CostomCard(
                                          title: "Recovered",
                                          jsonData: countries[index + 2]
                                              .totalRecovered,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CostomCard(
                                          title: "Total Cases",
                                          jsonData:
                                              countries[index + 2].totalCases,
                                        ),
                                        CostomCard(
                                          title: "New Cases",
                                          jsonData:
                                              countries[index + 2].newCases,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CostomCard(
                                          title: "Active Cases",
                                          jsonData:
                                              countries[index + 2].activeCases,
                                        ),
                                        CostomCard(
                                          title: "Critical Cases",
                                          jsonData: countries[index + 2]
                                              .criticalCases,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CostomCard(
                                          title: "Total Deaths",
                                          jsonData:
                                              countries[index + 2].totalDeaths,
                                        ),
                                        CostomCard(
                                          title: "New Deaths",
                                          jsonData:
                                              countries[index + 2].newDeaths,
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
