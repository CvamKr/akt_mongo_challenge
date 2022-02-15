import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/create_ac_team/create_at_btn.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/create_accountability_team/views/create_ac_team/no_members_found.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/views/how_it_works.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:get/get.dart' hide Response;

import '../../create_at_ctrl.dart';

class CreateATdetail extends StatefulWidget {
  @override
  _CreateATdetailState createState() => _CreateATdetailState();
}

class _CreateATdetailState extends State<CreateATdetail> {
  final createATctrl = Get.put<CreateATctrl>(CreateATctrl());

  String userEmail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userEmail = authCtrl.currentUser.email;
    // authCtrl?.currentUser?.accountabilityTeam = dontWant;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        // decoration: decoration(c1),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // buildReasearchSays(barColor, c2, c3),
            HowItWorks(isExpanded: true),
            AcTeamStatus()
          ],
        ),
      ),
    );
  }
}

class ACTeamFound extends StatelessWidget {
  ACTeamFound({
    Key key,
  }) : super(key: key);
  final displayATCtrl = Get.find<DisplayATCtrl>();
  final createAtCtrl = Get.find<CreateATctrl>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Your Accountability Team Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              reloadAcTeamIcon(displayATCtrl)
            ],
          ),
          Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 80,
                  child: Text(
                    "😍",
                    style: TextStyle(fontSize: 45),
                  )),
              Flexible(
                child: Text(
                  "Found your accountability team!!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
              minimumSize: Size(328, 31),
              textStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
            ),
            onPressed: ()  {
              logger.d("show me btn cliked");
              displayATCtrl.isShowMeBtnClickedd = true;
              displayATCtrl.showMeButtonCtrl.write(displayATCtrl.user.id, true);
              //...
              // logger.d(
              //   "ShowMeButtonClicked()  ${displayATCtrl.showMeButtonCtrl.read(displayATCtrl.user.id)}");
              // ...
              // displayATCtrl.userdata.write("ShowMeButtonClicked", true);
              // logger.d(
              //     "ShowMeButtonClicked()  ${displayATCtrl.userdata.read("ShowMeButtonClicked")}");
              // ...
               displayATCtrl.getATFromDB();
              //...
              // displayATCtrl.update([displayATId]);
            },
            child: new Text("Show me"),
          ),
        ],
      ),
    );
  }

  Widget reloadAcTeamIcon(_) {
    return _.isLoading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: CircularProgressIndicator()),
          )
        : IconButton(
            icon: Icon(
              Icons.refresh_outlined,
              size: 20,
            ),
            onPressed: () async {
              logger.d("reloadGoalsIcon clicked");
              // displayGoalCtrl.goalsList.clear();
              await createAtCtrl.createAccountabilityTeam();
              // displayGoalCtrl.getGoalsOfAcTeamMembers(displayATCtrl.goalIdsForApi);
            });
  }
}

decoration(c1) {
  return BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    color: Colors.grey.shade100,
    boxShadow: [
      // color: Colors.white, //background color of box
      BoxShadow(
        color: Colors.grey[400],
        blurRadius: 20.0, // soften the shadow
        spreadRadius: 5.0, //extend the shadow
        // offset: Offset(
        //   20.0, // Move to right 10  horizontally
        //   20.0, // Move to bottom 10 Vertically

        // ),
      )
    ],
  );
}

buildReasearchSays() {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Image(
              image: AssetImage(
                'assets/images/teamwork.jpg',
              ),
            ),
          ),
          Flexible(
            child: Text(
              'Research says that you are 80% more consistent if you are accountable to someone!',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
        ],
      ),
    ),
  );
}

class AcTeamStatus extends StatelessWidget {
  final authCtrl = Get.find<AuthPageCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateATctrl>(
        id: createAcTeamId,
        builder: (_) {
          return Container(child: buildRelevantUi());
        });
  }

  buildRelevantUi() {
    // authCtrl?.currentUser?.accountabilityTeam = dontWant;
    if (authCtrl?.currentUser?.accountabilityTeamId == dontWant) {
      return CreateATbtn();
    } else if (authCtrl?.currentUser?.accountabilityTeamId == want ||
        authCtrl?.currentUser?.accountabilityTeamId == "forming") {
      return NoMembersFound();
    } else {
      return ACTeamFound();
      // FoundYourAcTeamm();
    }
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: MainAxisAlignment.center,
      animateFromLastPercent: true,
      width: 50.0,
      lineHeight: 14.0,
      percent: 0.5,
      backgroundColor: Colors.blueGrey.shade100.withOpacity(0.8),
      progressColor: Colors.lightBlue,
    );
  }
}
