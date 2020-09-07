import 'dart:convert';

import 'package:covid_app/managers/district_data_manager.dart';
import 'package:covid_app/model/api/district_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DistrictPage extends StatefulWidget {
  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  DistrictManager districtManager = DistrictManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("districtList"),
      ),
      body: StreamBuilder(
          stream: districtManager.districtStream,
          builder: (context, snapshot) {
            List<District> districtList = snapshot.data;

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

            return districtList == null
                ? LinearProgressIndicator()
                : ListView.builder(
                    itemCount: districtList.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(districtList[index].title_en +
                            " " +
                            "( " +
                            districtList[index].title_ne +
                            " )"),
                        subtitle: Text("Code : " + districtList[index].code),
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("bbox :"),
                                  Text(districtList[index].bbox[0].toString(),
                                      style:
                                          Theme.of(context).textTheme.caption),
                                  Column(
                                    children: [
                                      Text(
                                          districtList[index]
                                              .bbox[1]
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption),
                                      Text(
                                          districtList[index]
                                              .bbox[2]
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Centroid :"),
                                  Text(
                                      "Type : " +
                                          districtList[index].centroid.type,
                                      style:
                                          Theme.of(context).textTheme.caption),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //   color: Theme.of(context).primaryColorLight,
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Lat : " +
                                                  districtList[index]
                                                      .centroid
                                                      .coordinates[0]
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .apply(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                          Text(
                                              "Lng : " +
                                                  districtList[index]
                                                      .centroid
                                                      .coordinates[1]
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .apply(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
          }),
    );
  }
}
