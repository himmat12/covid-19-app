import 'dart:convert' as convert;
import 'package:covid_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryWiseInfectionSummary extends StatefulWidget {
  @override
  _CountryWiseInfectionSummaryState createState() =>
      _CountryWiseInfectionSummaryState();
}

class _CountryWiseInfectionSummaryState
    extends State<CountryWiseInfectionSummary> {
  var data;
  var url;
  bool isloading = true;

  Future getDataByCountry() async {
    url = "https://nepalcorona.info/api/v1/data/world";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      data = convert.json.decode(response.body);
      isloading = false;
      print(data);
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getDataByCountry();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("data by country"),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.search,
                size: 18,
              ),
            )
          ],
        ),
        body: isloading == true
            ? Column(
                children: <Widget>[
                  Container(
                      width: 200,
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
            : Center(
                child: ListView.builder(
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
                              data[index + 2]['countryInfo']['flag'].toString(),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          title: Text(
                            data[index + 2]['country'].toString(),
                          ),
                          subtitle: Text(
                            data[index + 2]['continent'].toString(),
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
                                      jsonData: data[index + 2]['tests'],
                                    ),
                                    CostomCard(
                                      title: "Recovered",
                                      jsonData: data[index + 2]
                                          ['totalRecovered'],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    CostomCard(
                                      title: "Total Cases",
                                      jsonData: data[index + 2]['totalCases'],
                                    ),
                                    CostomCard(
                                      title: "New Cases",
                                      jsonData: data[index + 2]['newCases'],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    CostomCard(
                                      title: "Active Cases",
                                      jsonData: data[index + 2]['activeCases'],
                                    ),
                                    CostomCard(
                                      title: "Critical Cases",
                                      jsonData: data[index + 2]
                                          ['criticalCases'],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    CostomCard(
                                      title: "Total Deaths",
                                      jsonData: data[index + 2]['totalDeaths'],
                                    ),
                                    CostomCard(
                                      title: "New Deaths",
                                      jsonData: data[index + 2]['newDeaths'],
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
              ),
      ),
    );
  }
}
