import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            buildAppLogo(),
            buildLetsActTogtext(),
            SizedBox(
              height: 5,
            ),
            buildConsistencyText(),
            SizedBox(height: 40),
            // Container(child: CircularProgressIndicator()),
          ],
        ),
   
    );
  }

  Padding buildAppLogo() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: CircleAvatar(
          radius: 50,
          backgroundImage:
              ExactAssetImage('assets/images/ic_launcher-playstore.png')),
    );
  }

  Padding buildConsistencyText() {
    return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'build Consistency through Accountability',
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.blueGrey.shade600,
              ),
              speed: const Duration(milliseconds: 50),
            ),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 10),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ));
  }

  RichText buildLetsActTogtext() {
    return RichText(
      text: TextSpan(
        text: "",
        style: TextStyle(color: Colors.black, fontSize: 20),
        children: [
          TextSpan(text: "Let's "),
          TextSpan(
            text: "Akt ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "together!"),
        ],
      ),
    );
  }
}
