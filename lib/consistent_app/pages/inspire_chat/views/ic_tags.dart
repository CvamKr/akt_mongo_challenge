import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class IcTags extends StatefulWidget {
  bool isChatting;
  IcTags({@required this.isChatting});
  @override
  _IcTagsState createState() => _IcTagsState();
}

class _IcTagsState extends State<IcTags> {
  // var selectedTag = "No Tag";
  final displayInspireChatCtrl = Get.find<DisplayInspireChatCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayInspireChatCtrl>(
        id: displayInspireChatUiId,
        builder: (_) {
          return Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      icTag2("all"),
                      buildVerticalDivider(),
                      icTag2("general"),
                      buildVerticalDivider(),
                      icTag2("introduceYourself"),
                      buildVerticalDivider(),
                      icTag2("myReasons4myGoals"),
                      buildVerticalDivider(),
                      icTag2("commitment"),
                      buildVerticalDivider(),
                      icTag2("pushedMyLimit"),
                      buildVerticalDivider(),
                      icTag2("accomplishmentFeeling"),
                      buildVerticalDivider(),
                      icTag2("selfControl"),
                      buildVerticalDivider(),
                      icTag2("proudAct"),
                      // buildVerticalDivider(),
                      // icTag("proudDecision"),
                      buildVerticalDivider(),
                      icTag2("appFeedback"),
                      buildVerticalDivider(),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 8)
            ],
          );
        });
  }

  VerticalDivider buildVerticalDivider() {
    return VerticalDivider(
      width: 8,
      thickness: 0,
      color: Colors.transparent,
    );
  }

  Widget icTag2(String tag) {
    return InkWell(
      onTap: () {
        setState(() {
          displayInspireChatCtrl.selectedTag = tag;
          print(displayInspireChatCtrl.selectedTag);
          // if (displayInspireChatCtrl.selectedTag == 'all')
          //   displayInspireChatCtrl.getInspireChatFromDB();
          // else
          displayInspireChatCtrl.getICbyTagsFromDB();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: displayInspireChatCtrl?.selectedTag == tag
                ? displayInspireChatCtrl.isGlobal
                    ? Colors.blue
                    : Colors.teal[400]
                : Colors.grey,
          ),
          color: displayInspireChatCtrl?.selectedTag == tag
              ? displayInspireChatCtrl.isGlobal
                  ? Colors.blue
                  : Colors.teal[400]
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Text(tag == 'all' ? 'all' : "#" + tag,
              style: TextStyle(
                color: displayInspireChatCtrl.selectedTag == tag
                    ? Colors.white
                    : Colors.black,
              )),
        ),
      ),
    );
  }

  Container icTag(
    String tag,
  ) {
    return Container(
      height: 20,
      // color: Colors.blue,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: displayInspireChatCtrl?.selectedTag == tag
              ? displayInspireChatCtrl.isGlobal
                  ? Colors.blue
                  : Colors.teal[400]
              : Colors.white,

          //
          //

          primary: displayInspireChatCtrl?.selectedTag == tag
              ? Colors.black
              // ? displayInspireChatCtrl.isGlobal
              //     ? Colors.blue
              //     : Colors.white
              : Colors.black,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                  color: displayInspireChatCtrl?.selectedTag == tag
                      ? displayInspireChatCtrl.isGlobal
                          ? Colors.blue
                          : Colors.teal[400]
                      : Colors.grey)),
          // color: isButtonPressed ? Colors.blue : Colors.white,
        ),
        onPressed: () {
          setState(() {
            displayInspireChatCtrl.selectedTag = tag;
            print(displayInspireChatCtrl.selectedTag);
            // if (displayInspireChatCtrl.selectedTag == 'all')
            //   displayInspireChatCtrl.getInspireChatFromDB();
            // else
            displayInspireChatCtrl.getICbyTagsFromDB();
          });
        },
        child: Text(tag == 'all' ? 'all' : "#" + tag,
            style: TextStyle(
              color: displayInspireChatCtrl.selectedTag == tag
                  ? Colors.white
                  : Colors.black,
            )),
      ),
    );
  }
}

// class IcTag extends StatefulWidget {
//   IcTag({
//     Key key,
//     @required this.tag,
//   }) : super(key: key);

//

//   @override
//   _IcTagState createState() => _IcTagState();
// }

// class _IcTagState extends State<IcTag> {
//
//   @override
//   Widget build(BuildContext context) {
//    // return );
//   }
// }
// //
