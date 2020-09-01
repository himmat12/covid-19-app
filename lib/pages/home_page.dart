import 'package:covid_app/components/components.dart';
import 'package:covid_app/pages/summary_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _childrenTabs = <Widget>[
    SummaryPage(),
    NewsPage(),
    MythsPage(),
    FaqPage(),
  ];

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/img/covidicn.jpg"))),
        ),
        title: Text(
          " COVID-19 TRACKER",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        onTap: onTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.globeAsia,
              color: Colors.blueAccent,
            ),
            title: Text("world"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.newspaper,
              color: Colors.blueAccent,
            ),
            title: Text("news"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.handSparkles,
              color: Colors.blueAccent,
            ),
            title: Text("myths"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.questionCircle,
              color: Colors.blueAccent,
            ),
            title: Text("FAQ"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 18),
          child: Column(
            children: <Widget>[
              // costom appbar
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       CircleAvatar(
              //         radius: 34,
              //         backgroundColor: Colors.transparent,
              //         child: Image.asset(
              //           "assets/img/covidicn.jpg",
              //           fit: BoxFit.scaleDown,
              //         ),
              //       ),
              //       Text(
              //         " COVID-19 TRACKER",
              //         style: Theme.of(context).textTheme.headline5,
              //       ),
              //     ],
              //   ),
              // ),

              _childrenTabs[_selectedIndex],
            ],
          ),
        ),
      ),
    );
  }
}
