import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/add_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class IcTagsForPosting extends StatefulWidget {
  bool isInAddIcPage;
  IcTagsForPosting({@required this.isInAddIcPage});
  @override
  _IcTagsForPostingState createState() => _IcTagsForPostingState();
}

class _IcTagsForPostingState extends State<IcTagsForPosting> {
  final DisplayInspireChatCtrl displayInspireChatCtrl =
      Get.find<DisplayInspireChatCtrl>();

  final AddInspireChatCtrl addInspireChatCtrl = Get.put(AddInspireChatCtrl());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          // spacing: 4,
          children: [
            // SizedBox(
            //   width: 8,
            // ),
            // widget.isInAddIcPage ? IcTag("No Tag") :
            // IcTag("all"),
            // buildVerticalDivider(),
            icTag2("general"),
            buildVerticalDivider(),

            icTag2("introduceYourself"),
            buildVerticalDivider(),
            icTag2("myReasons4myGoals"),
            buildVerticalDivider(),
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
            buildVerticalDivider(),
            // icTag("proudDecision"),
            // buildVerticalDivider(),
          ],
        ),
        SizedBox(height: 16),
        icTag2("appFeedback"),

        // Center(
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //             height: 30,
        //             child: Image.network(
        //                 "https://images.emojiterra.com/google/android-10/512px/1f97a.png")),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  VerticalDivider buildVerticalDivider() {
    return VerticalDivider(
      width: 8,
      thickness: 0,
      color: Colors.transparent,
    );
  }

  Widget icTag2(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            addInspireChatCtrl.selectedTag = tag;
            print(addInspireChatCtrl.selectedTag);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: addInspireChatCtrl?.selectedTag == tag
                  ? Colors.teal[400]
                  : Colors.grey,
            ),
            color: addInspireChatCtrl?.selectedTag == tag
                ?
                     Colors.teal[400]
                : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Text(tag == 'all' ? 'all' : "#" + tag,
                style: TextStyle(
                  color: addInspireChatCtrl.selectedTag == tag
                      ? Colors.white
                      : Colors.black,
                )),
          ),
        ),
      ),
    );
  }

  Container icTag(String tag) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          visualDensity: VisualDensity(
              horizontal: 1 / (VisualDensity.maximumDensity),
              vertical: 1 / (VisualDensity.maximumDensity)),
          backgroundColor: addInspireChatCtrl?.selectedTag == tag
              ? Colors.blue
              : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(
                  color: addInspireChatCtrl.selectedTag == tag
                      ? Colors.blue
                      : Colors.grey)),
        ),
        onPressed: () {
          setState(() {
            addInspireChatCtrl.selectedTag = tag;

            print(addInspireChatCtrl.selectedTag);
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 4,
          ),
          padding: EdgeInsets.all(2),
          child: Text(tag == 'all' ? 'all' : "#" + tag,
              style: TextStyle(
                  color: addInspireChatCtrl.selectedTag == tag
                      ? Colors.white
                      : Colors.black)),
        ),
      ),
    );
  }
}
