import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/goal_model.dart';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'read_more_less_text.dart';

class HurrayMessage extends StatefulWidget {
  GoalModel goal;
  HurrayMessage(this.goal);
  @override
  _HurrayMessageState createState() => _HurrayMessageState();
}

class _HurrayMessageState extends State<HurrayMessage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildHurrayMessage(),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: buildGoalAccomplished(),
      ),
      subtitle:
          widget.goal.status == accomplished ? Container() : buildResachSayss(),
    );
  }

  Widget buildResachSayss() {
    return DemoApp();
    // SingleChildScrollView(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 8.0),
    //         child: ReadMoreText(
    //           "Research says writing a commitment message "
    //           "makes you more determined!",
    //           trimLines: 2,
    //           colorClickableText: Colors.black,
    //           trimMode: TrimMode.Line,
    //           trimCollapsedText: '...Show more',
    //           trimExpandedText: ' show less',
    //         ),

    //     Text(
    //   "Research says writing a commitment message "
    //   "makes you more determined!",
    //   maxLines: 1,
    //   overflow: TextOverflow.ellipsis,
    //   style: TextStyle(color: Colors.black),
    // );

    //     ],
    //   ),
    // );
  }

  Widget buildGoalAccomplished() {
    return widget.goal.status == accomplished
        ? Text(
            "Goal Accomplished!!🔥😎🎉🎊",
            style: TextStyle(fontSize: 16),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("Goal Committed!"),
          );
  }

  Widget buildHurrayMessage() {
    return Container(
      // height: 100,
      // width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(widget.goal.status == accomplished
            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQLFxd2W-qZtQgAxLiwbNbBtYWNnptDog9cVxJk8_4zvVuAgvidnALVDcVn_g6RxnSyZU&usqp=CAU"
            :

            // "https://i.pinimg.com/originals/a3/21/b2/a321b27c0627ee678e558966780a7a20.png"
            "https://i.pinimg.com/236x/7a/21/bd/7a21bd722dc362b6682693817ce3fe26--emoji-people-emoji-faces.jpg"),
      ),
    );
  }
}
