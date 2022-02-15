import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveAtPopUp extends StatelessWidget {
  // final displayATCtrl = Get.find<DisplayATCtrl>();
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  // final addAtCtrl = Get.put<CreateATctrl>(CreateATctrl())
  // final createGoalCtrl = Get.put<CreateGoal>(CreateGoal());
  final user = Get.find<AuthPageCtrl>().currentUser;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayATCtrl>(
        id: leaveAtPopup,
        builder: (DisplayATCtrl _) {
          return Container(
              child: Column(
            children: [
              Text(
                "You will be missed :("
                "\n\nSure you want to leave your accountability group?",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //   Text("Are you sure you don't want an accountability team?", style: TextStyle(fontSize: 14),),
                  //   SizedBox(height: 10,),
                  //  Row(
                  //    mainAxisAlignment: MainAxisAlignment.end,
                  //    children: [
                  //      GestureDetector(
                  //        onTap: (){
                  //           displayATCtrl.removeMemberFromAT();
                  //             displayATCtrl.accountabilityTeam.members
                  //                 .where((member) => member.id == user.id);
                  //             displayATCtrl.userdata
                  //                 .write("ShowMeButtonClicked", false);
                  //             displayATCtrl.user.accountabilityTeam = dontWant;
                  //             displayATCtrl.updateDontWantInAT();
                  //        },
                  //        child: Text("Yes", style: TextStyle(color: Colors.blue, fontSize: 14),)),
                  //        SizedBox(width: 10,),
                  //        GestureDetector(
                  //    onTap: (){},
                  //    child: Text("Cancel", style: TextStyle(color: Colors.blue, fontSize: 14),))
                  //    ],
                  //  ),

                  _.isYesClicked
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed: () {
                            _.leaveAt();
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "No, I'll stay",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ))
                ],
              ),
            ],
          ));
        });
  }
}
