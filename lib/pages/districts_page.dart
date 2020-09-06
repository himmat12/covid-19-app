import 'dart:convert';

import 'package:covid_app/model/api/district_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DistrictPage extends StatefulWidget {
  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  String url;
  List data;
  var response;
  bool isLoading = true;

  List<District> districts = [];

  Future getDistrict() async {
    url = "https://data.nepalcorona.info/api/v1/districts";
    response = await http.get(url);
    data = json.decode(response.body);

    setState(() {
      isLoading = false;
      districts = data.map((json) => District.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Districts"),
      ),
      body: isLoading == true
          ? LinearProgressIndicator()
          : ListView.builder(
              itemCount: districts.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(districts[index].title_en +
                      " " +
                      "( " +
                      districts[index].title_ne +
                      " )"),
                  subtitle: Text("Code : " + districts[index].code),
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
                            Text(districts[index].bbox[0].toString(),
                                style: Theme.of(context).textTheme.caption),
                            Column(
                              children: [
                                Text(districts[index].bbox[1].toString(),
                                    style: Theme.of(context).textTheme.caption),
                                Text(districts[index].bbox[2].toString(),
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Centroid :"),
                            Text("Type : " + districts[index].centroid.type,
                                style: Theme.of(context).textTheme.caption),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                // decoration: BoxDecoration(
                                //   color: Theme.of(context).primaryColorLight,
                                // ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Lat : " +
                                            districts[index]
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
                                            districts[index]
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
            ),
    );
  }
}
