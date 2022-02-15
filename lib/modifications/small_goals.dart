import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallGoals extends StatelessWidget {
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();

  // List<Map> goalText = [
  //   {"text": "5 pushups"},
  //   {"text": "2 min focus on breath"},
  //   {"text": "complete a study topic"},
  //   {"text": "Read a page of book that u think can benefit u"},
  //   {"text": "5 glasses of water throughout the day"},
  //   {"text": "Eat a fruit"},
  //   {"text": "see the Sun rise!"},
  //   {"text": "Sleep early (Now that's a challenge)"},
  //   {
  //     "text":
  //         "Give 30 min to the skill you've been planning to learn! (Maybe for ages;)"
  //   },
  // ];
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 8.0, right: 0, left: 0),
      child: GetBuilder<DisplayGoalCtrl>(
          id: smallGoals,
          builder: (_) {
            return Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    // color: c1,
                  ),
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.white,
                    // backgroundColor: Colors.blue[100].withOpacity(.3),
                    title: Text(
                      "1 min goals",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Do these tiny goals as often as possible.",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: displayGoalCtrl?.smallGoalsList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ShortGoals(
                                text: displayGoalCtrl?.smallGoalsList[index]);
                          })
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ShortGoals extends StatelessWidget {
  String text;
  ShortGoals({this.text});
  final createGoalCtrl = Get.find<CreateGoalCtrl>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: TextButton(
        onPressed: () {
          createGoalCtrl.showAddOption(text, context);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
    // ListTile(
    //   title:  Text('widget.text')
    // );
  }
}
