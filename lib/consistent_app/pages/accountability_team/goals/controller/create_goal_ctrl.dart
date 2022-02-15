
import 'package:akt_mongo/consistent_app/central_services/crud_op/crud_op.dart';
import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:akt_mongo/modifications/bottom_model_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

class CreateGoalCtrl extends GetxController {
  var logger = Logger();
  GoalModel goal = GoalModel();
  By by = By();
  Dio dio = new Dio();
  bool isLoading = false;
  final crudOpCtrl = Get.put<CrudOp>(CrudOp());
  final displayAtCtrl = Get.find<DisplayATCtrl>();
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();

  // final displayAtCtrl = Get.put<DisplayATCtrl>(DisplayATCtrl());
  var goalNameTeCtrl = TextEditingController();

  final authCtrl = Get.find<AuthPageCtrl>();

  var goaltfCtrl = TextEditingController();
  var actionPlantfCtrl = TextEditingController();
  var reasonTfCtrl = TextEditingController();
  var tfController = TextEditingController();
  bool isUploading = false;
  String latestCreatedGoalId;
  // List<TextEditingController> tfControllersList = List<TextEditingController>();

  postGoalToMongoDb() async {
    logger.d("in postGoalToMongoDb()");
    //...
    // print("acTeam id: ${displayAtCtrl.accountabilityTeam?.id}");
    //...
    // print("acTeam id: ${acTeam?.members[0]}");

    String apiUrl =
        "$baseUrl/goal/createGoal/${displayAtCtrl.accountabilityTeam?.id}";
    //...
    // print("apiUrl is :$apiUrl");
    // ...
    prepGoalData();
    //...
    // showPostToInspire(true, Get.context, goal);
    //...
    try {
      Response response = await dio.post(apiUrl, data: goal?.toJson());
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        // ...
        logger.d('goal posted!');
        //...
        // print("last goal created is $latestCreatedGoalId");
        // ...
        // resetQtInputArea();

        // GoalModel goal = GoalModel.fromJson(response.data);
        goal.id = response.data;
        latestCreatedGoalId = goal.id;

        showPostToInspire(true, Get.context, goal);

        addToListAndResetAfterPost();

        // Get.snackbar("Goal committed!", "",
        //     snackPosition: SnackPosition.BOTTOM);

        var response5 = await displayAtCtrl?.updateStatsForAccountablityTeam({
          "\$inc": {"goalsCommittedTogetherCount": 1}
        }, displayAtCtrl.accountabilityTeam.id, "accountabilityTeams");
        if (response5 != null) {
          logger.d("response not null");
          displayAtCtrl.accountabilityTeam.goalsCommittedTogetherCount += 1;
          displayAtCtrl.totalGoalsCommitted += 1;
        } else {
          logger.d("respone is null");
        }

        var response6 = await updateStatsForATMembers(
            displayAtCtrl?.accountabilityTeam?.id, authCtrl?.currentUser?.id, {
          "\$inc": {"members.\$[i].goalsCommittedCount": 1},
        });
        if (response6 != null) {
          logger.d("response not null");

          displayAtCtrl.accountabilityTeam.members
              .firstWhere((members) => members.id == authCtrl?.currentUser?.id)
              .goalsCommittedCount += 1;
        } else {
          logger.d("respone is null");
        }

        displayAtCtrl.calculateGoalsStats2();
      }
    } catch (e) {
      print(e);
      addToListAndResetAfterPost();
    }
  }

  Future<void> showAddOption(String smallGoalName, BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 80,
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                  goalNameTeCtrl?.text = smallGoalName;
                  print(goal?.goalName);
                  postGoalToMongoDb();
                  update([displayATId]);
                },
                child: Container(
                  width: Get.width,
                  child: Text(
                    "Commit this Goal",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
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

  Future postGoalToGoalsCol() async {
    logger.d("in postGoalToGoalsCol()");
    //...
    // print("acTeam id: ${displayAtCtrl.accountabilityTeam?.id}");
    //...
    // print("acTeam id: ${acTeam?.members[0]}");

    String apiUrl =
        "$baseUrl/goal/createGoal/${displayAtCtrl.accountabilityTeam?.id}";

    prepGoalData();
    showPostToInspire(true, Get.context, goal);
    //postGoalInGoalsCol
    try {
      Response response = await dio.post(apiUrl, data: goal?.toJson());
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        // ...
        logger.d('goal posted!');
        //...
        // print("last goal created is $latestCreatedGoalId");
        // ...
        // resetQtInputArea();

        // GoalModel goal = GoalModel.fromJson(response.data);
        goal.id = response.data;

        addToListAndResetAfterPost();

        updateStatsLocallyButTemporarily();

        var response7 = await displayAtCtrl?.updateStatsForAccountablityTeam({
          "\$inc": {"goalsCommittedTogetherCount": 1}
        }, displayAtCtrl.accountabilityTeam.id, "accountabilityTeams");
        if (response7 != null) {
          displayAtCtrl.accountabilityTeam.goalsCommittedTogetherCount += 1;
          displayAtCtrl.totalGoalsCommitted += 1;
        }

        var response8 = await updateStatsForATMembers(
            displayAtCtrl?.accountabilityTeam?.id, authCtrl?.currentUser?.id, {
          "\$inc": {"members.\$[i].goalsCommittedCount": 1},
        });
        if (response8 != null) {
          displayAtCtrl.accountabilityTeam.members
              .firstWhere((members) => members.id == authCtrl?.currentUser?.id)
              .goalsCommittedCount += 1;
        }
        displayAtCtrl.calculateGoalsStats2();
      }
    } catch (e) {
      print(e);
      addToListAndResetAfterPost();
    }
  }

  int tempGoalsCommittedTogetherCount = 0;
  updateStatsLocallyButTemporarily() {
    tempGoalsCommittedTogetherCount =
        displayAtCtrl.accountabilityTeam.goalsCommittedTogetherCount;
    tempGoalsCommittedTogetherCount += 1;

    displayAtCtrl.totalGoalsCommitted += 1;
  }

  updateDisplayNameToMongoD() async {
    logger.d("in updateUSernametomongodb()");
    //...
    // print("acTeam id: ${displayAtCtrl?.accountabilityTeam?.id}");
    // ...
    String apiUrl =
        "$baseUrl/user/updateDisplayNameInAcTeam/${displayAtCtrl?.accountabilityTeam?.id}/${authCtrl?.currentUser?.id}";
    //...
    // print("apiUrl is :$apiUrl");
    // ...

    try {
      Response response = await dio.put(apiUrl,
          data: {"displayName": "${displayAtCtrl?.displayNameCtrl?.text}"});
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        authCtrl?.currentUser?.displayName =
            displayAtCtrl?.displayNameCtrl?.text;
        //...
        // print(authCtrl?.currentUser?.displayName);
        // ...
        displayAtCtrl?.selectedUser?.displayName =
            displayAtCtrl?.displayNameCtrl?.text;

        displayAtCtrl.buildMembersName();

        // crudOpCtrl.updateDoc(json:{
        //   "\$set":
        //   {"displayName": displayNameCtrl.text}
        // }, colName"users", authCtrl.currentUser.id);
        await crudOpCtrl.updateDoc(json: {
          "\$set": {"displayName": "${displayAtCtrl?.displayNameCtrl?.text}"}
        }, colName: "users", docId: authCtrl.currentUser.id);
        print("response is 200..Ok : ${response.data.toString()}");
        logger.d('displayName updated!');
        displayAtCtrl.update([displayATId]);
        Get.snackbar("Name updated!", "", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  bool isDeleting = false;
  deleteGoalFromGoalsCol(String docId, String status) async {
    logger.d("in deleteGoal");
    isDeleting = true;
    update(["Delete"]);
    String apiUrl = "$baseUrl/crudOp/deleteDoc/$docId/goals";
    //...
    // print("apiUrl for deleteGoal is :$apiUrl");
    // ...
    try {
      Response response = await dio.put(apiUrl);
      print('response code for deleteGoal : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        displayGoalCtrl.removeGoalFromList(docId);
        displayAtCtrl.update([displayATId]);
        //...
        // print(
        //     "response is 200..Ok for deleteGoal : ${response.data.toString()}");
        //...

        logger.d('removed Goal');

        // resetQtInputArea();
        if (authCtrl?.currentUser?.accountabilityTeamId ==
            displayAtCtrl?.accountabilityTeam?.id) {
          Map dataForTeam = status == "accomplished"
              ? {
                  "goalsCommittedTogetherCount": -1,
                  "goalsAccomplishedTogetherCount": -1
                }
              : {"goalsCommittedTogetherCount": -1};
          var response9 = await displayAtCtrl?.updateStatsForAccountablityTeam(
              {"\$inc": dataForTeam},
              displayAtCtrl?.accountabilityTeam?.id,
              "accountabilityTeams");
          if (response9 != null) {
            displayAtCtrl?.accountabilityTeam?.goalsCommittedTogetherCount -= 1;
            if (status == "accomplished") {
              displayAtCtrl
                  ?.accountabilityTeam?.goalsAccomplishedTogetherCount -= 1;
            }
          }

          Map dataForIndividual = status == "accomplished"
              ? {
                  "\$inc": {
                    "members.\$[i].goalsAccomplishedCount": -1,
                    "members.\$[i].goalsCommittedCount": -1
                  },
                }
              : {
                  "\$inc": {"members.\$[i].goalsCommittedCount": -1},
                };

          var response10 = await updateStatsForATMembers(
              displayAtCtrl?.accountabilityTeam?.id,
              authCtrl?.currentUser?.id,
              dataForIndividual);

          if (response10 != null) {
            displayAtCtrl?.accountabilityTeam?.members
                ?.firstWhere(
                    (members) => members?.id == authCtrl?.currentUser?.id)
                ?.goalsCommittedCount -= 1;
            if (status == "accomplished") {
              displayAtCtrl?.accountabilityTeam?.members
                  ?.firstWhere(
                      (members) => members?.id == authCtrl?.currentUser?.id)
                  ?.goalsAccomplishedCount -= 1;
            }
          }
        }
        displayAtCtrl?.calculateGoalsStats2();
        // displayAtCtrl?.update([displayAT]);
        isDeleting = false;
        Get.back();

        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  updateStatsForATMembers(String docId, String userId, Map data) async {
    logger.d("in update Stas For AtMEmbers");
    String apiUrl =
        "$baseUrl/accountabilityTeam/updateStatsForIndividuals/$docId/$userId";
    //...
    // print("apiUrl is :$apiUrl");
    //...
    // print(data);
    //...
    try {
      Response response = await dio.put(apiUrl, data: data);
      print('response code for AccountabiltyStats : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print(
        //     "response is 200..Ok for MEMBERAccountabiltyStats : ${response.data.toString()}");
        // ...
        logger.d('accountability team individual member stats updated!');
        // resetQtInputArea();

        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  addToListAndResetAfterPost() {
    logger.d("in addToListAndResetAfterPost");
    // print(goal?.goalName);
    // print(goal?.id);
    goalNameTeCtrl?.text = "";

    displayGoalCtrl?.addPostedGoalToList(goal);

    goal = GoalModel();
    //...
    // logger.d("goal.id after reset: ${goal?.id}");
    // ...
  }

  ActionPlan actionPlan = ActionPlan();
  List<ActionPlan> actionPlanList = List<ActionPlan>();
  prepGoalData() {
    print("in collectData");
    //...
    // print("goal?.goalName: ${goal.goalName}");
    // print("goal?.id: ${goal.id}");
    // ...

    goal?.goalName = goalNameTeCtrl.text?.toString();
    goal.status = committed;

    // actionPlan?.action = actionPlantfCtrl.text?.toString();
    // actionPlanList.add(actionPlan);
    // goal?.actionPlanList = actionPlanList;
    // print('actionPlan: ${actionPlan.action}');
    // goal?.createdOn = DateTime.now().toString();
    goal?.acTeamId = displayAtCtrl?.accountabilityTeam?.id;
    var userId = authCtrl?.currentUser?.id;
    by?.userId = userId;
    by.displayName = authCtrl?.currentUser?.displayName;
    goal?.by = by;
    //...
    // print('by.userId: ${by.userId}');
    // ...
    goal?.by?.userId = userId;
    goal.createdOn = DateTime.now();
    //...
    // print("goal Json : ${goal.toJson()}");
    // ...
  }

  Map collectDataToUpdate() {
    logger.d("in collectDataToUpdate");
    // goal?.goalName = goalNameTeCtrl?.text;
    //...
    // print("goal?.goalName: ${goal?.goalName}");
    // print("goal?.id: ${goal?.id}");
    // ...

    return {
      "\$set": {"goalName": goalNameTeCtrl?.text}
    };
  }

  Future<bool> updateGoal(
      Map map, String colName, String docId, String topicName) async {
    logger.d("inside update goal");
    //...
    // print("docId $docId");
    // //...
    // String topicName = displayAtCtrl?.accountabilityTeam?.id;
    String apiUrl = "$baseUrl/crudOp/updateDoc/$docId/$colName/$topicName";
    //...
    print("api Url is $apiUrl ");
    // print("present data for updating : $map");
    //...
    try {
      Response response = await dio.put(apiUrl, data: map);
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        //...
        logger.d('goal updated!');
        displayAtCtrl.update([displayATId]);
        // resetQtInputArea();

        return true;
      }
      return false;
    } catch (e) {
      logger.e("error while updating: $e");

      return false;
    }
  }

  refreshGoalsListAndResetAfterGoalNameUpdate() {
    goal?.goalName = goalNameTeCtrl.text;
    logger.d("in addToListAndReset");
    displayGoalCtrl?.update([displayGoalsId]);
    goalNameTeCtrl?.text = "";

    goal = new GoalModel();
    // update([displayGoalsId]);
  }

  modifyAccomplishedGoalsListAndResetAfterStatusUpdate(GoalModel updatedGoal) {
    // this.goal?.status = goal.status;
    // this.goal?.goalName = goal.goalName;

    // updatedGoal.status == accomplished
    //     ? displayAtCtrl.totalGoalsAccomplished += 1
    //     : displayAtCtrl.totalGoalsAccomplished -= 1;

    if (!displayGoalCtrl.accomplishedGoalsList.contains(updatedGoal)) {
      displayGoalCtrl?.accomplishedGoalsList?.add(updatedGoal);
    } else {
      displayGoalCtrl?.accomplishedGoalsList?.remove(updatedGoal);
    }

    // updatedGoal.status == accomplished
    //     ? displayGoalCtrl?.accomplishedGoalsList?.add(updatedGoal)
    //     : displayGoalCtrl?.accomplishedGoalsList?.remove(updatedGoal);

    displayGoalCtrl.update([displayGoalsId]);
    this.goal = new GoalModel();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // for (int i = 0; i < 3; i++) {
    //   tfControllersList.add(tfController);
    // }
  }

  Future getLatestCreatedGoalId() async {}
}
