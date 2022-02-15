import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/inspire_chat_model.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'package:logger/logger.dart';

class AddInspireChatCtrl extends GetxController {
  Dio dio = new Dio();
  Logger logger = Logger();
  InspireChatModel inspireChat = InspireChatModel(tags: []);
  TextEditingController userMessageCtrl = TextEditingController();
  final user = Get.find<AuthPageCtrl>().currentUser;
  final displayInspireChatCtrl = Get.find<DisplayInspireChatCtrl>();
  bool postingToDb = false;

  bool isUploading = false;
  postChatToMongoDb({goalName, goalStatus}) async {
    logger.d("in postChatToMongoDb()");
 
    isUploading = true;
    update([addInspireChatUiId]);
    String apiUrl = "$baseUrl/inspireChat/createInspireChat";
    //...
    print("apiUrl is $apiUrl");
    //...
    collectDataToPostChat(goalName, goalStatus);
    //...
    // print("inspireChat Json : ${inspireChat?.toJson()}");
    //...
    try {
      Response response = await dio.post(apiUrl, data: inspireChat?.toJson());
      // {"a": "b"});
      print('response code : ${response.statusCode}');
      isUploading = false;
      update([addInspireChatUiId]);


      if (response.statusCode == 200 || response.statusCode == 201) {
        //...
        // print("response is 200..Ok : ${response.data.toString()}");
        //...
        logger.d('chat  posted!');
        resetQtInputArea();

        return response;
      }
    } catch (e) {
      logger.e(e);
      isUploading = false;
      update([addInspireChatUiId]);
    }
    // isUploading = false;
    // update([addInspireChatUiId]);
  }

  resetQtInputArea() {
    logger.d('in resetQtInputArea');
    //re initialize the model so that the every fields value becomes empty
    inspireChat = InspireChatModel(tags: []);
    selectedTag = "";
    displayInspireChatCtrl.selectedTag = "all";

    //now reset the textcontrollers.
    userMessageCtrl.text = '';
    print('qt title: ${inspireChat.userMessage}');
    print('input area resetted');
  }

  String selectedTag = "";
  collectDataToPostChat([goalName, goalStatus]) {
    inspireChat?.tags?.clear();
    // selectedTag = selectedTag.substring(1);
    inspireChat?.tags?.add(selectedTag);
    inspireChat.userMessage = userMessageCtrl.text;
    inspireChat.userId = user.id;
    inspireChat?.displayName = user.displayName;
    inspireChat?.postedOn = DateTime.now();

    inspireChat?.accountabilityTeamId = user.accountabilityTeamId;

    inspireChat?.goalName = goalName;
    inspireChat?.goalStatus = goalStatus;

    logger.d("ispireChat to post: ${inspireChat.toJson()}");
  }

  bool validate() {
    logger.d('in validate');
    print("selectedTag: $selectedTag");

    if (userMessageCtrl.text == "" || userMessageCtrl.text.trim().isBlank) {
      Get.snackbar("Please write something.", "",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (selectedTag == "") {
      Get.snackbar("Please select a tag", "",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    return true;
  }

  @override
  void onInit() {
    super.onInit();
    userMessageCtrl.text = "";
  }
}
