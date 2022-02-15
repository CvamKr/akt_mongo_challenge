import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  final accountabilityTeamCtrl = Get.find<DisplayATCtrl>();
  num percentage = 0.33;
  double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: buildHeadText(),
          ),
          returnLPI(context, percentage)
        ],
      ),
    );
  }

  LinearPercentIndicator returnLPI(BuildContext context, num percentage) {
    return LinearPercentIndicator(
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: MainAxisAlignment.center,
      animateFromLastPercent: true,
      width: MediaQuery.of(context).size.width * 0.8,
      lineHeight: 14.0,
      percent: percentage,
      backgroundColor: Colors.blueGrey.shade100.withOpacity(0.8),
      progressColor: Colors.lightGreen,
    );
  }

  Widget buildHeadText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "Today, ",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
        ),
        TextSpan(
            text: "2",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16)),
        TextSpan(
            text: "/",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16)),
        TextSpan(
            text: "9",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16)),
        TextSpan(
            text: " actions and goals have been accomplished together",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w300)),
      ]),
    );

    //  Text(
    //     "${accountabilityTeamCtrl?.accountabilityTeam?.today?.accomplishedTasks}/${accountabilityTeamCtrl?.accountabilityTeam?.today?.totalTasks} tasks accomplished together today. ${accountabilityTeamCtrl?.accountabilityTeam?.today?.accomplishedTasks} more to go!",
    //     style: TextStyle(color: Colors.grey),
    //   ),
  }
}
