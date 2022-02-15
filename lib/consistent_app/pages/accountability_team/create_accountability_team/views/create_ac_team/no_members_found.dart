import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/create_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoMembersFound extends StatefulWidget {
  @override
  _NoMembersFoundState createState() => _NoMembersFoundState();
}

class _NoMembersFoundState extends State<NoMembersFound> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final displayATCtrl = Get.find<DisplayATCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateATctrl>(
        id: createAcTeamId,
        builder: (_) {
          return _.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(00.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(
                                  "Your Accountability Group Status",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            reloadAcGroupStatusIcon(_),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 8),
                          child: Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  // height: 100,
                                  // width: 80,
                                  child: Text(
                                    "😭",
                                    style: TextStyle(fontSize: 45),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  "No members found. Try again after sometime.",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpansionTile(
                          title: Align(
                              alignment: Alignment.topRight,
                              child: awwDontCry()),
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size(328, 31),
                                    textStyle: TextStyle(color: Colors.white),
                                    // padding: const EdgeInsets.all(8.0),
                                    primary: Colors.white,
                                    backgroundColor:
                                        displayATCtrl.showRefreshIcon
                                            ? Colors.blue
                                            : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (displayATCtrl.showRefreshIcon == true) {
                                      _?.createAccountabilityTeam();
                                      displayATCtrl.showRefreshIconFn();
                                    } else {
                                      Get.snackbar("We Heard You!",
                                          "Please try again after 5 seconds",snackPosition: SnackPosition.BOTTOM);
                                    }
                                  },
                                  child: Text(
                                      "Search your accountability group again"),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size(328, 31),
                                    padding: const EdgeInsets.all(8.0),
                                    textStyle: TextStyle(color: Colors.blue),
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    displayATCtrl?.user?.accountabilityTeamId =
                                        dontWant;
                                    displayATCtrl?.updateDontWantInAT();
                                    displayATCtrl?.update([displayATId]);
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) =>
                                    //       _buildPopupDialog(context),
                                    // );
                                  },
                                  child: new Text(
                                      "I don't want an accountability group"),
                                ),
                                // FlatButton(
                                //   height: 31,
                                //   minWidth: 328,
                                //   padding: const EdgeInsets.all(8.0),
                                //   textColor: Colors.blue,
                                //   color: Colors.white,
                                //   onPressed: () {
                                //     displayATCtrl?.user?.accountabilityTeamId =
                                //         dontWant;
                                //     displayATCtrl?.updateDontWantInAT();
                                //     displayATCtrl?.update([displayAT]);
                                //     // showDialog(
                                //     //   context: context,
                                //     //   builder: (BuildContext context) =>
                                //     //       _buildPopupDialog(context),
                                //     // );
                                //   },
                                //   child: new Text(
                                //       "I don't want an accountability group"),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(18.0),
                                //       side: BorderSide(color: Colors.black)),
                                // ),
                                // SizedBox(
                                //   height: 15,
                                // )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        });
  }

  Widget reloadAcGroupStatusIcon(CreateATctrl _) {
    return IconButton(
        icon: Icon(
          Icons.refresh_outlined,
          size: 20,
          color: displayATCtrl.showRefreshIcon ? Colors.blue : Colors.grey,
        ),
        onPressed: () async {
          if (displayATCtrl.showRefreshIcon == true) {
            await _.createAccountabilityTeam();
            displayATCtrl.showRefreshIconFn();
          } else {
            Get.snackbar("We Heard You!", "Please try again after 5 seconds",snackPosition: SnackPosition.BOTTOM);
            // logger.d("reloadGoalsIcon clicked");
          }
        });
  }

  Widget awwDontCry() {
    return Text(
      "Aww.Don't cry.Here,",
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
