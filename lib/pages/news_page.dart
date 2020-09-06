import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_app/components/components.dart';
import 'package:covid_app/managers/news_data_manager.dart';
import 'package:covid_app/model/api/news_model.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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

  NewsManager newsManager = NewsManager();

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

        StreamBuilder(
          stream: newsManager.newsStream,
          builder: (context, snapshot) {
            List<News> news = snapshot.data;

            return snapshot.connectionState == ConnectionState.waiting
                ? Column(
                    children: [
                      LoadingContainer(boxHeight: 80),
                      LoadingContainer(boxHeight: 80),
                      LoadingContainer(boxHeight: 80),
                      LoadingContainer(boxHeight: 80),
                      LoadingContainer(boxHeight: 80),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      // news date conversion
                      String raw = news[index].createdAt;
                      String postedDate = raw.substring(0, 10);
                      ///////////////////////////////

                      return Card(
                        elevation: 0.3,
                        child: ListTile(
                          onTap: () {
                            _urlLauncher(news[index].url);
                          },
                          contentPadding: EdgeInsets.all(10),
                          leading: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                )
                              : Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    image: DecorationImage(
                                      // image: NetworkImage(news[index].imageUrl),
                                      image: CachedNetworkImageProvider(
                                        news[index].imageUrl,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                          title: Text(
                            news[index].title,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                news[index].source + " | " + postedDate,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .apply(
                                        color:
                                            Theme.of(context).primaryColorDark),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
        //     : ListView.builder(
        //         shrinkWrap: true,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemCount: news.length,
        //         itemBuilder: (context, index) => GestureDetector(
        //           onTap: () {
        //             _urlLauncher(news[index]['url'].toString());
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        //             child: Card(
        //               elevation: 0,
        //               child: Container(
        //                 child: Column(
        //                   children: <Widget>[
        //                     // news title
        //                     ListTile(
        //                       title: Text(
        //                         news[index]['title'].toString(),
        //                         maxLines: 2,
        //                         overflow: TextOverflow.ellipsis,
        //                         style: TextStyle(
        //                           fontWeight: FontWeight.w600,
        //                           fontSize: 20,
        //                         ),
        //                       ),
        //                       subtitle: Text(news[index]['source'].toString()),
        //                     ),
        //                     // news image
        //                     Container(
        //                       padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        //                       child: Image.network(
        //                         news[index]['image_url'].toString(),
        //                         fit: BoxFit.scaleDown,
        //                       ),
        //                     ),
        //                     // news summary
        //                     Container(
        //                       padding: EdgeInsets.all(8),
        //                       child: Text(
        //                         news[index]['summary'].toString(),
        //                         style: TextStyle(
        //                           fontSize: 17,
        //                           fontWeight: FontWeight.w400,
        //                           color: Colors.black54,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
      ],
    );
  }
}
