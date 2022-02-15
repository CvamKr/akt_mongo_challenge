
import 'package:akt_mongo/consistent_app/central_services/crud_op/crud_op.dart';
import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'package:logger/logger.dart';

class CreateATctrl extends GetxController {
  Logger logger = Logger();
  GoalModel goal = GoalModel();
  Dio dio = new Dio();
  bool isLoading = false;
  CrudOp crudOp = CrudOp();
  final user = Get.find<AuthPageCtrl>().currentUser;
  // final displayAtCtrl = Get.find<DisplayATCtrl>();
  final String tag = "CreateATCtrl";

  createAccountabilityTeam() async {
    logger.d("inside createAccountabilityTeam");
    isLoading = true;
    logger.d("$tag: isLoading:$isLoading");
    update([createAcTeamId]);
    await creatingAccountabilityTeam();
    isLoading = false;
    logger.d("$tag :$isLoading");
    // update([createAcTeamId]);
  }

  Future creatingAccountabilityTeam() async {
    logger.d("inside creatingAccountabilityTeam");
    // var url = "$baseUrl/accountabilityTeam/createAccountabilityTeam";
    var url =
        "$baseUrl/accountabilityTeam/createAccountabilityTeam";
    //...
    // print("url: $url");
    // ...

    Map json = {
      "userSearchingForAcTeam": {
        "displayName": user?.displayName,
        "id": user?.id,
        "email": user?.email
      }
    };
    //...
    // print("user json: $json");
    //...

    try {
      var response = await dio.post(url, data: json);
      print('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // logger.d(
        //     "accountabilityTeamId found: ${response.data["result"]["accountabilityTeamId"]}");
        // ...
        user.accountabilityTeamId =
            response.data["result"]["accountabilityTeamId"];

        // displayAtCtrl.update([displayATId]);

        // updateUserAccountabilityTeamStatus(response.data.acc);

        // var ActeamJson = json.decode(response.body);
        //var at = json.decode(response.body);
        // Get.snackbar("",
        //     "Found your Accountability team!! Click the above blue btn to meet them!!",
        //     snackPosition: SnackPosition.BOTTOM);
      }
      //...
      // update([createAcTeamId]);
      //...

      // if (response.statusCode == 200) {
      //   print('response status : 200');
      //   print('response.body: ${response.body}');

      //   // var taskJson = json.decode(response.body);
      //   // for (var json in taskJson) {
      //   //   QuickTaskModel quickTask = QuickTaskModel.fromJson(json);
      //   //   displayQuickTaskList.add(quickTask);
      //   // }
      // } else
      //   logger.d('something went wrong');
    } catch (e) {
      logger.d('error while creating AT : $e');
      user.accountabilityTeamId = want;
      //...
      // update([createAcTeamId]);
      //...
    } finally {
      update([createAcTeamId]);
      // displayAtCtrl.update([displayATId]);
    }
  }
}
