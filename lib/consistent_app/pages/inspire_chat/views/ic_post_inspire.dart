import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/add_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostInspire extends StatefulWidget {
  GoalModel goal;
  PostInspire({this.goal});

  @override
  _PostInspireState createState() => _PostInspireState();
}

class _PostInspireState extends State<PostInspire> {
  // final addInspireChatCtrl = Get.put<AddInspireChatCtrl>(AddInspireChatCtrl());
  final addInspireChatCtrl = Get.find<AddInspireChatCtrl>();

  final displayInspireChatCtrl = Get.find<DisplayInspireChatCtrl>();
  final createGoalCtrl = Get.find<CreateGoalCtrl>();
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  final displayATCtrl = Get.find<DisplayATCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddInspireChatCtrl>(
        id: inspirePost,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: buildTextField()),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: _.postingToDb
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : buildPostButton(),
                    ),
                  ],
                ),
                // Padding(
                //     padding: const EdgeInsets.only(left: 8.0),
                //     child: icTag(widget.goalStatus == accomplished
                //         ? "#accomplishmentFeeling"
                //         : "#commitment")),
              ],
            ),
          );
        });
  }

  Container icTag(String tag) {
    return Container(
      height: 15,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        // color: isButtonPressed ? Colors.blue : Colors.white,

        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 4,
          ),
          padding: EdgeInsets.all(2),
          child: Text(
            tag ?? "",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget buildPostButton() {
    return IconButton(
        onPressed: () async {
          displayGoalCtrl.postt(widget.goal, addInspireChatCtrl, createGoalCtrl,
              displayInspireChatCtrl, displayATCtrl);

          // await posting();
        },
        icon: Icon(
          Icons.send_rounded,

          // style: TextStyle(
          //   color: Colors.blue,
          //   fontWeight: FontWeight.bold,
          // ),
        ));
  }

  Widget buildTextField() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        child: TextField(
          controller: addInspireChatCtrl?.userMessageCtrl,
          autofocus: false,
          minLines: 1,
          maxLines: 6,
          decoration: InputDecoration(
              hintText: widget.goal.status == accomplished
                  ? "How do you feel?!"
                  : "Write your commitment message",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
