
import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/goals/controller/display_goal_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'goal_template.dart';

class GoalsAccomplishedList extends StatefulWidget {
  @override
  _GoalsAccomplishedListState createState() => _GoalsAccomplishedListState();
}

class _GoalsAccomplishedListState extends State<GoalsAccomplishedList> {
  final displayGoalCtrl = Get.find<DisplayGoalCtrl>();
  final user = Get.find<AuthPageCtrl>().currentUser;
  final displayATCtrl = Get.find<DisplayATCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayGoalCtrl>(
        id: displayGoalsId,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Theme(
               data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Expanded(child: buildTitle()),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              // physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _?.accomplishedGoalsList?.length,
                              itemBuilder: (context, index) {
                                return _?.accomplishedGoalsList[index].by
                                            .userId ==
                                        displayATCtrl?.selectedUserId
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: GoalTemplate(
                                            _?.accomplishedGoalsList[index])
                                        // ActionTemplate2(_.goalsList[index]),
                                        )
                                    : displayATCtrl.selectedUserId ==
                                            groupProgressId
                                        ? GoalTemplate(
                                            _?.accomplishedGoalsList[index])
                                        : Container();
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget buildTitle() {
    return Row(
      children: [
        buildImage(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            displayATCtrl.selectedUserId == groupProgressId
                ? "Goals Accomplished together"
                : "Goals Accomplished",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0.0,
      ),
      child: Container(
          height: 40,
          width: 40,
          child: Image.network(
              "https://static-s.aa-cdn.net/img/gp/20600011252220/mlFtILzIoQqhJdoiRJj47m7eBBW47E0Vc_5siY8cuTyEP2Gz57oqUHCauQk_g3FKv_Pv=s300?v=1")),
    );
  }
}
