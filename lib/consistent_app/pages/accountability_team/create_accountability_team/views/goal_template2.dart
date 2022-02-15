import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/start.dart';
import 'package:flutter/material.dart';

class GoalTemplate2 extends StatefulWidget {
  @override
  _GoalTemplate2State createState() => _GoalTemplate2State();
}

class _GoalTemplate2State extends State<GoalTemplate2> {
  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Widget buildContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeadText(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLine(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText2(),
                buildStart(),
                SizedBox(
                  height: 10,
                ),
                buildText2(),
                buildAccomplished()
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildHeadText() {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          text: 'Goal  ',
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 16),
          children: <TextSpan>[
            TextSpan(
                text: '#startup',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget buildLine() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 2,
        height: 100,
        color: Colors.grey,
      ),
    );
  }

  Widget buildText2() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "Everyday code on consistent app",
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  Widget buildStart() {
    return Row(
      children: [
        Text("Start"),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StartButton()),
              );
            },
            icon: Icon(
              Icons.play_arrow,
              color: Colors.blue,
            ))
      ],
    );
  }

  Widget buildAccomplished() {
    return Text("Accomplished at 12 am", style: TextStyle(color: Colors.green));
  }
}
