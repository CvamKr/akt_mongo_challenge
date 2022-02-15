import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/edit_user_name.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/create_ac_team/create_ac_team.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/questions_swiper.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/users_row.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/views/expansion_tile2.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/views/goals_list.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:akt_mongo/modifications/group_goals.dart';
import 'package:akt_mongo/modifications/small_goals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

// class DisplayAT extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return DisplayAccountabilityTeam();
//   }
// }

class DisplayAccountabilityTeam extends StatefulWidget {
  // final scrollController;
  DisplayAccountabilityTeam();
  @override
  _DisplayAccountabilityTeamState createState() =>
      _DisplayAccountabilityTeamState();
}

class _DisplayAccountabilityTeamState extends State<DisplayAccountabilityTeam> {
  // final displayATCtrl = Get.find<DisplayATCtrl>();
  // final addAtCtrl = Get.put<CreateATctrl>(CreateATctrl())
  // final createGoalCtrl = Get.put<CreateGoal>(CreateGoal());
  final user = Get.find<AuthPageCtrl>().currentUser;

  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();

  // final addAtCtrl = Get.put<CreateATctrl>(CreateATctrl());
  // static double calcPercentage(int taskDone, int taskTotal) {
  //   print("${0.1 * (taskDone / taskTotal)}%");
  //   return (0.1 * (taskDone / taskTotal)).toDouble();
  // }

  // static int userTotalTasks = 6;
  // static int userTasksDone = 2;
  // double percentage = calcPercentage(userTasksDone, userTotalTasks);
  // num UserTasksPercentage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userTotalTasks =
    //     displayATCtrl?.accountabilityTeam?.goalsCommittedTogetherCount;
    // userTasksDone =
    //     displayATCtrl?.accountabilityTeam?.goalsAccomplishedTogetherCount;
    // print(userTasksDone);
    // print(userTotalTasks);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayATCtrl>(
        id: displayATId,
        builder: (displayATCtrl) {
          return Container(
            // elevation: 0,
            // color: Colors.white,
            child: ListView(
              // physics: NeverScrollableScrollPhysics(),
              // controller: widget.scrollController,
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Text("hi"),
                UsersRow(),
                // addSizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                        // shape: BoxShape.rectangle
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: !displayATCtrl.isAcTeamFound()
                          ? CreateATdetail()
                          : !displayATCtrl.isShowMeBtnClickedd
                              ? CreateATdetail()
                              : accomplishedStatsAndAllGoalsList(
                                  displayATCtrl)),
                ),
                // displayATCtrl.isShowMeBtnClickedd &&
                //         (displayATCtrl.selectedUserId == groupProgressId ||
                //             displayATCtrl?.selectedUserId == user.id)
                //     ? Column(
                //         children: [
                //           GroupGoals(),
                //           SmallGoals(),
                //         ],
                //       )
                //     : Container(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        });
  }

  Widget accomplishedStatsAndAllGoalsList(DisplayATCtrl _) {
    if (_.percentage < 0.0 || _.percentage > 1.0)
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Some error occured. \nPlease leave this accoutability group and form a new one.\nWe are extremely sorry for the inconvenience :(",
          textAlign: TextAlign.center,
        ),
      ));
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
          child: accomplishedStats(
            _,
          ),
        ),
        // GoalsCommittedTextnGoalAddIcon(),

        GoalsList(),

        // GoalsAccomplishedList(),
        // addGoalBtn(),
        // refreshIcon(),
      ],
    );
  }

  // Container MenuBarList() {
  //   return Container(
  //     height: 100,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 3,
  //       itemBuilder: (context, index) {
  //         return

  //         UsersRow(index, names[index], streaks[index], selectedUserName);
  //       },
  //     ),
  //   );
  // }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0.0,
      ),
      child: Container(
          height: 40,
          width: 40,
          child: Image.asset("assets/images/emoji1.png")),
    );
  }

  Widget accomplishedStats(DisplayATCtrl displayAtCtrl) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.teal[100].withOpacity(.5),
          borderRadius: BorderRadius.circular(5),
        ),
        // height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              // color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // buildDisplayName(),
                  displayAtCtrl?.selectedUserId == groupProgressId
                      ? Padding(
                          padding: const EdgeInsets.only(left: 0, top: 16),
                          child: groupProgressText(Colors.teal),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 16),
                          child: userNamesText(displayAtCtrl, Colors.teal),
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 4),
                    child: buildStats(Colors.teal, displayAtCtrl),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                // color: Colors.purple,
                child: lpi(displayAtCtrl),
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ));
    //                 buildStats(tasksDone, totalIndividualTasks),
    //               ],
    //             ),
    //           ]),
    //     ),
    //     // oldListOfGoals(),
    //   ],
    // );
  }

  buildGroupProgressImage() {
    return Container(
      height: 32,
      width: 32,
      child: Image.network(
          "https://cdn0.iconfinder.com/data/icons/team-work-23/64/6_team_success_group_victory_win_achievement_progress_attainment-512.png"),
    );
  }

  Text groupProgressText(Color color) {
    return Text(
      "Group Progress",
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row userNamesText(DisplayATCtrl _, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // alignment: WrapAlignment.end,
      children: [
        // Text("shivam"),
        _?.selectedUserId == user.id
            ? Flexible(
                child: Container(
                  // color: Colors.grey,
                  child: RichText(
                    text: TextSpan(text: "",
                        // style: TextStyle(
                        //   color: color,
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "${_?.selectedUser?.displayName ?? "No name"}",
                            style: TextStyle(
                              color: color,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' (you)',
                            style: TextStyle(
                              color: color,
                              fontSize: 16,
                            ),
                          )
                        ]),
                  ),
                ),
              )

            // Text("${_?.selectedUser?.email} (you)")
            : Expanded(
                child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${_?.selectedUser?.displayName}",
                  style: TextStyle(
                      fontSize: 18, color: color, fontWeight: FontWeight.bold),
                ),
              )),

        _?.selectedUserId == user.id
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4, right: 8),
                child: InkWell(
                  child: Icon(Icons.edit, size: 14, color: color),
                  onTap: () {
                    _.displayNameCtrl.text = user.displayName;
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[EditDisplayName()],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            : Container()
      ],
    );
  }

  Widget buildTextField() {
    return TextFormField(
      cursorColor: Colors.black,
      // keyboardType: inputType,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Hint here"),
    );
  }

  RichText buildStats(Color color, DisplayATCtrl displayATCtrl) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "${displayATCtrl.totalGoalsAccomplished ?? 0}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: color),
        ),
        TextSpan(
          text: "/",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: color),
        ),
        TextSpan(
          text: "${displayATCtrl.totalGoalsCommitted ?? 0}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: color),
        ),
        TextSpan(
          text: displayATCtrl.selectedUserId == groupProgressId
              ? " Accomplished Together"
              : " Accomplished",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: color),
        )
      ]),
    );
  }

  buildDisplayName(DisplayATCtrl displayATCtrl) {
    return Text(displayATCtrl?.selectedUserId ?? "");
  }

  addGoalBtn() {
    return TextButton(
      child: Text("open add goal page"),
      onPressed: () => Get.to(QuestionsSwiper()),
    );
  }

  // Container MenuBarList() {
  //   return Container(
  //     height: 100,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 3,
  //       itemBuilder: (context, index) {
  //         return MenuBar();
  //       },
  //     ),
  //   );
  // }

  ElevatedButton postGoalToMongoBtnn() {
    return ElevatedButton(
      child: Text(" temp post Goal"),
      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
      onPressed: () {},
      // onPressed: () => createGoalCtrl.postGoalToMongoDb(),
    );
  }

  Column chatTemplate(BuildContext context, name, taskName, String time) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)),
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isProgressingTemplate(name, taskName, time),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  "Feels Awesome! Consistent since 4 days now!",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "$name",
                  style: TextStyle(fontSize: 10),
                ),
                // displayStreak(name, streak),
                Expanded(
                  child: SizedBox(),
                ),
                Text(
                  "2 mins ago",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ]);
  }

  isProgressingTemplate(name, taskName, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      // height: 40,
      //  width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        children: [
          Container(
            width: 20,
            color: Colors.transparent,
            child: Image.asset(
              "assets/images/trophy.png",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "$name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: " is Progressing on ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "$taskName",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: " $time",
                  style: TextStyle(color: Colors.black),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // goalsList() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         // physics: NeverScrollableScrollPhysics(),
  //         padding: EdgeInsets.zero,
  //         shrinkWrap: true,
  //         itemCount: 1,
  //         itemBuilder: (context, index) {
  //           return ActionTemplate2();
  //         }),
  //   );
  // }

  Container displayStreak(name, streak) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Row(children: [
        Text(
          "$streak",
          style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 10,
              fontWeight: FontWeight.w300),
        ),
        Icon(Icons.trending_up_rounded, size: 10, color: Colors.deepOrange
            //  color: Colors.white,
            ),
      ]),
    );
  }

  Widget lpi(DisplayATCtrl _) {
    //  _?.percentage.isNaN
    //     ? Container(child: Text("please leave  the accountability group"))
    //     :
    return Container(
      // color: Colors.red,
      child: LinearPercentIndicator(
        padding: EdgeInsets.zero,
        // padding: EdgeInsets.symmetric(vertical: 12),
        alignment: MainAxisAlignment.center,
        animateFromLastPercent: true,
        width: Get.width - 56,
        lineHeight: 14.0,
        percent: !_?.percentage?.isNaN ? _?.percentage : 0.0,
        backgroundColor: Colors.white,
        // Colors.blueGrey.shade100.withOpacity(0.8),
        progressColor: Colors.green,
      ),
    );
  }

  Container semicircleProgressIndicator(DisplayATCtrl _) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      // margin: EdgeInsets.symmetric(
      //   horizontal: 8,
      // ),
      child: CircularPercentIndicator(
        radius: 50,
        progressColor: Colors.green,
        arcBackgroundColor: Colors.lightBlue.shade100.withOpacity(0.4),
        animateFromLastPercent: true,
        curve: Curves.easeIn,
        arcType: ArcType.HALF,
        lineWidth: 4,
        percent: _?.percentage,
        circularStrokeCap: CircularStrokeCap.round,
      ),
    );
  }

  oldListOfGoals() {
    return GetBuilder<DisplayATCtrl>(
        id: displayATId,
        builder: (displayATCtrl) {
          return displayATCtrl.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ExpansionTile2(index);
                  },
                );
        });
  }

  tempNavToCreateAtBtn() {
    return ElevatedButton(
        child: Text("creat AcTeam Page"),
        onPressed: () {
          Get.to(
            CreateATdetail(),
          );
        });
  }

  // tempRemoveMeFromATBtn() {
  //   return RaisedButton(
  //       child: Text("tempRemoveMeFromAT"),
  //       onPressed: () {
  //         displayATCtrl.removeMemberFromAT(
  //            );
  //       });
  // }

  SizedBox addSizedBox({double height}) {
    return SizedBox(height: height);
  }
}

// void _settingModalBottomSheet(context){
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc){
//           return Padding(
//             padding: MediaQuery.of(context).viewInsets,
//             child: Container(

//               child: new Column(
//               children: <Widget>[
//               EditUserName()
//               ],
//               ),
//             ),
//           );
//       }
//     );
// }
