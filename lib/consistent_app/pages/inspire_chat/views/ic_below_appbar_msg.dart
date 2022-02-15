import 'package:akt_mongo/consistent_app/pages/accountability_team/display_accountability_team/display_at_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global_toggel_btn.dart';
import 'ic_add.dart';

class ICBelowAppBarMsg extends StatefulWidget {
  @override
  _ICBelowAppBarMsgState createState() => _ICBelowAppBarMsgState();
}

class _ICBelowAppBarMsgState extends State<ICBelowAppBarMsg> {
  final DisplayInspireChatCtrl displayInspireChatCtrl =
      Get.find<DisplayInspireChatCtrl>();

  int maxLines = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0.0,
        right: 0.0,
      ),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlobalToggleBtn(),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Container(
                        child: InkWell(
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                          // iconSize: 24,
                          onTap: () {
                            Get.to(ICAdd());
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 250, 250),
                      borderRadius: BorderRadius.circular(8)),
                  child: buildWhiteTemplate()),
            ],
          ),
        ),
      ),
    );
  }

  Column buildWhiteTemplate() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildShareTheGoodText(),
      ),
      GetBuilder<DisplayATCtrl>(
          id: "membersName",
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: InkWell(
                  onTap: () {
                    maxLines = maxLines == 1 ? 10 : 1;
                    setState(() {});
                  },
                  child: RichText(
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: "",
                        style: TextStyle(color: Colors.grey[700]),
                        children: displayInspireChatCtrl.isGlobal
                            ? buildTextSpan1(_)
                            : buildTextSpan2(_)),
                  )),
            );
          })
    ]);
  }

  buildTextSpan2(DisplayATCtrl _) {
    return <TextSpan>[
      TextSpan(
        text: "Posts of your group members ",
        // style: TextStyle(color: Colors.black),
      ),
      TextSpan(
          text: _?.memberNames == ""
              ? "(No members yet) "
              : "(" + _?.memberNames + " ) ",
          // "(Cvam , a, b) ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      TextSpan(
          text: _?.memberNames == ""
              ? "are filtered out here. Get your accountability group now!"
                  "\n\nNote: whatever you post here is also available in global area."
              : "are filtered out here. Interact with them now!"
                  "\n\nNote: whatever you post here is also available in global area."
          // style: TextStyle(color: Colors.black),
          ),
    ];
  }

  buildTextSpan1(_) {
    return <TextSpan>[
      TextSpan(
          text: "It's a global area where everyone "
              "can upload and see each other's posts.")
    ];
  }

  Widget buildShareTheGoodText() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text("Share the good you do for yourself! ",
                style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
