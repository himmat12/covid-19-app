import 'dart:convert';
import 'package:covid_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  var faq;
  bool isLoading = true;
  String url;
  bool isNp = false;

  Future getMyths() async {
    url = "https://nepalcorona.info/api/v1/faqs";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'aplication/json'});
    setState(() {
      faq = json.decode(response.body)['data'];
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
        // FAQ header
        ListTile(
          trailing: Container(
            width: 82,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "NP",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    // color: Theme.of(context).primaryColorDark,
                    color: Colors.deepOrange,
                  ),
                ),
                Switch(
                    value: isNp,
                    onChanged: (bool flag) {
                      setState(() {
                        isNp = flag;
                      });
                    }),
              ],
            ),
          ),
          title: Row(
            children: <Widget>[
              Text(
                "FAQ",
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
                FontAwesomeIcons.infoCircle,
                size: 16,
                color: Colors.blue,
              ),
            ],
          ),
        ),

        isNp == true
            ? isLoading == true
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
                    itemCount: faq.length,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 10),
                      child: Card(
                        elevation: 0,
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ExpansionTile(
                              // questions
                              title: Text(
                                faq[index]['question_np'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                "About: " + faq[index]['category'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              children: <Widget>[
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    // answers
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        faq[index]['answer_np'].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
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
                  )
            : isLoading == true
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
                    itemCount: faq.length,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 10),
                      child: Card(
                        elevation: 0,
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ExpansionTile(
                              // questions
                              title: Text(
                                faq[index]['question'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                "About: " + faq[index]['category'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              children: <Widget>[
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    // answers
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        faq[index]['answer'].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
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
      ],
    );
  }
}
