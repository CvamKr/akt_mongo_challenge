import 'dart:convert';

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/inspire_chat_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DisplayInspireChatCtrl extends GetxController {
  // final addTaskCtrl = Get.put<AddTaskCtrl>(AddTaskCtrl());
  Dio dio = new Dio();

  TextEditingController displayNameCtrl = TextEditingController();
  // final loginPageCtrl = Get.find<AuthPageCtrl>();

  InspireChatModel inspireChat = InspireChatModel(tags: []);
  TextEditingController titleCtrl = TextEditingController();
  final authPageCtrl = Get.find<AuthPageCtrl>();
  final displayATCtrl = Get.put<DisplayATCtrl>(DisplayATCtrl());

  // List<TextEditingController> checklist =
  //     TextEditingController() as List<TextEditingController>;
  Logger logger = Logger();
  List<InspireChatModel> displayInspireChatList = [];
  bool isGlobal = true;
  bool isLoading = false;
  String appUrl;

  deleteInspireChat(String inspireChatId) async {
    logger.d("in deleteInspireChat()");
    String apiUrl = "$baseUrl/crudOp/deleteDoc/$inspireChatId/inspireChats";
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
        logger.d('inspireChatDeleted');
        displayInspireChatList
            .removeWhere((inspireChat) => inspireChat.id == inspireChatId);
        update(["displayInspireChatUiId"]);
      }
    } catch (e) {
      print(e);
    }
  }

  reportInspireChat(
      String inspireChatId, String inspireChatText, String userId) async {
    logger.d("in reportPost()");
    String apiUrl = "$baseUrl/reportPost/reportPost";
    //...
    // print("apiUrl is :$apiUrl");
    // ...

    var dataJson = {
      "PostId": inspireChatId,
      "PostText": inspireChatText,
      "userId": userId
    };
    try {
      Response response = await dio.post(apiUrl, data: dataJson);
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        //...
        logger.d('inspireChat REported');
        Get.snackbar("Reported", "Thanks for Reporting!",
            snackPosition: SnackPosition.BOTTOM);
        // displayInspireChatList
        //     .removeWhere((inspireChat) => inspireChat.id == inspireChatId);
        update(["displayInspireChatUiId"]);
      }
    } catch (e) {
      print(e);
    }
  }

  getICbyTagsFromDB() {
    logger.d("inside getInspireChatFromDB");
    displayInspireChatList.clear();
    isLoading = true;
    print("isLoading:$isLoading");
    update([displayInspireChatUiId]);
    gettingICbyTagsFromDB().then((value) {
      isLoading = false;
      logger.d("gettingIcTagsFromDb: isLoading:$isLoading");
      update([displayInspireChatUiId]);
    });
  }

  String selectedTag = 'all';
  Future gettingICbyTagsFromDB() async {
    logger.d("inside gettingICbyTagsFromDB");
    print("selectedTag: $selectedTag");
    // selectedTag = selectedTag.substring(1);
    print("selectedTag: $selectedTag");
    print("isGlobal: $isGlobal");

    var url =
        "$baseUrl/inspireChat/getICbyTags/$selectedTag/$isGlobal/${authPageCtrl.currentUser.accountabilityTeamId}";
    //...
    // print(url);
    //...

    try {
      var response = await http.get(Uri.parse(url));
      print('response status : ${response.statusCode}');

      if (response.statusCode == 200) {
        print('response status : 200');
        //...
        // print('response.body: ${response.body}');
        //...

        displayInspireChatList.clear();
        var taskJson = json.decode(response.body);
        for (var json in taskJson) {
          InspireChatModel task = InspireChatModel.fromJson(json);
          displayInspireChatList.add(task);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future gettingAppUrl() async {
    logger.d("inside gettingAppUrl");
    var url = "$baseUrl/appUrl/getAppUrl";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('response status : 200');
        //...
        // print('response.body: ${response.body}');
        //...
        var urlJson = json.decode(response.body);

        appUrl = urlJson["appUrl"];

        // scrollTopTop();
      }
    } catch (e) {
      logger.e(e);
    }
  }

  resetQtInputArea() {
    logger.d('in resetQtInputArea');
    //re initialize the model so that the every fields value becomes empty
    inspireChat = InspireChatModel();

    //now reset the textcontrollers.
    titleCtrl.text = '';
    print('qt title: ${inspireChat.userMessage}');
    print('input area resetted');
  }

  postInspireChatToMongoDb() async {
    logger.d("in postInspireChatToMongoDb()");
    String apiUrl = "$baseUrl/inspireChat/createInspireChat";
    //...
    // print("apiUrl is :$apiUrl");
    //...
    //...
    // print("inspireChat Json : ${inspireChat.toJson()}");
    //...
    try {
      Response response = await dio.post(apiUrl, data: inspireChat?.toJson());
      print('response code : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        //...
        logger.d('quick inspire chat posted!');
        resetQtInputArea();

        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getInspireChatFromDB();

    getICbyTagsFromDB();

    // if (displayATCtrl.isAcTeamFound()) {
    //   await getICbyTagsFromDB();
    // }

    // gettingAppUrl();
    // scrollTopTop();
    // memberNames = "";

    // buildMembersName();
  }

  ScrollController scrollController = ScrollController();
  scrollTopTop() {
    scrollController.animateTo(
      scrollController?.position?.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  // String memberNames = "";
  // buildMembersName() {
  //   if (displayATCtrl.accountabilityTeam.members == null) {
  //     return "abc";
  //   }

  //   for (int i = 0; i < displayATCtrl.accountabilityTeam.members.length; i++) {
  //     memberNames +=
  //         displayATCtrl.accountabilityTeam.members[i].displayName.toString();
  //   }
  //   // return memberNames;
  // }
}
