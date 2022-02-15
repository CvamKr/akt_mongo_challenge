

import 'package:akt_mongo/consistent_app/central_services/widgets/box_decoration.dart';
import 'package:akt_mongo/consistent_app/central_services/widgets/spinkit.dart';
import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/commit_your_goal_tf.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consistent_app/pages/accountability_team/goals/controller/create_goal_ctrl.dart';
import 'bottom_model_sheet.dart';

class GoalTemplate extends StatefulWidget {
  GoalModel goal;
  GoalTemplate(this.goal);
  @override
  _GoalTemplateState createState() => _GoalTemplateState();
}

class _GoalTemplateState extends State<GoalTemplate> {
  List<String> names = ["Karan", "Arjun", "Naina", "Riya"];
  bool valuesecond = false;

  final createGoalCtrl = Get.find<CreateGoalCtrl>();
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();

  final displayATCtrl = Get.find<DisplayATCtrl>();
  int maxLines = 1;
  @override
  void initState() {
    super.initState();
    if (widget.goal.status == "accomplished") {
      valuesecond = true;
    } else {
      valuesecond = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildCheckboxNGoal();
  }

  bool isUploadingg = false;
  Widget buildCheckboxNGoal() {
    return Container(
      //color: Colors.lightBlue.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.grey,
            color: Colors.transparent,

            child: Row(
              children: [
                widget.goal.status == accomplished
                    ? buildTrophyImage()
                    : Container(height: 25, width: 25),
                //...
                // Container(
                //   height: isUploadingg ? 50 : 25,
                //   width: isUploadingg ? 50 : 25,
                //   child: isUploadingg
                //       ? Spinkit()
                //       : widget.goal.status == accomplished
                //           ? buildTrophyImage()
                //           : Container(),
                // ),
                //...
                // Visibility(
                //   visible: isUploading,
                //   child: CircularProgressIndicator(),

                //   maintainSize: true,
                //   maintainState: true,
                //   maintainAnimation: true,
                //   replacement: Visibility(
                //     maintainSize: true,
                //     maintainState: true,
                //     maintainAnimation: true,
                //     visible: widget.goal.status == accomplished,
                //     child: Container(),
                //     replacement: buildTrophyImage(),
                //   ),
                //   // replacement: CircularProgressIndicator(),
                //   // replacement: isUploading? CircularProgressIndicator(): Container(),
                // ),
                buildCheckbox(),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              onLongPress: () {
                if (widget?.goal?.by?.userId == authPageCtrl.currentUser.id) {
                  showEditAndDeleteOptions();
                } else {
                  showThisIsntYourGoal(widget.goal.by.userId);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, top: 13),
                    child: buildGoalName(),
                  ),
                  buildCommitmentnAccomplishedMsg(),
                  SizedBox(height: 32)

                  // Expanded(child: buildCommitmentnAccomplishedMsg()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
            child: Container(
                height: isUploadingg ? 50 : null,
                width: isUploadingg ? 50 : null,
                child: isUploadingg ? Spinkit() : buildDisplayName()),

            // buildDisplayName(),

            // buildColor(1),
          ),
        ],
      ),
    );
  }

  Widget buildDisplayName() {
    return Text(widget.goal.by.displayName ?? "No name",
        style: TextStyle(fontSize: 12, color: Colors.grey));
  }

  Widget buildTrophyImage() {
    return Container(
      height: 25,
      width: 25,
      child: Image.network(
          "https://media.istockphoto.com/vectors/trophy-cup-icon-vector-id655254230?k=6&m=655254230&s=612x612&w=0&h=QcI6rQ5486QkPtkkuft9r2T5Fr5V7AiuitMt9S5qbj0="),
    );
  }

  Padding buildCommitmentnAccomplishedMsg() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 0.0),
      child: InkWell(
        onTap: () {
          maxLines = maxLines == 1 ? 100 : 1;
          setState(() {});
        },
        child: (widget?.goal?.commitment == "" ||
                    widget?.goal?.commitment == null) &&
                (widget?.goal?.accomplishedFeeling == "" ||
                    widget?.goal?.accomplishedFeeling == null)
            ? Container(height: 0, color: Colors.red)
            : RichText(
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "",
                  style: TextStyle(color: Colors.grey[700]),
                  children: [
                    TextSpan(
                        text: widget?.goal?.commitment == ""
                            ? ""
                            : widget?.goal?.commitment),
                    TextSpan(
                        text: widget?.goal?.commitment == ""
                            ? ""
                            : " #commitment. "),
                    // TextSpan(text: "\n"),
                    TextSpan(
                        text: widget?.goal?.accomplishedFeeling == ""
                            ? ""
                            : widget?.goal?.accomplishedFeeling),
                    TextSpan(
                        text: widget?.goal?.accomplishedFeeling == ""
                            ? ""
                            : " #accomplishmentFeeling"),
                  ],
                ),
              ),
      ),
    );
  }

  Container buildCheckbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Checkbox(
        checkColor: isUploadingg ? Colors.grey : Colors.greenAccent,
        activeColor: isUploadingg ? Colors.grey : Colors.green,
        // fillColor: ,
        // focusColor: Colors.red,

        value: widget?.goal?.status == accomplished ? true : false,
        // this.valuesecond,
        onChanged: (bool value) async {
          if (createGoalCtrl.isUploading == false) {
            if (widget?.goal?.by?.userId != authPageCtrl?.currentUser?.id) {
              showThisIsntYourGoal(widget?.goal?.by?.userId);
            } else {
              //..
              // widget?.goal?.status = value ? accomplished : committed;
              //..
              updateGoalUi(value);
              //...
              // updateStats(widget?.goal?.status);
              // ...
              print(
                  "goalsAccomplishedTogetherCount: ${displayATCtrl.accountabilityTeam.goalsAccomplishedTogetherCount}");
              print(
                  "goalsCommittedTogetherCount: ${displayATCtrl.accountabilityTeam.goalsCommittedTogetherCount}");
              //...
              // showPostToInspire(value, context, widget.goal);
              //..

              // if (displayATCtrl.selectedUserId == groupProgressId) {
              //   displayATCtrl.calculateGoalsStats(
              //       displayATCtrl
              //           .accountabilityTeam?.goalsCommittedTogetherCount,
              //       displayATCtrl
              //           .accountabilityTeam?.goalsAccomplishedTogetherCount);
              // } else {
              //   displayATCtrl.calculateGoalsStats(
              //       displayATCtrl.selectedUser.goalsCommittedCount,
              //       displayATCtrl.selectedUser?.goalsAccomplishedCount);
              // }

              // displayATCtrl.calculateGoalsStats(
              //     displayATCtrl?.selectedUser?.goalsAccomplishedCount,
              //     displayATCtrl?.selectedUser?.goalsCommittedCount);
              // displayATCtrl.update([displayAT]);

              // setState(() {});
            }
          }
        },
      ),
    );
  }

  Widget buildGoalName() {
    return Text(widget?.goal?.goalName ?? "error while creating the goal",
        style: TextStyle(fontSize: 16));
  }

  Future<void> showEditAndDeleteOptions() {
    return showModalBottomSheet<void>(
      isDismissible:

          //
          // false,
          !createGoalCtrl.isDeleting,
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 80,
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // const Text(
              //   'Edit',
              //   style: TextStyle(color: Colors.black, fontSize: 16),
              // ),
              buildEditOption(),
              Divider(),
              TextButton(
                onPressed: createGoalCtrl.isDeleting == true
                    ? null
                    : () {
                        // Get.back();
                        // if (createGoalCtrl.isDeleting == false)
                        createGoalCtrl.deleteGoalFromGoalsCol(
                            widget.goal.id, widget.goal.status);
                        // displayATCtrl.update([displayAT]);
                      },
                child: Container(
                  width: Get.width,
                  child: GetBuilder<CreateGoalCtrl>(
                      id: "Delete",
                      builder: (_) {
                        return Text(
                          _.isDeleting ? "Deleting... Please wait" : "Delete",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        );
                      }),
                ),
              ),
              // ElevatedButton(
              //   child: const Text('Close BottomSheet'),
              //   onPressed: () => Navigator.pop(context),
              // )
            ],
          ),
        );
      },
    );
  }

//in use
  Future updateStats2(String goalStatus, value) async {
    int count = goalStatus == accomplished ? 1 : -1;
    if (authPageCtrl?.currentUser?.accountabilityTeamId != null) {
      //update team status in db
      var response = await displayATCtrl?.updateStatsForAccountablityTeam({
        "\$inc": {"goalsAccomplishedTogetherCount": count}
      }, displayATCtrl.accountabilityTeam.id, "accountabilityTeams");

      if (response != null) {
        logger.d("team status updated! $response");

        //update team status locally
        displayATCtrl.accountabilityTeam.goalsAccomplishedTogetherCount +=
            count;

        await updateIndividualStats(count);
        showPostToInspire(value, Get.context, widget.goal);
      } else {
        logger.d("error updating team status");
        revertGoalStatus();
        Get.snackbar("Something went wrong.", "check network connection.",
            snackPosition: SnackPosition.BOTTOM);
      }

      displayATCtrl.calculateGoalsStats2();
    } else {
      logger.d("no ac team to update");
    }
  }

  Future revertGoalStatus() async {
    logger.d("revert goal status");
    await createGoalCtrl?.updateGoal({
      "\$set": {
        "status":
            widget?.goal?.status == accomplished ? committed : accomplished,
        "by.displayName": authPageCtrl?.currentUser?.displayName,
      }
    }, "goals", widget?.goal?.id, "${displayATCtrl?.accountabilityTeam?.id}");
    widget?.goal?.status =
        widget?.goal?.status == accomplished ? committed : accomplished;
  }

  Future updateIndividualStats(count) async {
    //update individual status in db
    var response2 = await createGoalCtrl?.updateStatsForATMembers(
        displayATCtrl?.accountabilityTeam?.id, authPageCtrl?.currentUser?.id, {
      "\$inc": {"members.\$[i].goalsAccomplishedCount": count},
    });

    //update individual status locally
    if (response2 != null) {
      logger.d("individual status updated!");

      displayATCtrl.accountabilityTeam.members
          .firstWhere((members) => members.id == authPageCtrl?.currentUser?.id)
          .goalsAccomplishedCount += count;
    } else {
      logger.e("error updating individual status");
    }
    //
  }

//not in use
  Future updateStats(String goalStatus) async {
    if (authPageCtrl?.currentUser?.accountabilityTeamId != null) {
      //update team status in db
      var response = displayATCtrl?.updateStatsForAccountablityTeam({
        "\$inc": {"goalsAccomplishedTogetherCount": 1}
      }, displayATCtrl.accountabilityTeam.id, "accountabilityTeams");
      //
      if (authPageCtrl?.currentUser?.id == widget?.goal?.by?.userId) {
        logger.i("member>>");

        if (response != null) {
          if (goalStatus == accomplished) {
            displayATCtrl.accountabilityTeam.goalsAccomplishedTogetherCount +=
                1;
          }

          // displayATCtrl.selectedUser.goalsAccomplishedCount += 1;
          print(
              "selectedUser: ${displayATCtrl.selectedUser.goalsAccomplishedCount}");

          // print("")

          //update individual status
          var response2 = await createGoalCtrl?.updateStatsForATMembers(
              displayATCtrl?.accountabilityTeam?.id,
              authPageCtrl?.currentUser?.id, {
            "\$inc": {"members.\$[i].goalsAccomplishedCount": 1},
          });

          if (response2 != null) {
            displayATCtrl.accountabilityTeam.members
                .firstWhere(
                    (members) => members.id == authPageCtrl?.currentUser?.id)
                .goalsAccomplishedCount += 1;
          }

          // displayATCtrl.accountabilityTeam.members[5] =1,
        }
      } else if (goalStatus == committed) {
        // displayATCtrl.selectedUser.goalsAccomplishedCount -= 1;

        var response3 = await displayATCtrl?.updateStatsForAccountablityTeam({
          "\$inc": {"goalsAccomplishedTogetherCount": -1}
        }, displayATCtrl.accountabilityTeam.id, "accountabilityTeams");
        if (response3 != null) {
          displayATCtrl.accountabilityTeam.goalsAccomplishedTogetherCount -= 1;
        }

        if (authPageCtrl?.currentUser?.id == widget?.goal?.by?.userId) {
          var response4 = await createGoalCtrl?.updateStatsForATMembers(
              displayATCtrl?.accountabilityTeam?.id,
              authPageCtrl?.currentUser?.id, {
            "\$inc": {"members.\$[i].goalsAccomplishedCount": -1},
          });
          if (response4 != null) {
            displayATCtrl.accountabilityTeam.members
                .firstWhere(
                    (members) => members.id == authPageCtrl?.currentUser?.id)
                .goalsAccomplishedCount -= 1;
          }
        }
      }
      displayATCtrl.calculateGoalsStats2();
    } else {
      print("acteammnulll");
    }
    //...
    // print(goalStatus);
    // print(authPageCtrl?.currentUser?.accountabilityTeamId);
    // print(authPageCtrl?.currentUser?.username);
    // print(widget?.goal?.status);
    //...
  }

  updateGoalUi(value) async {
    isUploadingg = true;
    createGoalCtrl.isUploading = true;
    displayGoalCtrl.update([displayGoalsId]);
    setState(() {});
    bool success = await createGoalCtrl?.updateGoal({
      "\$set": {
        "status": value ? accomplished : committed,
        "by.displayName": authPageCtrl?.currentUser?.displayName,
      }
    }, "goals", widget?.goal?.id, "${displayATCtrl?.accountabilityTeam?.id}");
    if (success) {
      widget.goal.status = value ? accomplished : committed;
      await updateStats2(widget?.goal?.status, value);
      // await createGoalCtrl
      //     ?.modifyAccomplishedGoalsListAndResetAfterStatusUpdate(widget?.goal);
      isUploadingg = false;
      createGoalCtrl.isUploading = false;
      if (mounted) setState(() {});
    } else {
      widget.goal.status = !value ? accomplished : committed;
      isUploadingg = false;
      createGoalCtrl.isUploading = false;
      if (mounted) setState(() {});

      Get.snackbar("Something went wrong. ", "Check network.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // updateGoalUi2() async {
  //   isUploadingg = true;
  //   createGoalCtrl.isUploading = true;
  //   displayGoalCtrl.update([displayGoalsId]);
  //   setState(() {});
  //   bool success = await createGoalCtrl?.updateGoal({
  //     "\$set": {
  //       "status": widget?.goal?.status,
  //       "by.displayName": authPageCtrl?.currentUser?.displayName,
  //     }
  //   }, "goals", widget?.goal?.id, "${displayATCtrl?.accountabilityTeam?.id}");
  //   if (success) {
  //     await updateStats(widget?.goal?.status);
  //     // await createGoalCtrl
  //     //     ?.modifyAccomplishedGoalsListAndResetAfterStatusUpdate(widget?.goal);
  //     isUploadingg = false;
  //     createGoalCtrl.isUploading = false;

  //     setState(() {});
  //   } else {
  //     Get.snackbar("Something went wrong.", "",
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  showThisIsntYourGoal(String username) {
    return showModalBottomSheet<void>(
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: ListTile(
            leading: buildPic(),
            title: buildIsThisYourGoal(),
            subtitle: buildText2(),
          ),
        );
      },
    );
  }

  Padding buildText2() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 4, bottom: 8),
      child: RichText(
        text: TextSpan(
          // text: '\n',
          // style: TextStyle(fontSize: 14, color: Colors.black, ),
          children: <TextSpan>[
            TextSpan(
                text: "Your accountability partner ",
                style: TextStyle(
                  color: Colors.black,
                )),
            TextSpan(
                text: '${widget.goal.by.displayName}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            TextSpan(
              text: " doesn't think so ;)",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildIsThisYourGoal() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 8.0),
      child: Text(
        "Is this your goal?",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Container buildPic() {
    return Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0.0),
          child: Image.network(
              "https://blog.emojipedia.org/content/images/2017/10/colbert-emoji-emojipedia.png"),
        ));
  }

  // Widget buildColor(int index) {
  // //             ),
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: (){
  //         showModalBottomSheet<void>(
  //           context: context,
  //           builder: (BuildContext context) {
  //               return Container(
  //                 height: 80,
  //                 color: Colors.grey[100],
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     buildEdit(),
  //                     Divider(),
  //                     Text("Delete", style: TextStyle(color: Colors.black, fontSize: 16),),
  //                     // ElevatedButton(
  //                     //   child: const Text('Close BottomSheet'),
  //                     //   onPressed: () => Navigator.pop(context),
  //                     // )
  //                   ],
  //                 ),
  //               );
  //           },
  //         );
  //       },
  //                 child: Text("Learn flutter 20 min gfdyfhgjbklsasxcvbjljfds",
  //               )),
  //             ),
  //  ],
  //   );
  // }

  Widget buildEditOption() {
    return TextButton(
        onPressed: () {
          createGoalCtrl?.goal = widget.goal;

          createGoalCtrl.goalNameTeCtrl.text = widget.goal.goalName;
          Get.back();
          showModalBottomSheet<void>(
            // isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CommitYourGoalTf(isEditing: true, goalId: widget?.goal?.id),
                    // IconsRow(),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          width: Get.width,
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ));
  }

  Widget buildColor(int index) {
    return Container(
        height: 16,
        width: 16,
        decoration: myBoxDecoration(),

        //  assignColor(index),
        child: Center(
            child: Text(
          widget?.goal?.by?.displayName?.toString()?.substring(0, 1) ?? "S",
          style: TextStyle(color: Colors.black, fontSize: 10),
        )));
  }

  BoxDecoration assignColor(
    int index,
  ) {
    Color color;
    if (index == 0) {
      color = Colors.red;
    } else if (index == 1) {
      color = Colors.blue;
    } else if (index == 2) {
      color = Colors.yellow;
    } else {
      color = Colors.orange;
    }

    return BoxDecoration(shape: BoxShape.circle, color: color);
  }
}
