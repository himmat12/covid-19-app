import 'package:flutter/material.dart';

class SearchCountry extends SearchDelegate {
  var apiData;
  SearchCountry({this.apiData});

  List<String> recentList = [];

  @override
  TextInputType get keyboardType => TextInputType.text;
  @override
  TextInputAction get textInputAction => TextInputAction.search;

  @override
  String get searchFieldLabel => "search country";

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        Navigator.pop(context);
      });

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          },
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    query.isEmpty == false ? recentList.add(query) : null;
    print(recentList);
    // String searchedResult;
    return query == ""
        ? ListView.builder(
            itemCount: recentList.length,
            itemBuilder: (contxet, index) {
              return ListTile(
                leading: Icon(Icons.history),
                title: Text(recentList[index]),
              );
            },
          )
        : ListView.separated(
            itemCount: apiData.length,
            separatorBuilder: (context, index) => Divider(
              height: 0,
            ),
            itemBuilder: (context, index) {
              // print(query);
              return ListTile(
                leading: Icon(Icons.search),
                title: Text(query),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
      itemCount: apiData.length,
      separatorBuilder: (context, index) => Divider(
        height: 0,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.search),
          title: Text(apiData[index + 2]['country']),
        );
      },
    );
  }
}
