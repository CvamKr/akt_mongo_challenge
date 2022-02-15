import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../create_at_ctrl.dart';

class CreateATbtn extends StatelessWidget {
  final createATCtrl = Get.find<CreateATctrl>();
  final displayAtCtrl = Get.find<DisplayATCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateATctrl>(
      id: "creatAtBTn",
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createATCtrl.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.blue, width: 2)),
                        primary: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(

                          //   height: 30,

                          //   child: Image.network("https://p.kindpng.com/picc/s/165-1653560_emoji-angel-emoji-cute-funny-halo-emojisticker-angelemo.png")),

                          Text(
                            'Yes, I want my accountability group!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        await createATCtrl.createAccountabilityTeam();
                        displayAtCtrl.showRefreshIconFn();

                        //  updateDoc

                        // createATCtrl.updateUserAccountabilityTeamStatus();
                      },
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "By continuing you agree to respect each other.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
