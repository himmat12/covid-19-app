import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CostomCard extends StatefulWidget {
  String title;
  var jsonData;

  CostomCard({this.title, this.jsonData});

  @override
  _CostomCardState createState() => _CostomCardState();
}

class _CostomCardState extends State<CostomCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Card(
          elevation: 0.5,
          child: Container(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.jsonData.toString(),
                  style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ));
  }
}
