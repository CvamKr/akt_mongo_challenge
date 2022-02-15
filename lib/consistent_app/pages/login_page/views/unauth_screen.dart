import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'loading_widget.dart';

class LoginPage extends StatelessWidget {
  final loginPageCtrl = Get.find<AuthPageCtrl>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        LoadingWidget(),
        SizedBox(
          height: 50,
        ),
        buildSignInBtn()
      ]),
    );

    // screen1(context);
  }

  buildSignInBtn() {
    return Column(
      children: [buildSinginBtnn(), buildTermsText()],
    );
  }

  buildTermsText() {
    return Center(
      child: new RichText(
        text: new TextSpan(
          children: [
            new TextSpan(
              text: "By signing in, you agree to our ",
              style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 12),
            ),
            new TextSpan(
              text: "terms and conditions",
              style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  print("t & c was tapped");
                  _launchURL();
                },
            ),
          ],
        ),
      ),
    );
  }

  Transform buildSinginBtnn() {
    return Transform.scale(
      scale: .75,
      child: Container(
        width: Get.width * 0.9,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: FlatButton(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.blue),
            //height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 35,
                    height: 50,
                    child: Image.asset("assets/images/googleLogo.png")),
                Text(
                  "Sign in with google",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
              ],
            ),
          ),
          onPressed: () => loginPageCtrl.login(),
        ),
      ),
    );
  }

  Container screen1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0XFfeef2f3),
            Color(0xff8e9eab),

            // Colors.red
          ])),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0XFfeef2f3),
                Colors.white

                // Colors.red
              ])),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/ic_launcher-playstore.png"))),
                // child: CircleAvatar(
                //     maxRadius: 50,
                //     backgroundImage: AssetImage(
                //         "assets/images/ic_launcher-playstore.png"))
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
                child: Text(
                  "Akt",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey.shade800),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  // child: Text(
                  //   "Consistency through accountability",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.blueGrey.shade600,
                  //   ),
                  // ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Consistency through accountability',
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blueGrey.shade600,
                        ),
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 10),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              //   child: Text(
              //     "Let's sign you up!",
              //     style: TextStyle(
              //         fontSize: 33,
              //         fontWeight: FontWeight.w500,
              //         color: Colors.blueGrey.shade800),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://docs.google.com/document/d/1JzFQ2IawEwNVluFeKDNAEcrgrwR9WbHusI_K8xeGyq8/edit?usp=sharing';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
