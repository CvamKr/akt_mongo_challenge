import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  // const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0XFfeef2f3),
            Color(0xff8e9eab),

            // Colors.red
          ])),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 75, child: Image.asset("assets/images/wifi-off.png")),
              Text(
                "No internet connection.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade800),
              ),
              Text(
                "Please reconnect to continue using the app :)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey.shade800),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
