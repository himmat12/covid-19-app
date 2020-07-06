import 'dart:convert' as convert;
import 'package:covid_app/components/components.dart';
import 'package:covid_app/pages/country_summary_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  var data;
  var nepalData;
  bool isLoading = true;
  String url;

  Future getWorldData() async {
    url = "https://data.nepalcorona.info/api/v1/world";
    var response = await http.get(url);
    setState(() {
      data = convert.json.decode(response.body);
      isLoading = false;

      WorldSummary worldData = new WorldSummary(
        cases: data['cases'],
        active: data['active'],
        critical: data['critical'],
        deaths: data['deaths'],
        recovered: data['recovered'],
        todayCases: data['todayCases'],
        todayDeaths: data['todayDeaths'],
        todayRecovered: data['todayRecovered'],
      );

      print(worldData.cases);
    });
  }

  Future getNepalData() async {
    url = "https://nepalcorona.info/api/v1/data/nepal";
    var response = await http.get(url);
    setState(() {
      nepalData = convert.json.decode(response.body);
      // print(nepalData);
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getWorldData();
    getNepalData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Divider(
            height: 5,
          ),

          // World header
          ListTile(
            title: Row(
              children: <Widget>[
                Text(
                  "World",
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  FontAwesomeIcons.globeAsia,
                  size: 18,
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          isLoading == true
              ? Column(
                  children: <Widget>[
                    Container(
                        width: 200,
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            CircularProgressIndicator(),
                            Text(
                              "   Loading...",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ],
                )
              : ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // world data covid
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Total Cases",
                          jsonData: data['cases'],
                        ),
                        CostomCard(
                          title: "Cases (Today)",
                          jsonData: data['todayCases'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Active Cases",
                          jsonData: data['active'],
                        ),
                        CostomCard(
                          title: "Critical Cases",
                          jsonData: data['critical'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Recovered",
                          jsonData: data['recovered'],
                        ),
                        CostomCard(
                          title: "Recovered (Today)",
                          jsonData: data['critical'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Deaths",
                          jsonData: data['deaths'],
                        ),
                        CostomCard(
                          title: "Deaths (Today)",
                          jsonData: data['todayDeaths'],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),

          // country wise data navigator
          Card(
            elevation: 0.5,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CountryWiseInfectionSummary()));
              },
              title: Text(
                "Country",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Icon(
                FontAwesomeIcons.mapMarkedAlt,
                size: 14,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          // world covid cases status bar
          // Card(
          //   elevation: 0.5,
          //   child: ListTile(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => WorldStatus(
          //                     cases: data['cases'],
          //                     active: data['active'],
          //                     critical: data['critical'],
          //                     recovered: data['recovered'],
          //                     deaths: data['deaths'],
          //                   )));
          //     },
          //     title: Text(
          //       "World status",
          //       style: TextStyle(
          //           color: Theme.of(context).primaryColorDark,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500),
          //     ),
          //     trailing: Icon(
          //       FontAwesomeIcons.chartPie,
          //       size: 14,
          //       color: Theme.of(context).primaryColor,
          //     ),
          //   ),
          // ),

          SizedBox(
            height: 20,
          ),

          Divider(),

          // Nepal header
          ListTile(
            title: Row(
              children: <Widget>[
                Text(
                  "Nepal",
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 16,
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          isLoading == true
              ? Column(
                  children: <Widget>[
                    Container(
                        width: 200,
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            CircularProgressIndicator(),
                            Text(
                              "   Loading...",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ],
                )
              : ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // nepal data covid
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Tested",
                          jsonData: nepalData['tested_total'],
                        ),
                        CostomCard(
                          title: "RDT Tested",
                          jsonData: nepalData['tested_rdt'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Tested Positive",
                          jsonData: nepalData['tested_positive'],
                        ),
                        CostomCard(
                          title: "Tested Negative",
                          jsonData: nepalData['tested_negative'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Isolation",
                          jsonData: nepalData['in_isolation'],
                        ),
                        CostomCard(
                          title: "Quarantined",
                          jsonData: nepalData['quarantined'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CostomCard(
                          title: "Recovered",
                          jsonData: nepalData['recovered'],
                        ),
                        CostomCard(
                          title: "Total Deaths",
                          jsonData: nepalData['deaths'],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),

          // nepal covid cases status bar
          // Card(
          //   elevation: 0.5,
          //   child: ListTile(
          //     onTap: () {},
          //     title: Text(
          //       "Nepal status",
          //       style: TextStyle(
          //           color: Theme.of(context).primaryColorDark,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500),
          //     ),
          //     trailing: Icon(
          //       FontAwesomeIcons.chartPie,
          //       size: 14,
          //       color: Theme.of(context).primaryColor,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
