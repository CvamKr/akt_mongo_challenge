

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class GlobalToggleBtn extends StatelessWidget {
  final _ = Get.find<DisplayInspireChatCtrl>();
  final DisplayATCtrl displayATCtrl = Get.find<DisplayATCtrl>();
  @override
  Widget build(BuildContext context) {
    return Container(child: buildAcTeamOrGlobalToggleBtn());
  }

  Widget buildAcTeamOrGlobalToggleBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: _.isGlobal ? Colors.blue : Colors.teal[400],
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
      ),
      onPressed: () {
        _.isGlobal = _.isGlobal == true ? false : true;
        if (_.isGlobal || displayATCtrl.isAcTeamFound()) {
          _.getICbyTagsFromDB();
        }

        _.update([displayInspireChatUiId]);
        _.update(["fab"]);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _.isGlobal ? "Global" : "My Accountability Group",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
        ],
      ),
    );
  }

  Widget buildNames() {
    return Container(
      height: 20,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: displayATCtrl?.accountabilityTeam?.members?.length ?? 3,
        itemBuilder: (context, index) {
          return Text(
            displayATCtrl?.accountabilityTeam?.members[index].displayName +
                    " " ??
                // "No name",
                " you.. ",
            style: TextStyle(color: Colors.grey),
          );
        },
      ),
    );
  }
}
