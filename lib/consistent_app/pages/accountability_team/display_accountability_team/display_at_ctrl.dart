import 'dart:convert';

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/accoutability_team_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DisplayATCtrl extends GetxController {
  // AccountabilityTeamModel accountabilityTeamModel = AccountabilityTeamModel();
  AccountabilityTeamModel accountabilityTeam =
      // AccountabilityTeamModel(members:[Mem]);
      AccountabilityTeamModel();
  // AccountabilityTeamModel();
  // final firebaseMessagingCtrl = Get.find<FirebaseMessagingCtrl>();
  final displayGoalCtrl = Get.put<DisplayGoalCtrl>(DisplayGoalCtrl());
  TextEditingController displayNameCtrl = TextEditingController();
  final user = Get.find<AuthPageCtrl>().currentUser;
  // final userdata = GetStorage();
  final showMeButtonCtrl = GetStorage();
  bool isYesClicked = false;
  bool showRefreshIcon = false;

  Logger logger = Logger();
  Dio dio = new Dio();

  bool isLoading = false;
  String selectedUserId = groupProgressId;

  @override
  void onInit() async {
    showRefreshIconFn();
    isShowMeBtnClicked();
    // TODO: implement onInit
    super.onInit();
    if (isAcTeamFound()) {
      logger.d('acTeam found!');
      await getATFromDB();
    } else {
      logger.d("acTeam not found");
      // getUserGoals();
    }
    // showRefreshIcon = false;
    // update([displayAT]);
    // showRefreshIconFn();

    // userdata.write("ShowMeButtonClicked", true);
    // logger.d("ShowMeButtonClicked()  ${userdata.read("ShowMeButtonClicked")}");
    // ...
    // logger.d("ShowMeButtonClicked()  ${showMeButtonCtrl.read(user.id)}");
    // logger.d("selectedUserId: $selectedUserId");
    // ...

    // calculateGoalsStats(selectedUser?.goalsCommittedCount,
    //     selectedUser?.goalsAccomplishedCount);
    // print(percentage);
  }

  showRefreshIconFn() {
    showRefreshIcon = false;
    update([displayATId]);
    Future.delayed(Duration(seconds: 5)).then((_) => {
          showRefreshIcon = true,
          update([displayATId])
        });
    return showRefreshIcon;
  }

  Future<Response> updateStatsForAccountablityTeam(
      Map data, String docId, String colName) async {
    logger.d("in update stats for accountability team");
    // String topicName = displayAtCtrl?.accountabilityTeam?.id;
    String apiUrl = "$baseUrl/crudOp/updateDoc/$docId/$colName/abc";
    //...
    // print("apiUrl is :$apiUrl");
    // ...
    // Map data = {
    //   "\$inc": {field: operator},
    // };
    // ...
    // print("accountabiltyTeam Stats Json : $data");
    // ...
    try {
      Response response = await dio.put(apiUrl, data: data);
      print('response code for AccountabiltyStats : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print(
        //     "response is 200..Ok for AccountabiltyStats : ${response.data.toString()}");
        // ...
        logger.d('accountability stats updated!');
        // resetQtInputArea();

      }
      logger.d("response: $response");
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  leaveAt() async {
    isYesClicked = true;
    update(["leaveAtPopup"]);
    await afterLeavingATStats();
    totalGoalsAccomplished = 0;
    totalGoalsCommitted = 0;
    await removeMemberFromAT();
    accountabilityTeam = AccountabilityTeamModel();
    selectedUser = Member();
    selectedUserId = groupProgressId;
    memberNames = "";
    // await userdata?.write("ShowMeButtonClicked", false);
    await showMeButtonCtrl?.write(user.id, false);
    isShowMeBtnClickedd = false;
    user?.accountabilityTeamId = dontWant;
    //...
    // logger.d(user?.accountabilityTeamId);
    // ...
    await updateDontWantInAT();
    displayGoalCtrl?.goalsList?.clear();
    displayGoalCtrl?.accomplishedGoalsList?.clear();
    isYesClicked = false;
    Get.back();
    update([displayATId]);
  }

  afterLeavingATStats() async {
    int indexForStatsRemoval =
        accountabilityTeam.members.indexWhere((member) => member.id == user.id);
    int accomplishedStats =
        accountabilityTeam.members[indexForStatsRemoval].goalsAccomplishedCount;
    int committedStats =
        accountabilityTeam.members[indexForStatsRemoval].goalsCommittedCount;
    // accountabilityTeam.goalsAccomplishedTogetherCount -= accomplishedStats;
    // accountabilityTeam.goalsCommittedTogetherCount -= committedStats;
    logger.d(indexForStatsRemoval);
    logger.d(accomplishedStats);
    logger.d(committedStats);

    await updateStatsForAccountablityTeam({
      "\$inc": {
        "goalsCommittedTogetherCount": -committedStats,
        "goalsAccomplishedTogetherCount": -accomplishedStats
      }
    }, accountabilityTeam?.id, "accountabilityTeams");
  }

  Future getATFromDB() async {
    logger.d("inside getATFromDB");
    isLoading = true;
    print("isLoading:$isLoading");
    update([displayATId]);
    // gettingATFromDB().then((value) {
    //   isLoading = false;
    //   logger.d("--isLoading: $isLoading");
    //   update([displayATId]);
    // });
    //
    await gettingATFromDB();
    // isLoading = false;
    // logger.d("--isLoading: $isLoading");
    // update([displayATId]);
  }

  Future gettingATFromDB() async {
    logger.d("inside gettingATFromDB");
    //...
    // print("userId: ${user.id}");
    // ...
    // var url =
    //     "$baseUrl/accountabilityTeam/getAccountabilityTeamByUserId/${user.id}";

    var url =
        "$baseUrl/accountabilityTeam/getAccountabilityTeamByAcTeamId/${user?.accountabilityTeamId}";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('response status : 200');
        //...
        // logger.d('response.body AcTeam: ${response.body}');
        //...

        var at = json.decode(response.body);

        accountabilityTeam = AccountabilityTeamModel.fromJson(at);
        var accountabilityTeamId = accountabilityTeam?.id;
        buildMembersName();

        //...
        // logger.d('get At : acTeam id: $accountabilityTeamId');
        // logger.d(
        //     "goals accomplished together ${accountabilityTeam?.goalsAccomplishedTogetherCount}");
        // ...
        // firebaseMessagingCtrl.subscribeToTopic(accountabilityTeamId);
        print("in display at ctrl try");
        // firebaseMessagingCtrl.configureCallbacks();
        createGoalIdsList();
        if (goalIdsList.length == 0) {
          logger.d("no goals to fetch");
          // calculateGoalsStats2();
        } else {
          logger.d(
              "goalIdsList.length ${goalIdsList.length} ie not 0 => some goals to fetch");
          createGoalStringForApi();
          await displayGoalCtrl.getGoalsOfAcTeamMembers(goalIdsForApi);
          this.goalIdsList.clear();
          this.goalIdsForApi = "";
          print("goalIdsList.length: ${goalIdsList.length}");
        }

        //...
        // logger.d("goalIds after fetching done: $goalIdsForApi");
        // ...

        // clearStats();

        // if (selectedUserId == groupProgressId) {
        //   calculateGoalsStats(accountabilityTeam?.goalsCommittedTogetherCount,
        //       accountabilityTeam?.goalsAccomplishedTogetherCount);
        // } else {
        //   calculateGoalsStats(selectedUser.goalsCommittedCount,
        //       selectedUser?.goalsAccomplishedCount);
        // }
        // ...
        calculateGoalsStats2();
        // ...
        // update([displayATId]);

        // update([displayAT]);

        // this.selectedUserId = accountabilityTeam?.members[0].id;
      }
    } catch (e) {
      logger.e("error in gettingAtFromDb: $e");
    }
  }

  updateDontWantInAT() async {
    logger.d("in updateDontWantInAT");
    String apiUrl = "$baseUrl/crudOp/updateDoc/${user.id}/users/abc";
    //...
    // print("apiUrl for updateDontWantInAT is :$apiUrl");
    // ...
    Map data = {
      "\$set": {"accountabilityTeamId": user.accountabilityTeamId}
    };
    try {
      Response response = await dio.put(apiUrl, data: data);
      print('response code for updateDontWantInAT : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print(
        //     "response is 200..Ok for updateDontWantInAT : ${response.data.toString()}");
        // ...
        logger.d('update dont want in at ');
        accountabilityTeam = null;
        update(["displayAT"]);
        // resetQtInputArea();

        return response;
      }
    } catch (e) {
      logger.e(e);
    }
  }

  removeMemberFromAT() async {
    logger.d("in removeMemberFromAT");
    String apiUrl =
        "$baseUrl/accountabilityTeam/removeMemberFromAcTeam/${accountabilityTeam.id}/${user.id}";
    //...
    // print("apiUrl for removeMemberFromAT is :$apiUrl");
    // ...
    // Map data = {
    //   "\$pull": {
    //     "members": {"id": user.id}
    //   }
    // };
    try {
      Response response = await dio.put(apiUrl);
      print('response code for removeMemberFromAT : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print(
        //     "response is 200..Ok for removeMemberFromAT : ${response.data.toString()}");
        // ...
        logger.d('removed MemberFromAT ');
        // resetQtInputArea();
        var accountabilityTeamId = accountabilityTeam?.id;
        // firebaseMessagingCtrl.unsubscribeFromTopic(accountabilityTeamId);
        if (accountabilityTeam.members.length == 0) {
          deleteAccountabliltyTeamDoc(accountabilityTeamId);
        }

        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  deleteAccountabliltyTeamDoc(String acTeamId) async {
    logger.d("in deleteAccountabliltyTeamDoc()");
    String apiUrl = "$baseUrl/crudOp/deleteDoc/$acTeamId/accountabilityTeams";
    //...
    // print("apiUrl is :$apiUrl");
    //...

    try {
      Response response = await dio.put(apiUrl);
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        //...
        logger.d('deleteAccountabliltyTeamDoc');
      }
    } catch (e) {
      print(e);
    }
  }

  List goalIdsList = [];
  createGoalIdsList() {
    logger.d("in createGoalIdsList");
//in flutter
    // if (goalIdsArray == null) return;
    accountabilityTeam.members.forEach((member) {
      if (member?.goalIds == null || member?.goalIds?.length == 0) {
        print("memeber.goalIds: ${member.goalIds}");
      } else {
        print("adding goals");
        for (var goalId in member.goalIds) goalIdsList?.add(goalId);
      }
    });
    print("goalIdsList.length: ${goalIdsList.length}");

    //...
    // logger.d("goalIdsList: $goalIdsList");
    //...
  }

  String goalIdsForApi;
  createGoalStringForApi() {
    logger.d("in createGoalStringForApi");
    goalIdsForApi = "goalIdsList=" + goalIdsList[0];

    for (int i = 1; i < goalIdsList.length; i++) {
      goalIdsForApi += "&" + "goalIdsList=" + goalIdsList[i];
    }
    //...
    // logger.d("goalIds for api: $goalIdsForApi");
    //...
  }

  Widget displayPage = Scaffold(
      body: Center(
    child: CircularProgressIndicator(),
  ));

  bool isAcTeamFound() {
    if (user?.accountabilityTeamId == dontWant
        // "trye"
        ||
        user?.accountabilityTeamId == want ||
        user?.accountabilityTeamId == 'forming') {
      //...
      // logger.d("acTeam not found: ${user?.accountabilityTeamId}");
      // ...
      return false;
    }
    //...
    // logger.d("acTeam  found: ${user?.accountabilityTeamId}");
    //...

    return true;
  }

  bool isShowMeBtnClickedd = false;

  bool isShowMeBtnClicked() {
    logger.d("in isShowMeBtnClicked()");
    // showMeButtonCtrl.write(user.id, false);
    // clickStatus = clickStatus == true ? false : true;
    if (showMeButtonCtrl.read(user.id) == true) {
      logger.d("in isShowMeBtnClicked() == true");

      isShowMeBtnClickedd = true;
    } else {
      logger.d("isShowMeBtnCLicked = false");
    }

    return isShowMeBtnClickedd;
  }

  // getDataFromDb() async {
  //   await getATFromDB();
  //   await displayGoalCtrl.getGoalsOfAcTeamMembers(goalIdsForApi);
  //   this.selectedUserId = accountabilityTeam?.members[0].id;
  // }

  Member selectedUser = Member();
  assignSelectedUserId(Member currentMember) {
    if (currentMember == null) {
      this.selectedUserId = groupProgressId;
    } else {
      this.selectedUserId = currentMember.id;
      this.selectedUser = currentMember;
    }

    // displayGoalCtrl.updateUi();
    displayGoalCtrl.assignSelectedUserId(selectedUserId);
    update([displayATId]);
    // update([displayGoals]);
  }

  double percentage = 0;
  int totalGoalsCommitted = 0;
  int totalGoalsAccomplished = 0;
  // calculateGoalsStats(total, accomplished) {
  //   totalGoalsCommitted = total;
  //   totalGoalsAccomplished = accomplished;
  //   percentage = accomplished.toDouble() / total.toDouble();
  //   update([displayAT]);
  //   return percentage;
  // }

  calculateGoalsStats2() {
    logger.d("in calculateGoalsStats2");
    if (selectedUserId == groupProgressId) {
      totalGoalsCommitted = accountabilityTeam.goalsCommittedTogetherCount;
      totalGoalsAccomplished =
          accountabilityTeam.goalsAccomplishedTogetherCount;
      print("groupProgressId");
    } else {
      totalGoalsCommitted = selectedUser?.goalsCommittedCount;
      totalGoalsAccomplished = selectedUser?.goalsAccomplishedCount;
      print("memberId");
    }
    print("totalGoalsCommitted $totalGoalsCommitted");
    print("totalGoalsAccomplished $totalGoalsAccomplished");

    percentage =
        totalGoalsAccomplished.toDouble() / totalGoalsCommitted.toDouble();
    print("percentage: $percentage");

    isLoading = false;
    logger.d("isLoading: $isLoading");
    update([displayATId]);
    // update();
    // update();

    // ...
    return percentage;
  }

  String memberNames = "";
  buildMembersName() {
    logger.d("in buildMembersName");
    memberNames = "";
    // if (accountabilityTeam.members == null) {
    //   return ;
    // }
    // if (memberNames == "") {
    for (int i = 0; i < accountabilityTeam?.members?.length; i++) {
      memberNames += accountabilityTeam.members[i].displayName.toString();

      // ignore: null_aware_before_operator
      memberNames += i == accountabilityTeam?.members?.length - 1 ? "" : ", ";
    }
    // }

    // return memberNames;
    update(["membersName"]);
  }
}
