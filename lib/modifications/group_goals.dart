

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupGoals extends StatelessWidget {
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  final displayATCtrl = Get.find<DisplayATCtrl>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayGoalCtrl>(
        id: groupGoals,
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
                    ),
                    child: ExpansionTile(
                      collapsedBackgroundColor: Colors.white,
                      title: Text(
                        "One Time Goals",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        displayATCtrl.memberNames +
                            " - to be done alteast once by each of you.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: displayGoalCtrl?.groupGoalsList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ShortGoals(
                                  text: displayGoalCtrl?.groupGoalsList[index]);
                            })
                      ],
                    ),
                  )));
        });
  }

  Widget buildGroupGoals() {
    return Text("Reading a book");
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
