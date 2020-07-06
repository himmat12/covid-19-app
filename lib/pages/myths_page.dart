import 'dart:convert';
import 'package:covid_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MythsPage extends StatefulWidget {
  @override
  _MythsPageState createState() => _MythsPageState();
}

class _MythsPageState extends State<MythsPage> {
  var myths;
  bool isLoading = true;
  String url;

  Future getMyths() async {
    url = "https://nepalcorona.info/api/v1/myths";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'aplication/json'});
    setState(() {
      myths = json.decode(response.body)['data'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getMyths();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Myths header
        ListTile(
          title: Row(
            children: <Widget>[
              Text(
                "Myths",
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
                FontAwesomeIcons.handSparkles,
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
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: myths.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                  child: Card(
                    elevation: 0,
                    child: Image.network(
                      myths[index]['image_url'].toString(),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
