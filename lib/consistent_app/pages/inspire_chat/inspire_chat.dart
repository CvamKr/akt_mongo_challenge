

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/views/ic_tags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'views/ic_app_bar.dart';
import 'views/ic_below_appbar_msg.dart';
import 'views/ic_list.dart';

class InspireChat extends StatelessWidget {
  final displayInspireChatCtrl =
      Get.put<DisplayInspireChatCtrl>(DisplayInspireChatCtrl());

  final DisplayATCtrl displayATCtrl = Get.find<DisplayATCtrl>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[100].wi,
      // backgroundColor: Colors.blueGrey[100].withOpacity(.9),
      // appBar: ICAppBar(context),
      body: Container(
        decoration: BoxDecoration(color: Colors.white
            // gradient: LinearGradient(
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            //   colors: [Colors.purple[200], Colors.blue[200]],
            // ),
            ),
        child: GetBuilder<DisplayInspireChatCtrl>(
            id: displayInspireChatUiId,
            builder: (_) {
              return ListView(
                children: [
                  // buildAppBar(context),
                  icAppBar(context),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, top: 0),
                    child: ICBelowAppBarMsg(),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, bottom: 24),
                    child: IcTags(
                      isChatting: false,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                  //   child: ICBelowAppBarMsg(),
                  // ),

                  displayInspireChatCtrl.isGlobal
                      ? ICList()
                      : displayATCtrl.isAcTeamFound()
                          ? ICList()
                          : Container(
                              height: 100,
                              child: Center(child: Text("No posts")))
                  // Flexible(child: ICMessageTemplateList())
                  // ICInputArea(),
                ],
              );
            }),
      ),
    );
  }

  Widget buildAcTeamOrGlobalToggleBtn(DisplayInspireChatCtrl _) {
    return ElevatedButton(
      onPressed: () async {
        _.isGlobal = _.isGlobal == true ? false : true;
        await _.getICbyTagsFromDB();
        _.update([displayInspireChatUiId]);
      },
      child: Text(_.isGlobal ? "Global" : "My Accountability Group"),
    );
  }

  Container buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top * 1.1, left: 12, bottom: 8),
      child: Row(
        children: [
          Text(
            "Inspire Chat",
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
        ],
      ),
    );
  }
}
