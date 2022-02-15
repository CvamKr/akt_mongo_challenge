import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommitYourGoalTf extends StatefulWidget {
  String goalId;
  bool isEditing;
  CommitYourGoalTf({this.isEditing, this.goalId});
  @override
  _CommitYourGoalTfState createState() => _CommitYourGoalTfState();
}

class _CommitYourGoalTfState extends State<CommitYourGoalTf> {
  final createGoalCtrl = Get.find<CreateGoalCtrl>();
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateGoalCtrl>(builder: (_) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 50,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey[100],
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.grey.withOpacity(0.2),
            //       spreadRadius: 3.0,
            //       blurRadius: 5.0)
            // ],
          ),
          child: Row(
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.grey[100],
                    width: Get.width,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        autofocus: true,
                        controller: createGoalCtrl.goalNameTeCtrl,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Commit your goal"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () async {
                    Get.back();
                    if (createGoalCtrl.goalNameTeCtrl.text.trim() == "") {
                      Get.snackbar("Can't post an empty goal", "",
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    } else if (!widget.isEditing) {
                      await createGoalCtrl.postGoalToMongoDb();
                      // showPostToInspire(true, context, notStarted);
                    } else {
                      //...
                      // logger.d("isEditing: goalId: ${widget.goalId}");
                      // ...
                      bool success = await createGoalCtrl?.updateGoal(
                          createGoalCtrl.collectDataToUpdate(),
                          "goals",
                          widget?.goalId,
                          "abc");
                      if (success) {
                        logger.d("success");

                        createGoalCtrl
                            .refreshGoalsListAndResetAfterGoalNameUpdate();
                      } else {
                        logger.d("fail");

                        Get.snackbar("Something went wrong", "",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    }
                  },
                  icon: Icon(Icons.send_outlined)),
            ],
          ),
        ),
      );
    });
  }
}
