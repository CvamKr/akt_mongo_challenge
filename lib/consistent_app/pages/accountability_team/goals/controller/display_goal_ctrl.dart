

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/add_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:akt_mongo/modifications/goal_template.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

import 'create_goal_ctrl.dart';

class DisplayGoalCtrl extends GetxController {
  var logger = Logger();
  // GoalModel goal = GoalModel();

  By by = By();

  Dio dio = new Dio();
  bool isLoading = false;

  String selectedUserId = groupProgressId;
  // final createGoalCtrl =Get.find<CreateGoalCtrl>();

  // final displayAtCtrl = Get.find<DisplayATCtrl>();
  // final displayAtCtrl = Get.put<DisplayATCtrl>(DisplayATCtrl());

  final authCtrl = Get.find<AuthPageCtrl>();

  getGoalsOfAcTeamMembers(goalIds) {
    logger.d("inside getGoalsOfAcTeamMembers");
    isLoading = true;
    print("isLoading:$isLoading");
    update([displayGoalsId]);
    gettingGoals(goalIds).then((value) {
      isLoading = false;
      logger.d("..isLoading:$isLoading");
      update([displayGoalsId]);
    });
  }

  List<GoalModel> goalsList = <GoalModel>[];
  List<GoalModel> accomplishedGoalsList = List<GoalModel>();
  List smallGoalsList = List();
  List groupGoalsList = List();

  Future gettingGoals(goalIds) async {
    logger.d("inside gettingGoals");
    // final userId = Get.find<AuthPageCtrl>().currentUser.id;
    //...
    // print("userId: $userId");
    //...
    // String userId = currentUser;
    // String goalIds = displayAtCtrl?.goalIdsForApi;

    var url = "$baseUrl/goal/getGoalsOfAcTeamMembers/?$goalIds";
    //...
    // logger.d("goal url: $url");
    // ...

    ///

    try {
      var response = await dio.get(url);
      //...
      // logger.d('above try catch: goal response.body: ${response.data}');
      // ...
      if (response.statusCode == 200) {
        print('response status : 200');
        //...
        // logger.i('goal response.body: ${response.data}');
        // ...
        goalsList.clear();
        // accomplishedGoalsList.clear();
        for (var json in response.data) {
          GoalModel goal = GoalModel.fromJson(json);
          goalsList.add(goal);
        }
        //...
        // logger.i("goalsList length: ${goalsList.length}");
        // ...
      } else {
        print('something went wrong');
      }
    } catch (e) {
      logger.e("error in gettingGoals $e");
    }
  }

  Future gettingSmallGoals() async {
    logger.d("inside gettingSmallGoals");
    var url = "$baseUrl/smallGoal/getSmallGoals";
    //...
    // logger.d("goal url: $url");
    // ...
    try {
      var response = await dio.get(url);
      //...
      // logger.d('above try catch: goal response.body: ${response.data}');
      // ...
      if (response.statusCode == 200) {
        print('response status : 200');
        //...
        // logger.i('goal response.body: ${response.data}');
        // ...
        var smallGoal = response.data["smallGoals"];
        for (var json in smallGoal) {
          smallGoalsList.add(json);
        }

        update([smallGoals]);
      }
    } catch (e) {
      logger.e("error in gettingSmallGoals $e");
    }
  }

  Future gettingGroupGoals() async {
    logger.d("inside gettingGroupGoals");
    var url = "$baseUrl/groupGoal/getGroupGoals";
    //...
    // logger.d("goal url: $url");
    // ...
    try {
      var response = await dio.get(url);
      //...
      // logger.d('above try catch: goal response.body: ${response.data}');
      // ...
      if (response.statusCode == 200) {
        print('response status : 200');
        //...
        // logger.i('goal response.body: ${response.data}');
        // ...
        var groupGoal = response.data["groupGoals"];
        for (var json in groupGoal) {
          groupGoalsList.add(json);
        }

        update([groupGoals]);
      }
    } catch (e) {
      logger.e("error in gettingGroupGoals $e");
    }
  }

  // List<GoalModel> accomplishedGoalsList = [];
  bool isHideAccomplishedClicked = false;
  hideAccomplishedGoals() {
    logger.d("in hideAccomplishedGoals");
    isHideAccomplishedClicked =
        isHideAccomplishedClicked == true ? false : true;

    // goalsList.removeWhere((element) => element.status == accomplished);

    // for (GoalModel goal in goalsList) {
    //   if (goal.status == accomplished) {
    //     goalsList.remove(goal);
    //     print("goal removed");
    //   } else {
    //     print("goal not removed");
    //   }
    // }
    update([displayGoalsId]);
  }

  Widget displayRelevantGoals(
      DisplayGoalCtrl _, int index, DisplayATCtrl displayATCtrl) {
    if (_.selectedUserId == groupProgressId) {
      if (!_.isHideAccomplishedClicked)
        return displayAllGoals(_, index);
      else
        return hideAccomplishedGoalsFromList(_, index);
    } else {
      // ie memeber is selected
      // if (!displayATCtrl.isAcTeamFound()) {
      //   return displayAllGoals(_, index);
      // }

      if (_.goalsList[index].by?.userId == _.selectedUserId) {
        if (!_.isHideAccomplishedClicked)
          return displayAllGoals(_, index);
        else
          return hideAccomplishedGoalsFromList(_, index);
      } else {
        return Container(
          height: 0,
          color: Colors.blue,
        );
      }
    }

    // return Container(
    //   height: 0,
    // );
  }

  Widget displayAllGoals(_, index) {
    return GoalTemplate(_.goalsList[index]);
  }

  Widget hideAccomplishedGoalsFromList(_, index) {
    if (_.goalsList[index].status == accomplished) {
      return Container(height: 0, color: Colors.blue);
    } else {
      return GoalTemplate(_.goalsList[index]);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    gettingSmallGoals();
    gettingGroupGoals();
    // getGoalsOfAcTeamMembers();
  }

  addPostedGoalToList(GoalModel goal) {
    goalsList.insert(0, goal);
    //...
    // logger.d("goal.id added in list : ${goalsList[goalsList.length - 1].id}");
    // ...
    update([displayGoalsId]);
  }

  // final displayInspireChatCtrl = Get.find<DisplayInspireChatCtrl>();
//  final displayATCtrl = Get.find<DisplayATCtrl>();
  Future postt(
      GoalModel goal,
      AddInspireChatCtrl addInspireChatCtrl,
      CreateGoalCtrl createGoalCtrl,
      DisplayInspireChatCtrl displayInspireChatCtrl,
      DisplayATCtrl displayATCtrl) async {
    addInspireChatCtrl?.inspireChat?.tags?.clear();
    addInspireChatCtrl.selectedTag =
        goal.status == accomplished ? "accomplishmentFeeling" : "commitment";

    bool ok = addInspireChatCtrl?.validate();
    if (ok) {
      addInspireChatCtrl.postingToDb = true;
      addInspireChatCtrl.update([inspirePost]);

      if (goal.id == null) {
        //quick fix, need to better it.
        await Future.delayed(Duration(seconds: 2));

        // createGoalCtrl.latestCreatedGoalId;

        // getLatestCreatedGoalId();
      } else {
        createGoalCtrl.latestCreatedGoalId = goal.id;
      }

      await createGoalCtrl.updateGoal(
          addInspireChatCtrl.selectedTag == "commitment"
              ? {
                  "\$set": {
                    "commitment": addInspireChatCtrl.userMessageCtrl.text
                  }
                }
              : {
                  "\$set": {
                    "accomplishedFeeling":
                        addInspireChatCtrl.userMessageCtrl.text
                  }
                },
          "goals",
          createGoalCtrl.latestCreatedGoalId,
          "abc");
      // addInspireChatCtrl.selectedTag == "commitment"
      //     ? widget.goal.commitment =
      //         addInspireChatCtrl.userMessageCtrl.text ?? ""
      //     : widget.goal.accomplishedFeeling =
      //         addInspireChatCtrl.userMessageCtrl.text ?? "";
      //
      if (addInspireChatCtrl.selectedTag == "commitment") {
        goal.commitment = addInspireChatCtrl.userMessageCtrl.text ?? "";
      } else if (addInspireChatCtrl.selectedTag == "accomplishmentFeeling") {
        goal.accomplishedFeeling =
            addInspireChatCtrl.userMessageCtrl.text ?? "";
      } else {
        goal.commitment = "";
        goal.accomplishedFeeling = "";
      }

      // GoalModel goalInList = displayGoalCtrl.goalsList
      //     .firstWhere((goal) => goal.id == widget.goal.id);
      // if (goalInList == null) goalInList = widget.goal;
      // displayGoalCtrl.update();\
      int index =
          goalsList.indexWhere((requiredGoal) => requiredGoal?.id == goal?.id);
      print(index);
      goalsList[index] = goal;

      update([displayGoalsId]);

      addInspireChatCtrl.postingToDb = true;
      addInspireChatCtrl.update([inspirePost]);

      await addInspireChatCtrl?.postChatToMongoDb(
          goalName: goal?.goalName, goalStatus: goal?.status);

      addInspireChatCtrl.postingToDb = false;
      addInspireChatCtrl.update([inspirePost]);
      Get.back();

      displayInspireChatCtrl?.selectedTag = "all";
      // displayInspireChatCtrl?.getInspireChatFromDB();
      displayInspireChatCtrl?.getICbyTagsFromDB();

      // displayATCtrl.calculateGoalsStats2();
    }
  }

  removeGoalFromList(goalId) {
    goalsList.removeWhere((goal) => goal.id == goalId);
    //...
    // print(goalId);
    //...
  }

  assignSelectedUserId(id) {
    this.selectedUserId = id;
    update([displayGoalsId]);
  }

  updateUi() {
    update([displayGoalsId]);
  }

  updateDisplayAt(DisplayATCtrl displayATCtrl) {
    displayATCtrl.update([displayATId]);
    displayATCtrl.calculateGoalsStats2();
  }
}
