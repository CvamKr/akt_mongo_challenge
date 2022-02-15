import 'dart:math';

import 'package:akt_mongo/consistent_app/constants/string_const.dart';
import 'package:akt_mongo/consistent_app/model/inspire_chat_model.dart';
import 'package:akt_mongo/consistent_app/pages/inspire_chat/controller/display_inspire_chat_ctrl.dart';
import 'package:akt_mongo/consistent_app/pages/login_page/controller/auth_page_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ICMessageTemplate extends StatefulWidget {
  InspireChatModel inspireChat;
  ICMessageTemplate({this.inspireChat});
  @override
  _ICMessageTemplateState createState() => _ICMessageTemplateState();
}

class _ICMessageTemplateState extends State<ICMessageTemplate> {
  final authPageCtrl = Get.find<AuthPageCtrl>();
  final displayInspireChat = Get.find<DisplayInspireChatCtrl>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          if (widget.inspireChat.userId == authPageCtrl.currentUser.id)
            showEditAndDeleteOptions();
          else
            showReportPost();
        },
        child: buildMsgTemplate2()
        //  buildMsgTemplate(),
        );
  }

  buildMsgTemplate2() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                buildMemberNameInitial(16.0, 12),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: widget.inspireChat.goalStatus == accomplished
                      ? buildTrophyImage()
                      : Container(),
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(flex: 4, child: buildUserName()),
                          buildBlueTick(),
                        ],
                      ),
                    ),
                    // Expanded(child: SizedBox()),
                    widget.inspireChat.goalStatus == accomplished ||
                            widget.inspireChat.goalStatus == committed
                        ? Container(child: buildTimeago(12))
                        : Container(),
                  ],
                ),
                const SizedBox(height: 6),
                Visibility(
                    maintainAnimation: false,
                    maintainSize: false,
                    maintainState: false,
                    visible: widget.inspireChat.goalStatus == accomplished ||
                        widget.inspireChat.goalStatus == committed,
                    replacement: buildTimeago(14),
                    child: buildGoalStatusText()),
                SizedBox(height: 24),
                buildMessage(),
                SizedBox(height: 8),
                buildTag()
              ],
            ),
          )
        ],
      ),
    );
  }

  RichText buildGoalStatusText() {
    return RichText(
      text: TextSpan(
          text: "",
          style: TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: widget.inspireChat.goalStatus + " ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            TextSpan(
                text: widget.inspireChat.goalName,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ]),
    );
  }

  Widget buildTrophyImage() {
    return Container(
      height: 32,
      width: 32,
      child: Image.network(
          "https://media.istockphoto.com/vectors/trophy-cup-icon-vector-id655254230?k=6&m=655254230&s=612x612&w=0&h=QcI6rQ5486QkPtkkuft9r2T5Fr5V7AiuitMt9S5qbj0="),
    );
  }

  Padding buildMsgTemplate() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      // width: double.
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          buildMemberNameInitial(10, 6),
                          SizedBox(width: 10),
                          buildUserName(),
                          SizedBox(width: 8),
                          buildBlueTick(),
                          // SizedBox(width: 8),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: buildTag()))
                        ],
                      ),
                    ),
                  ),
                  // buildTime(),
                  buildTimeago(14),
                ],
              ),
              SizedBox(height: 12),
              buildMessage(),
              // SizedBox(height: 12),
              // buildTag()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showReportPost() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 80,
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  displayInspireChat.reportInspireChat(
                      widget.inspireChat.id,
                      widget.inspireChat.userMessage,
                      widget.inspireChat.userId);
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.flag_sharp, color: Colors.red),
                      ),
                      Text(
                        "Report",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   child: const Text('Close BottomSheet'),
              //   onPressed: () => Navigator.pop(context),
              // )
            ],
          ),
        );
      },
    );
  }

  Future<void> showEditAndDeleteOptions() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 80,
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  displayInspireChat.deleteInspireChat(widget.inspireChat.id);
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              // ElevatedButton(
              //   child: const Text('Close BottomSheet'),
              //   onPressed: () => Navigator.pop(context),
              // )
            ],
          ),
        );
      },
    );
  }

  Widget buildMessage() {
    return Text(
      widget?.inspireChat?.userMessage ?? "no message",
      style: TextStyle(fontSize: 16),
    );
  }

  Widget buildTag() {
    return Text(
      "#" + widget.inspireChat.tags[0] + " ",
      // maxLines: 1,
      overflow: TextOverflow.ellipsis,
      // "#accomplishmentFeeling",
      style: TextStyle(color: Colors.grey, fontSize: 14),
    );
  }

  Widget buildBlueTick() {
    return !widget.inspireChat.isTickMark
        ? SizedBox()
        : Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 25,
              width: 25,
              child: Image.network(
                  "https://www.freeiconspng.com/uploads/check-mark-symbol-1.jpeg"),
            ),
          );
  }

  Widget buildUserName() {
    return Text(
      widget.inspireChat.displayName,
      style: TextStyle(
        color: Colors.black, fontSize: 16,
        //  fontWeight: FontWeight.bold
      ),
    );
  }

  Widget buildTimeago(double fontSize) {
    // var minAgo = DateTime.now()
    //     .subtract(Duration(minutes: widget.inspireChat.postedOn.minute));
    // var timeagoText =
    //     timeago.format(minAgo, locale: 'en_IN');
    // print(timeagoText);
    // return Text(timeagoText);
    return FittedBox(
      child: Text(timeago.format(widget.inspireChat.postedOn),
          style: TextStyle(color: Colors.grey, fontSize: fontSize)),
    );
    // return Text(TimeAgo.timeAgoSinceDate(widget.inspireChat.postedOn.toString()));
  }

  Widget buildTime() {
    return Text(
      // "5 sec ago",
      widget.inspireChat.postedOn.day.toString() +
          "/" +
          widget.inspireChat.postedOn.month.toString() +
          "/" +
          widget.inspireChat.postedOn.month.toString(),
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
  }

  Widget buildMemberNameInitial(double fontSize, double padding) {
    return Container(
      // height: 16,
      // width: 16,
      decoration: BoxDecoration(
          color:

              // Colors.blue,
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          shape: BoxShape.circle),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Text(
            widget?.inspireChat?.displayName?.substring(0, 1),
            // "T",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
