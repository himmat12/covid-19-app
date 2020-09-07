import 'package:flutter/material.dart';
import 'package:covid_app/components/components.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _delaySplashScreen() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});
    return true;
  }

  void _getHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void initState() {
    super.initState();
    _delaySplashScreen().then((status) {
      if (status == true) {
        _getHomePage();
      } else {
        SplashScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 130,
              left: 82,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(60),
                ),
                height: 120,
                width: 120,
                child: Image.asset(
                  "assets/img/covid1.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Positioned(
              top: 155,
              left: 170,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(60),
                ),
                height: 105,
                width: 105,
                child: Image.asset(
                  "assets/img/covid.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Positioned(
              top: 210,
              left: 128,
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 90,
                width: 90,
                child: Image.asset(
                  "assets/img/who.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 330,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "COVID-19 DATA",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
            // Positioned(
            //   top: MediaQuery.of(context).size.height - 298,
            //   child: Container(
            //       alignment: Alignment.bottomCenter,
            //       child: Text(
            //         "Version 1.0.0.0",
            //         textScaleFactor: 0.9,
            //         style: TextStyle(
            //           color: Theme.of(context).primaryColorDark,
            //           fontWeight: FontWeight.w300,
            //         ),
            //       )),
            // ),
            Positioned(
              top: MediaQuery.of(context).size.height - 80,
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: Duration(milliseconds: 1500),
                  baseColor: Theme.of(context).primaryColor,
                  highlightColor: Theme.of(context).primaryColorLight,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Loading ...",
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
