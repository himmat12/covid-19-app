import 'dart:convert';

import 'package:covid_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class WorldStatus extends StatefulWidget {
  @override
  _WorldStatusState createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus> {
  double percent;

  String url;
  var data;
  bool isLoading = true;
  List<WorldStatusModel> worldStatsLists = [];

  Future<void> getData() async {
    url = "https://data.nepalcorona.info/api/v1/world";
    var response = await http.get(url);
    setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
  }

  double getActivePercent() {
    setState(() {
      percent = (data['active'] / data['cases']) * 100;
    });
    return percent;
  }

  double getCriticalPercent() {
    setState(() {
      percent = (data['critical'] / data['cases']) * 100;
    });
    return percent;
  }

  double getRecoveredPercent() {
    setState(() {
      percent = (data['recovered'] / data['cases']) * 100;
    });
    return percent;
  }

  double getDeathsPercent() {
    setState(() {
      percent = (data['deaths'] / data['cases']) * 100;
    });
    return percent;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("world status"),
        ),
        body: isLoading == true
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
            : Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text("cases: " + data['cases'].toString()),
                      ProgressBar(
                        width: 200,
                        height: 14,
                        percentage: getActivePercent(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProgressBar(
                        width: 200,
                        height: 14,
                        percentage: getCriticalPercent(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProgressBar(
                        width: 200,
                        height: 14,
                        percentage: getRecoveredPercent(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProgressBar(
                        width: 200,
                        height: 14,
                        percentage: getDeathsPercent(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
