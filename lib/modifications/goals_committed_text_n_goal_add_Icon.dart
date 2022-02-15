import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/commit_your_goal_tf.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsCommittedTextnGoalAddIcon extends StatefulWidget {
  @override
  _GoalsCommittedTextnGoalAddIconState createState() =>
      _GoalsCommittedTextnGoalAddIconState();
}

class _GoalsCommittedTextnGoalAddIconState
    extends State<GoalsCommittedTextnGoalAddIcon> {
  final displayATCtrl = Get.find<DisplayATCtrl>();

  // List<String> names = ["Karan", "Arjun", "Naina", "Riya"];
  // bool valuesecond = false;
  // final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  final createGoalCtrl = Get.put<CreateGoalCtrl>(CreateGoalCtrl());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayGoalCtrl>(
        id: displayGoalsId,
        builder: (_) {
          return Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.blue[100].withOpacity(.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  collapsedBackgroundColor: Colors.white,
                  // backgroundColor: Colors.blue[100].withOpacity(.3),

                  // trailing: Icon(Icons.expand_more),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: buildGoalsCommitted(_)),
                          buildHideShowIcon(_),
                          Visibility(
                            child: buildGoalAddIcon(),
                            visible: _.selectedUserId == groupProgressId ||
                                    _.selectedUserId == displayATCtrl.user.id
                                ? true
                                : false,
                          )
                        ],
                      ),

                      // createGoalCtrl.isUploading
                      //     ? LinearProgressIndicator()
                      //     : Container(),
                    ],
                  ),
                  // subtitle: createGoalCtrl.isUploading
                  //     ? LinearProgressIndicator()
                  //     : Container(),
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            _?.goalsList?.length == 0
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "0 goals",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: buildhideAccomplishedui(_),
                                  ),
                            goalsList(_),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
          );
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     buildGoalsCommitted(_),
          //      buildGoalAddIcon()],
          // );
        });
  }

  Widget buildHideShowIcon(DisplayGoalCtrl _) {
    return InkWell(
      onTap: () {
        _?.hideAccomplishedGoals();
        Get.snackbar(
            _.isHideAccomplishedClicked
                ? "accomplished goals hidden"
                : "accomplished goals shown",
            "",
            snackPosition: SnackPosition.BOTTOM);
      },
      child: _.isHideAccomplishedClicked
          ? Icon(FluentIcons.eye_hide_24_regular)
          : Icon(FluentIcons.eye_show_24_regular),
    );
  }

  goalsList(_) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 16),
      child: Container(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _.goalsList?.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child:
                          // _.isHideAccomplishedClicked
                          //     ? _.goalsList[index].status == accomplished
                          //         ? Container()
                          //         : GoalTemplate(_.goalsList[index])
                          //     : _.selectedUserId != groupProgressId
                          //         ? _.goalsList[index].by?.userId ==
                          //                 _.selectedUserId
                          //             ? GoalTemplate(_.goalsList[index])
                          //             : Container()
                          //         : GoalTemplate(_.goalsList[index])

                          _.displayRelevantGoals(_, index, displayATCtrl)
                      // ActionTemplate2(_.goalsList[index]),
                      );
                }),
          ],
        ),
      ),
    );
  }

  Widget buildhideAccomplishedui(DisplayGoalCtrl _) {
    return InkWell(
      onTap: () {
        _?.hideAccomplishedGoals();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // _.isHideAccomplishedClicked ? Text("show") : Text("hide"),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "Goals left ${_?.goalsList.length - _?.accomplishedGoalsList.length}",
          //     style: TextStyle(color: Colors.grey),
          //   ),
          // ),

          // Container(
          //   height: 18,
          //   width: 18,
          //   child: Image.network(
          //       "https://static.thenounproject.com/png/2210471-200.png"),
          // ),
          // //..........
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     _.isHideAccomplishedClicked
          //         ? "show accomplished"
          //         : "hide accomplished",
          //     style: TextStyle(color: Colors.grey),
          //   ),
          // ),
          //..........
        ],
      ),
    );
  }

  Widget buildGoalsCommitted(_) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Text(
        "Goals",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildGoalAddIcon() {
    return IconButton(
        onPressed: () async {
          createGoalCtrl.goalNameTeCtrl.text = "";

          await showModalBottomSheet<void>(
            isDismissible: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: CommitYourGoalTf(
                  isEditing: false,
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.add_outlined,
          size: 16,
        ));
  }
}
