import 'dart:convert' as convert;
import 'package:covid_app/components/components.dart';
import 'package:covid_app/pages/country_summary_page.dart';
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

  void getWorldData() async {
    url = "https://data.nepalcorona.info/api/v1/world";
    var response = await http.get(url);
    setState(() {
      data = convert.json.decode(response.body);
      isLoading = false;
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

// world status bar get percentage methods
  double getActivePercent() {
    double res;
    String dot;
    setState(() {
      percent = (data['active'] / data['cases']) * 100;

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

  double getCriticalPercent() {
    double res;
    String dot;
    setState(() {
      percent = (data['critical'] / data['cases']) * 100;

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

  double getRecoveredPercent() {
    double res;
    String dot;
    setState(() {
      percent = (data['recovered'] / data['cases']) * 100;

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

  double getDeathsPercent() {
    double res;
    String dot;
    setState(() {
      percent = (data['deaths'] / data['cases']) * 100;

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
  double getNpPositivePercent() {
    double res;
    String dot;
    setState(() {
      percent =
          (nepalData['tested_positive'] / nepalData['tested_total']) * 100;

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

  double getNpNegativePercent() {
    double res;
    String dot;
    setState(() {
      percent =
          (nepalData['tested_negative'] / nepalData['tested_total']) * 100;

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

  double getNpIsolationPercent() {
    double res;
    String dot;
    setState(() {
      percent =
          (nepalData['in_isolation'] / nepalData['tested_positive']) * 100;

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

  double getNpRecoveredPercent() {
    double res;
    String dot;
    setState(() {
      percent = (nepalData['recovered'] / nepalData['tested_positive']) * 100;

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

  double getNpDeathsPercent() {
    double res;
    String dot;
    setState(() {
      percent = (nepalData['deaths'] / nepalData['tested_positive']) * 100;

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
                                    data['cases'].toString() +
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
                                      percentage: getActivePercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getActivePercent().toString() +
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
                                      percentage: getCriticalPercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getCriticalPercent().toString() +
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
                                      percentage: getRecoveredPercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getRecoveredPercent().toString() +
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
                                      percentage: getDeathsPercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getDeathsPercent().toString() +
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
                            // crossAxisAlignment: CrossAxisAlignment.start,
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
                                      percentage: getNpPositivePercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNpPositivePercent().toString() +
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
                              //  tested positive status percent bar
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
                                      percentage: getNpNegativePercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNpNegativePercent().toString() +
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
                                      percentage: getNpIsolationPercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNpIsolationPercent().toString() +
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
                                      percentage: getNpRecoveredPercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNpRecoveredPercent().toString() +
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
                                      percentage: getNpDeathsPercent(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  " +
                                            getNpDeathsPercent().toString() +
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
        ],
      ),
    );
  }
}
