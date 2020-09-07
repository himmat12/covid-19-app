import 'package:covid_app/components/components.dart';
import 'package:covid_app/managers/faq_data_manager.dart';
import 'package:covid_app/model/api/faq_model.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  bool isNp = false;
  FAQManager faqManager = FAQManager();

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

        StreamBuilder(
          stream: faqManager.faqStream,
          builder: (context, snapshot) {
            List<FAQ> faq = snapshot.data;

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
            return faq == null
                ? Column(
                    children: [
                      LoadingContainer(boxHeight: 110),
                      LoadingContainer(boxHeight: 110),
                      LoadingContainer(boxHeight: 110),
                      LoadingContainer(boxHeight: 110),
                    ],
                  )
                : isNp == true
                    ? ListView.builder(
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
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: ExpansionTile(
                                  // questions
                                  title: Text(
                                    faq[index].question_np == null
                                        ? "no data"
                                        : faq[index].question_np,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "About: " + faq[index].category == null
                                        ? "no data"
                                        : faq[index].category,
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
                                            faq[index].answer_np == null
                                                ? "no data"
                                                : faq[index].answer_np,
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
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: ExpansionTile(
                                  // questions
                                  title: Text(
                                    faq[index].question,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "About: " + faq[index].category,
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
                                            faq[index].answer,
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
                      );
          },
        ),
      ],
    );
  }
}
