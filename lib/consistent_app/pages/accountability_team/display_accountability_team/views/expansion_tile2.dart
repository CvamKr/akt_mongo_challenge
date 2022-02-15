import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/goal_template2.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../display_at_ctrl.dart';

class ExpansionTile2 extends StatefulWidget {
  int index;
  ExpansionTile2(this.index);
  @override
  _ExpansionTile2State createState() => _ExpansionTile2State();
}

class _ExpansionTile2State extends State<ExpansionTile2> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final accountabilityTeamCtrl = Get.find<DisplayATCtrl>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(child: buildTitle(widget.index)),
            // buildLine(),
            // buildTitle(1),
            // buildLine(),
            // buildTitle(2)
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GoalTemplate2(),
          )
        ],
      ),
    );
  }

  Widget buildTitle(int i) {
    // String memberEmail =
    //     accountabilityTeamCtrl?.accountabilityTeam?.members == null
    //         ? "No email"
    //         : accountabilityTeamCtrl?.accountabilityTeam?.members[i].emailId;
    String memberEmail =
        accountabilityTeamCtrl?.accountabilityTeam?.members[i]?.email;

    //String streak = accountabilityTeamCtrl?.accountabilityTeam?.members == null
      //  ? "No streak"
      //  : accountabilityTeamCtrl?.accountabilityTeam?.members[i].streak;
    return Text(
      "${memberEmail ?? ""}\n\n",
      style: GoogleFonts.lato(color: Colors.black, fontSize: 16),
    );
  }

  Widget buildLine() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90,
        height: 2,
        color: Colors.grey,
      ),
    );
  }
}
