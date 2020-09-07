import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_app/components/components.dart';
import 'package:covid_app/managers/myth_data_manager.dart';
import 'package:covid_app/model/api/myth_model.dart';
import 'package:flutter/material.dart';

class MythsPage extends StatefulWidget {
  @override
  _MythsPageState createState() => _MythsPageState();
}

class _MythsPageState extends State<MythsPage> {
  MythDataManager mythDataManager = MythDataManager();

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

        StreamBuilder(
          stream: mythDataManager.mythStream,
          builder: (context, snapshot) {
            List<Myth> myth = snapshot.data;

            if (snapshot.hasError) {
              return Center(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: AssetImage("assets/img/404.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  child: Text(
                    "error occured check your internet connection ..",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return myth == null
                ? Column(
                    children: [
                      LoadingContainer(boxHeight: 100),
                      LoadingContainer(boxHeight: 200),
                      LoadingContainer(boxHeight: 100),
                      LoadingContainer(boxHeight: 200),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: myth.length,
                    itemBuilder: (context, index) {
                      return myth[index].imageUrl == null
                          ? SizedBox()
                          : Container(
                              child: CachedNetworkImage(
                                imageUrl: myth[index].imageUrl,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            );
                    },
                  );
          },
        )

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
        //         itemCount: myths.length,
        //         itemBuilder: (context, index) => Container(
        //           padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
        //           child: Card(
        //             elevation: 0,
        //             child: Image.network(
        //               myths[index]['image_url'].toString(),
        //               fit: BoxFit.scaleDown,
        //             ),
        //           ),
        //         ),
        //       ),
      ],
    );
  }
}
