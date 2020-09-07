import 'package:covid_app/components/components.dart';
import 'package:covid_app/managers/search_country_manager.dart';
import 'package:covid_app/model/api/country_model.dart';
import 'package:covid_app/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CountryWiseInfectionSummary extends StatefulWidget {
  @override
  _CountryWiseInfectionSummaryState createState() =>
      _CountryWiseInfectionSummaryState();
}

class _CountryWiseInfectionSummaryState
    extends State<CountryWiseInfectionSummary> {
  CountryManager countryManager = CountryManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country wise data"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchCountry(),
              );
            },
            icon: Icon(
              Icons.search,
              size: 26,
            ),
          ),
          SizedBox(width: 6),
        ],
      ),
      body: StreamBuilder<List<Country>>(
        stream: countryManager.countryStream,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage("assets/img/404.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                child: Text(
                  "error occured check your internet connection ..",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .apply(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          List<Country> countries = snapshot.data;

          return countries == null
              ? LinearProgressIndicator()
              : ListView.builder(
                  itemCount: snapshot.data.length - 2,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                                      jsonData:
                                          countries[index + 2].totalRecovered,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    CostomCard(
                                      title: "Total Cases",
                                      jsonData: countries[index + 2].totalCases,
                                    ),
                                    CostomCard(
                                      title: "New Cases",
                                      jsonData: countries[index + 2].newCases,
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
                                      jsonData:
                                          countries[index + 2].criticalCases,
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
                                      jsonData: countries[index + 2].newDeaths,
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
                );
        },
      ),
    );
  }
}
