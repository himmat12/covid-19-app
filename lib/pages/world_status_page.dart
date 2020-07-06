import 'package:covid_app/components/components.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WorldStatus extends StatefulWidget {
  var cases;
  var active;
  var critical;
  var recovered;
  var deaths;

  WorldStatus({
    this.cases,
    this.active,
    this.critical,
    this.recovered,
    this.deaths,
  });

  @override
  _WorldStatusState createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("world status"),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Text("cases: " + widget.cases.toString()),
                Text("active: " + widget.active.toString()),
                Text("critical: " + widget.critical.toString()),
                Text("recovered: " + widget.recovered.toString()),
                Text("deaths: " + widget.deaths.toString()),
                ProgressBar(
                  width: 200,
                  height: 14,
                  percentage: 77,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
