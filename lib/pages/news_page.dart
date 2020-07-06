import 'dart:convert';
import 'package:covid_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var news;
  bool isLoading = true;
  String url;

  Future getNews() async {
    url = "https://nepalcorona.info/api/v1/news";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      news = json.decode(response.body)['data'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getNews();
  }

  // url launching method
  // Future<Void> _launched;

  Future<void> _urlLauncher(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw "Cannot launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // News header
        ListTile(
          title: Row(
            children: <Widget>[
              Text(
                "News",
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
                FontAwesomeIcons.solidNewspaper,
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
                itemCount: news.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    _urlLauncher(news[index]['url'].toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Card(
                      elevation: 0,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            // news title
                            ListTile(
                              title: Text(
                                news[index]['title'].toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(news[index]['source'].toString()),
                            ),
                            // news image
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Image.network(
                                news[index]['image_url'].toString(),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            // news summary
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                news[index]['summary'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
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
