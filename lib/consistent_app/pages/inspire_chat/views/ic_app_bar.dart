import 'package:akt_mongo/consistent_app/model/accoutability_team_model.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

final displayInspireChat = Get.find<DisplayInspireChatCtrl>();
final loginPageCtrl = Get.find<AuthPageCtrl>();

Widget icAppBar(context) {
  String shareText = "*Ever felt alone trying to be consistent on your goals?*"
      "\n\nWell not anymore!.\n\nIntroducing *Akt* app.\n\n- Get 2 accountability partners, accomplish your goals and todo list together!"
      "\n\n- Get inspired from each other's posts and progress together to unleash your best version."
      "\n\n*Download the Akt app now!*";

  _onShare() {
    print("inside _onShare");
    Share.share(shareText + "\n\n" + displayInspireChat?.appUrl);
  }

  final loginPageCtrl = Get.find<AuthPageCtrl>();
  final displayAtCtrl = Get.find<DisplayATCtrl>();
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();

  clearData() async{
    displayAtCtrl.accountabilityTeam = AccountabilityTeamModel();
    displayGoalCtrl.goalsList = <GoalModel>[];
    displayGoalCtrl.accomplishedGoalsList = <GoalModel>[];
   displayAtCtrl.totalGoalsAccomplished = 0;
   displayAtCtrl.totalGoalsCommitted = 0;
   await displayAtCtrl.showMeButtonCtrl?.write(loginPageCtrl.currentUser.id, false);
  }

  void handleClick(String value) async{
    switch (value) {
      case 'Logout':
        print("Logout was pressed");
        await clearData();
        loginPageCtrl.logout();

        break;
      // case 'Edit Username':
      //   EditDisName();
      //   break;
      // case 'Check for updates':
      //   Get.to(UpdateApp());
      //   break;
      case 'Recommend app to friends':
        print("recommend was pressed");
        _onShare();
    }
  }

  return AppBar(
    leadingWidth: 5,
    elevation: 2.0,
    backgroundColor: Colors.white,
    title: Row(
      children: [
        RichText(
          text: TextSpan(
              text: "Akt ",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              children: [
                TextSpan(
                  text: ". connect",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
        ),
        // GlobalToggleBtn()
      ],
    ),
    actions: [
      Row(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 0.0),
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => ICAdd()));
          //     },
          //     icon: Icon(
          //       Icons.add,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_outlined, color: Colors.black),
            onSelected: (value) {
              handleClick(value);
            },
            itemBuilder: (BuildContext context) {
              return {
                'Logout',
                // 'Check for updates',
                'Recommend app to friends'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    ],
  );
}
