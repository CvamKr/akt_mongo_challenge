import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/modifications/goals_committed_text_n_goal_add_Icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsList extends StatelessWidget {
  final displayATCtrl = Get.find<DisplayATCtrl>();

  @override
  Widget build(BuildContext context) {
    return
        //
        // buildWithGetBuilder();
        buildWithoutGetBuilder();
  }

  buildWithoutGetBuilder() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GoalsCommittedTextnGoalAddIcon(),
          ),
        ],
      ),
    );
  }

  GetBuilder<DisplayGoalCtrl> buildWithGetBuilder() {
    return GetBuilder<DisplayGoalCtrl>(
      id: displayGoalsId,
      builder: (_) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GoalsCommittedTextnGoalAddIcon(),
              ),
            ],
          ),
        );
      },
    );
  }

  // buildUi(_) {
  //   return Column(
  //     children: [
  //       _?.goalsList?.length == 0
  //           ? Padding(
  //               padding: const EdgeInsets.all(14.0),
  //               child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: Text("No goals committed")),
  //             )
  //           : Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: buildGoalsLeftAndhideAccomplishedui(_),
  //             ),
  //       goalsList(_)
  //     ],
  //   );
  // }

  // goalsList(DisplayGoalCtrl _) {
  //   return _.isLoading
  //       ? Center(child: CircularProgressIndicator())
  //       : Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             child: Column(
  //               children: [
  //                 ListView.builder(
  //                     physics: NeverScrollableScrollPhysics(),
  //                     scrollDirection: Axis.vertical,
  //                     // physics: NeverScrollableScrollPhysics(),
  //                     padding: EdgeInsets.zero,
  //                     shrinkWrap: true,
  //                     itemCount: _.goalsList?.length,
  //                     itemBuilder: (context, index) {
  //                       return Padding(
  //                           padding: const EdgeInsets.only(bottom: 0.0),
  //                           child:
  //                               // _.isHideAccomplishedClicked
  //                               //     ? _.goalsList[index].status == accomplished
  //                               //         ? Container()
  //                               //         : GoalTemplate(_.goalsList[index])
  //                               //     : _.selectedUserId != groupProgressId
  //                               //         ? _.goalsList[index].by?.userId ==
  //                               //                 _.selectedUserId
  //                               //             ? GoalTemplate(_.goalsList[index])
  //                               //             : Container()
  //                               //         : GoalTemplate(_.goalsList[index])

  //                               _.displayRelevantGoals(_, index, displayATCtrl)
  //                           // ActionTemplate2(_.goalsList[index]),
  //                           );
  //                     }),
  //               ],
  //             ),
  //           ),
  //         );
  // }

  // Widget buildGoalsLeftAndhideAccomplishedui(DisplayGoalCtrl _) {
  //   // var totalGoal = _?.goalsList?.length;
  //   // var accomplishedGoal = _?.accomplishedGoalsList?.length;

  //   return InkWell(
  //     onTap: () {
  //       _?.hideAccomplishedGoals();
  //     },
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         // _.isHideAccomplishedClicked ? Text("show") : Text("hide"),

  //         // Padding(
  //         //   padding: const EdgeInsets.all(8.0),
  //         //   child: Text(
  //         //     "Goals left ${_?.goalsList?.length - _?.accomplishedGoalsList?.length}",
  //         //     style: TextStyle(color: Colors.grey),
  //         //   ),
  //         // ),

  //         // Container(
  //         //   height: 18,
  //         //   width: 18,
  //         //   child: Image.network(
  //         //       "https://static.thenounproject.com/png/2210471-200.png"),
  //         // ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             _.isHideAccomplishedClicked
  //                 ? "show accomplished"
  //                 : "hide accomplished",
  //             style: TextStyle(color: Colors.grey),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
