import 'package:covid_app/components/components.dart';
import 'package:covid_app/managers/search_country_manager.dart';
import 'package:covid_app/model/api/country_model.dart';
import 'package:flutter/material.dart';

class SearchCountry extends SearchDelegate {
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
        // Navigator.pop(context);
        close(context, null);
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
    CountryManager countryManager = CountryManager();
    return StreamBuilder<List<Country>>(
        stream: countryManager.countrySearchStream(query: query),
        // ignore: missing_return
        builder: (context, snapshot) {
          List<Country> countryList = snapshot.data;
          switch (snapshot.connectionState) {
            case (ConnectionState.waiting):
              return LinearProgressIndicator();
            case (ConnectionState.done):
              return ListView.builder(
                itemCount: query != null && query.isNotEmpty
                    ? countryList.length
                    : countryList.length - 2,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: ExpansionTile(
                        leading: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          width: 50,
                          child: query != null && query.isNotEmpty
                              ? countryList[index].countryInfo == null
                                  ? null
                                  : Image.network(
                                      countryList[index].countryInfo.flag,
                                      fit: BoxFit.scaleDown,
                                    )
                              : countryList[index + 2].countryInfo == null
                                  ? null
                                  : Image.network(
                                      countryList[index + 2].countryInfo.flag,
                                      fit: BoxFit.scaleDown,
                                    ),
                        ),
                        title: Text(
                          query != null && query.isNotEmpty
                              ? countryList[index].country == null
                                  ? "---"
                                  : countryList[index].country
                              : countryList[index + 2].country == null
                                  ? "---"
                                  : countryList[index + 2].country,
                        ),
                        subtitle: Text(
                          query != null && query.isNotEmpty
                              ? countryList[index].continent == null
                                  ? "---"
                                  : countryList[index].continent
                              : countryList[index + 2].continent == null
                                  ? "---"
                                  : countryList[index + 2].continent,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                        children: <Widget>[
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              // country wise data covid
                              Row(
                                children: <Widget>[
                                  CostomCard(
                                    title: "Tested",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].tests
                                        : countryList[index + 2].tests,
                                  ),
                                  CostomCard(
                                    title: "Recovered",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].totalRecovered
                                        : countryList[index + 2].totalRecovered,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  CostomCard(
                                    title: "Total Cases",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].totalCases
                                        : countryList[index + 2].totalCases,
                                  ),
                                  CostomCard(
                                    title: "New Cases",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].newCases
                                        : countryList[index + 2].newCases,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  CostomCard(
                                    title: "Active Cases",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].activeCases
                                        : countryList[index + 2].activeCases,
                                  ),
                                  CostomCard(
                                    title: "Critical Cases",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].criticalCases
                                        : countryList[index + 2].criticalCases,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  CostomCard(
                                    title: "Total Deaths",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].totalDeaths
                                        : countryList[index + 2].totalDeaths,
                                  ),
                                  CostomCard(
                                    title: "New Deaths",
                                    jsonData: query != null && query.isNotEmpty
                                        ? countryList[index].newDeaths
                                        : countryList[index + 2].newDeaths,
                                  ),
                                ],
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
              );
              break;
            case ConnectionState.none:
              // ignore: todo
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              // ignore: todo
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // ignore: todo
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              // ignore: todo
              // TODO: Handle this case.
              break;
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "Search country by name (eg : nep) for Nepal\nin lowercase like abc ...",
        style:
            Theme.of(context).textTheme.subtitle1.apply(color: Colors.blueGrey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
