import 'package:akt_mongo/consistent_app/central_services/widgets/box_decoration.dart';
import 'package:akt_mongo/consistent_app/central_services/widgets/spinkit.dart';
import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/accoutability_team_model.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/views/how_it_works.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/views/leave_at_popup.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/add_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UsersRow extends StatefulWidget {
  // UsersRow() {}

  @override
  _UsersRowState createState() => _UsersRowState();
}

class _UsersRowState extends State<UsersRow> {
  // final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  final loginPageCtrl = Get.find<AuthPageCtrl>();
  final addInspireChatCtrl = Get.find<AddInspireChatCtrl>();
  // final addInspireChatCtrl = Get.put<AddInspireChatCtrl>(AddInspireChatCtrl());

  void handleClick(String value) {
    switch (value) {
      case 'leave accountability group':
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );

        break;
      case 'how it works?':
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: HowItWorks(
              isExpanded: true,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayATCtrl>(
      id: displayATId,
      builder: (_) {
        return Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),

          // decoration(Colors.white),
          child:
              // Container(color: Colors.red, height : 20),
              Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildAcGroupTextAndIcons(_),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    // scrollDirection: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildHomeIconGroupProgress(_),
                      SizedBox(
                        width: 10,
                      ),
                      !_.isShowMeBtnClickedd
                          ? Container()
                          : buildTheMembersIcons(_),
                      // reloadGoalsIcon(_),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(title: LeaveAtPopUp());
  }

  buildAcGroupTextAndIcons(DisplayATCtrl _) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 12.0),
              child: Text(
                "Accountability Group",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 4.0),
              child: Text(
                "${_?.accountabilityTeam?.members?.length ?? 0} members",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        Visibility(
          visible: !_.isAcTeamFound() ? false : true,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: Row(
            children: [
              // reloadGoalsIcon(_),
              // Visibility(
              //   visible: !_.isLoading,
              //   child: buildCpb(),
              //   replacement: buildRefreshIcon(_),
              //   maintainSize: true,
              //   maintainState: true,
              //   maintainAnimation: true,
              // ),
              _.isLoading ? buildCpb() : buildRefreshIcon(_),
              buildPopupMenuIcon(),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuButton<String> buildPopupMenuIcon() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_outlined, color: Colors.black),
      onSelected: (value) {
        handleClick(value);
      },
      itemBuilder: (BuildContext context) {
        return {
          'leave accountability group',
          'how it works?'
          // 'Rate and feedback',
          // 'Check for updates',
        }.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Widget buildTheMembersIcons(_) {
    return Container(
      height: 45,
      // width: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _?.accountabilityTeam?.members?.length ?? 0,
        itemBuilder: (context, index) {
          if (_?.accountabilityTeam?.members == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (index == _?.accountabilityTeam?.members?.length) {
          //   return Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Align(child: Text("3 members")),
          //   );
          // }

          return Row(
            children: [
              buildUserInfo(_, _?.accountabilityTeam?.members[index], index),
            ],
          );
        },
      ),
    );
  }

  Widget buildUserInfo(DisplayATCtrl _, Member currentUser, int index) {
    // Member currentUser;
    // if (index == 0) {
    //   print(index);
    // } else
    //   currentUser = accountabilityTeam?.members[index - 1];
    return InkWell(
      onTap: () {
        // setState(() {
        _.assignSelectedUserId(currentUser);
        // _.calculateGoalsStats(currentUser.goalsCommittedCount,
        //     currentUser.goalsAccomplishedCount);

        _.calculateGoalsStats2();

        // });
        // setState(() {
        //   // if (index == 0) {
        //   //   _?.selectedUserId = 'groupProgressId';

        //   // }
        //   displayAtCtrl?.selectedUserId = currentUser?.id;
        //   // displayGoalCtrl.displayRelevantGoals(
        //   //     displayGoalCtrl, index, displayATCtrl);
        // });
      },
      child: Container(
        decoration: BoxDecoration(
          border: checkForBorder(_, currentUser?.id),
        ),
        height: 80,
        child: buildSingleIcon(currentUser),
      ),
    );
  }

  Widget buildHomeIconGroupProgress(DisplayATCtrl _) {
    return InkWell(
      onTap: () {
        _.assignSelectedUserId(null);
        // _.calculateGoalsStats(_.accountabilityTeam.goalsCommittedTogetherCount,
        //     _.accountabilityTeam.goalsAccomplishedTogetherCount);
        _.calculateGoalsStats2();

        // setState(() {
        //   _?.selectedUserId = groupProgressId;
        // });
      },
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.blue[100],
            border: checkForBorder(_, groupProgressId)),
        child: buildImage(),
      ),
    );
  }

  //  Widget _buildPopupDialog(BuildContext context) {
  //   return new AlertDialog(title: LeaveAtPopUp());
  // }

  Widget buildText() {
    return Text(
      "Group Progress",
      style: TextStyle(fontSize: 16),
    );
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8),
      child: Icon(Icons.home_outlined, size: 28),
    );
  }

  // List<Color> colorsList = [Colors.red, Colors.green, Colors.blue];
  Widget buildSingleIcon(Member currentUser) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 6.0),
      child: Container(
          height: 32,
          width: 32,
          decoration: myBoxDecoration(),

          // assignColor(1),
          child: Center(
              child: Text(
            currentUser?.displayName?.substring(0, 1)?.toUpperCase() ?? "",
            // names[index].toString().substring(0, 1),
            style: TextStyle(color: Colors.black, fontSize: 16),
          ))),
    );
  }

  BoxDecoration assignColor(
    int index,
  ) {
    Color color;
    if (index == 0) {
      color = Colors.red;
    } else if (index == 1) {
      color = Colors.blue;
    } else if (index == 2) {
      color = Colors.yellow;
    } else {
      color = Colors.orange;
    }

    return BoxDecoration(shape: BoxShape.circle, color: color

        // colorsList[Random().nextInt(colorsList.length)],
        );
  }

  // Container MenuBarList() {
  //   return Container(
  //     height: 100,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 3,
  //       itemBuilder: (context, index) {
  //         Member member =
  //         return buildUserInfo(selectedUser)
  //       },
  //     ),
  //   );
  // }
  var logger = Logger();
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   if (displayAtCtrl?.accountabilityTeam?.members != null)
    //     this.selectedUserId = displayAtCtrl?.accountabilityTeam?.members[0].id;
    // });
    // logger.d("UserRow(): selectedUserId: $selectedUserId");
  }

  BoxBorder checkForBorder(_, currentUserId) {
    return _?.selectedUserId == currentUserId
        ? Border(
            bottom: BorderSide(color: Colors.teal, width: 2),
          )
        : Border(
            bottom: BorderSide(color: Colors.transparent),
          );
  }

  Container introTemp(currentUser) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: subIntroTemp(currentUser),
        )
      ],
    ));
  }

  Column subIntroTemp(Member currentUser) {
    return Column(
      children: [
        buildTitle(currentUser),
        // Text(
        //   "${displayAtCtrl.acc.userName}",
        //   style: TextStyle(
        //     fontSize: 20,
        //   ),
        // ),
        Expanded(
          child: Row(
            children: [
              Text(
                "${currentUser?.streak ?? "0"}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Container(
                width: 20,
                child: Image(
                  image: AssetImage("assets/images/vector/Eco_(74).jpg"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTitle(Member member) {
    String email = member == null ? "No Name" : member.email;

    // String memberEmail = displayAtCtrl.accountabilityTeam?.members == null
    //     ? "No email"
    //     : displayAtCtrl.accountabilityTeam?.members[i].email;
    // // String memberEmail = displayAtCtrl?.accountabilityTeam?.members[i]?.email;

    // String streak = displayAtCtrl?.accountabilityTeam?.members == null
    //     ? "No streak"
    //     : displayAtCtrl?.accountabilityTeam?.members[i].streak;
    return Text(
      "${email ?? ""}\n\n",
      // style: GoogleFonts.lato(color: Colors.black, fontSize: 16),
    );
  }

  // ignore: non_constant_identifier_names
  CircleAvatar Avatar() {
    return CircleAvatar(
        backgroundImage: NetworkImage(
            "https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg"),
        radius: 28,
        backgroundColor: Colors.red);
  }

  Widget reloadGoalsIcon(DisplayATCtrl _) {
    return _.isLoading ? buildCpb() : buildRefreshIcon(_);
  }

  Padding buildCpb() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: SizedBox(
          height: 45,
          width: 45,
          child: Spinkit(),
        ),
      ),
    );
  }

  IconButton buildRefreshIcon(DisplayATCtrl _) {
    return IconButton(
        icon: Icon(
          Icons.refresh_outlined,
          size: 20,
        ),
        onPressed: () async {
          logger.d("reloadGoalsIcon clicked");
          // displayGoalCtrl.goalsList.clear();
          if (addInspireChatCtrl.postingToDb) {
            logger.d("returned");
            return;
          }
          await _.getATFromDB();
          Get.snackbar("Reloaded", "", snackPosition: SnackPosition.BOTTOM);
          // _.isLoading = false;
          // _.update([displayATId]);
          // displayGoalCtrl.getGoalsOfAcTeamMembers(displayATCtrl.goalIdsForApi);
        });
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
