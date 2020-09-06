import 'dart:convert';
import 'package:covid_app/components/components.dart';
import 'package:covid_app/managers/nepal_data_manager.dart';
import 'package:covid_app/managers/world_data_manager.dart';
import 'package:covid_app/model/nepal_status_model.dart';
import 'package:covid_app/pages/country_summary_page.dart';
import 'package:covid_app/pages/districts_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  var data;
  var nepalData;
  bool isLoading = true;
  String url;
  double percent;

  WorldStatusModel world;

  void getWorldData() async {
    url = "https://data.nepalcorona.info/api/v1/world";
    var response = await http.get(url);

    data = json.decode(response.body);
    setState(() {
      isLoading = false;
      world = WorldStatusModel.fromJson(data);
    });
  }

  bool isNepalLoading = true;
  Future getNepalData() async {
    url = "https://nepalcorona.info/api/v1/data/nepal";
    var response = await http.get(url);
    setState(() {
      nepalData = json.decode(response.body);
      isNepalLoading = false;
    });
  }

// world status bar get percentage methods
  double getWorldPercent(int no, int total) {
    double res;
    String dot;
    setState(() {
      percent = (no / total) * 100;

      res = percent;
    });
    if (res < 10) {
      dot = res.toString().substring(0, 4);
      return double.parse(dot);
    } else {
      dot = res.toString().substring(0, 5);
      return double.parse(dot);
    }
  }

// nepal ststus bar get percentage methods
  double getNepalPercent(int no, int total) {
    double res;
    String dot;
    setState(() {
      percent = (no / total) * 100;

      res = percent;
    });
    if (res < 10) {
      dot = res.toString().substring(0, 4);
      return double.parse(dot);
    } else {
      dot = res.toString().substring(0, 5);
      return double.parse(dot);
    }
  }

  @override
  void initState() {
    super.initState();
    getWorldData();
    getNepalData();
  }

  WorldDataManager worldDataManager = WorldDataManager();
  NepalDataManager nepalDataManager = NepalDataManager();

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

          StreamBuilder(
            stream: worldDataManager.getWorldStream,
            builder: (context, snapshot) {
              WorldStatusModel _world = snapshot.data;

              return snapshot.connectionState == ConnectionState.waiting
                  ? Column(
                      children: [
                        loadingRow(),
                        loadingRow(),
                        loadingRow(),
                        loadingRow(),
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
                              jsonData: _world.cases,
                            ),
                            CostomCard(
                              title: "Cases (Today)",
                              jsonData: world.todayCases,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            CostomCard(
                                title: "Active Cases", jsonData: world.active),
                            CostomCard(
                              title: "Critical Cases",
                              jsonData: world.critical,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            CostomCard(
                              title: "Recovered",
                              jsonData: world.recovered,
                            ),
                            CostomCard(
                              title: "Recovered (Today)",
                              jsonData: world.critical,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            CostomCard(
                              title: "Deaths",
                              jsonData: world.deaths,
                            ),
                            CostomCard(
                              title: "Deaths (Today)",
                              jsonData: world.todayDeaths,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
            },
          ),
          // isLoading == true
          //     ? Column(
          //         children: <Widget>[
          //           Container(
          //               width: 200,
          //               padding: EdgeInsets.all(12),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: <Widget>[
          //                   SizedBox(
          //                     width: 5,
          //                   ),
          //                   CircularProgressIndicator(),
          //                   Text(
          //                     "   Loading...",
          //                     style: TextStyle(
          //                         color: Theme.of(context).primaryColorDark,
          //                         fontSize: 16,
          //                         fontWeight: FontWeight.w500),
          //                   ),
          //                 ],
          //               )),
          //         ],
          //       )
          //     : ListView(
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         children: <Widget>[
          //           // world data covid
          //           Row(
          //             children: <Widget>[
          //               CostomCard(
          //                 title: "Total Cases",
          //                 jsonData: world.cases,
          //               ),
          //               CostomCard(
          //                 title: "Cases (Today)",
          //                 jsonData: world.todayCases,
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: <Widget>[
          //               CostomCard(
          //                   title: "Active Cases", jsonData: world.active),
          //               CostomCard(
          //                 title: "Critical Cases",
          //                 jsonData: world.critical,
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: <Widget>[
          //               CostomCard(
          //                 title: "Recovered",
          //                 jsonData: world.recovered,
          //               ),
          //               CostomCard(
          //                 title: "Recovered (Today)",
          //                 jsonData: world.critical,
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: <Widget>[
          //               CostomCard(
          //                 title: "Deaths",
          //                 jsonData: world.deaths,
          //               ),
          //               CostomCard(
          //                 title: "Deaths (Today)",
          //                 jsonData: world.todayDeaths,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //         ],
          //       ),

          // country wise data navigator
          Card(
            elevation: 0.3,
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
          Card(
            elevation: 0.3,
            child: Container(
              padding: EdgeInsets.all(4),
              child: ExpansionTile(
                title: Text(
                  "World status",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
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
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Total Cases: " +
                                    world.cases.toString() +
                                    "(100%)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  active status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Active ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getWorldPercent(
                                          world.active, world.cases),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getWorldPercent(
                                                    world.active, world.cases)
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  critical status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Critical ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getWorldPercent(
                                          world.critical, world.cases),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getWorldPercent(
                                                    world.critical, world.cases)
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  recovered status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Recovered ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getWorldPercent(
                                          world.recovered, world.cases),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getWorldPercent(world.recovered,
                                                    world.cases)
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  deaths status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Deaths ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getWorldPercent(
                                          world.deaths, world.cases),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getWorldPercent(
                                                    world.deaths, world.cases)
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),

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

          StreamBuilder(
              stream: nepalDataManager.nepalDataStream,
              builder: (context, snapshot) {
                NepalStatusModel nepal = snapshot.data;

                return snapshot.connectionState == ConnectionState.waiting
                    ? Column(
                        children: [
                          loadingRow(),
                          loadingRow(),
                          loadingRow(),
                          loadingRow(),
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
                                jsonData: nepal.tested,
                              ),
                              CostomCard(
                                title: "RDT Tested",
                                jsonData: nepal.rdtTested,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              CostomCard(
                                title: "Tested Positive",
                                jsonData: nepal.testedPositive,
                              ),
                              CostomCard(
                                title: "Tested Negative",
                                jsonData: nepal.testedNegative,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              CostomCard(
                                title: "Isolation",
                                jsonData: nepal.isoloation,
                              ),
                              CostomCard(
                                title: "Quarantined",
                                jsonData: nepal.quarantined,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              CostomCard(
                                title: "Recovered",
                                jsonData: nepal.totalRecovered,
                              ),
                              CostomCard(
                                title: "Total Deaths",
                                jsonData: nepal.totalDeaths,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
              }),

          // nepal covid cases status bar
          Card(
            elevation: 0.3,
            child: Container(
              padding: EdgeInsets.all(4),
              child: ExpansionTile(
                title: Text(
                  "Nepal status",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  isNepalLoading == true
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
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Total Tested: " +
                                    nepalData['tested_total'].toString() +
                                    "(100%)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  tested positive status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Positive ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getNepalPercent(
                                          nepalData['tested_positive'],
                                          nepalData['tested_total']),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNepalPercent(
                                                    nepalData[
                                                        'tested_positive'],
                                                    nepalData['tested_total'])
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  tested negative status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Negative ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getNepalPercent(
                                          nepalData['tested_negative'],
                                          nepalData['tested_total']),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNepalPercent(
                                                    nepalData[
                                                        'tested_negative'],
                                                    nepalData['tested_total'])
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                "Total Positive: " +
                                    nepalData['tested_positive'].toString() +
                                    "(100%)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  in isolation status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Isolation ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getNepalPercent(
                                          nepalData['in_isolation'],
                                          nepalData['tested_positive']),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNepalPercent(
                                                    nepalData['in_isolation'],
                                                    nepalData[
                                                        'tested_positive'])
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  recovered status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Recovered ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getNepalPercent(
                                          nepalData['recovered'],
                                          nepalData['tested_positive']),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNepalPercent(
                                                    nepalData['recovered'],
                                                    nepalData[
                                                        'tested_positive'])
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  deaths status percent bar
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Deaths ",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ProgressBar(
                                      width: 200,
                                      height: 14,
                                      percentage: getNepalPercent(
                                          nepalData['deaths'],
                                          nepalData['tested_positive']),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNepalPercent(
                                                    nepalData['deaths'],
                                                    nepalData[
                                                        'tested_positive'])
                                                .toString() +
                                            "%",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),

          // country wise data navigator
          Card(
            elevation: 0.3,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DistrictPage()));
              },
              title: Text(
                "Districts",
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
        ],
      ),
    );
  }
}

// loading rows

Widget loadingRow() {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: LoadingContainer(boxHeight: 50),
      ),
      Expanded(
        flex: 1,
        child: LoadingContainer(boxHeight: 50),
      ),
    ],
  );
}
