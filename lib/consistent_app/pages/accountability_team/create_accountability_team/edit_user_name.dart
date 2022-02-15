import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDisplayName extends StatelessWidget {
  final createGoalCtrl = Get.find<CreateGoalCtrl>();
  final authPageCtrl = Get.find<AuthPageCtrl>();
  final displayAtCtrl = Get.find<DisplayATCtrl>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey[100],
                  child: TextFormField(
                    controller: displayAtCtrl?.displayNameCtrl,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "what people call you?"),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                if (displayAtCtrl.displayNameCtrl.text.length > 0) {
                  createGoalCtrl.updateDisplayNameToMongoD();
                  Get.back();
                } else {
                  Get.back();
                  Get.snackbar(
                    "Hey!",
                    "We are pretty sure you do have a name :)",
                    duration: Duration(seconds: 2),
                    snackStyle: SnackStyle.FLOATING,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              icon: Icon(Icons.send_outlined)),
        ],
      ),
    );
  }
}
