import 'user_info.dart';
// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.tag,
    this.congratsCount,
    this.congratsByList,
    this.commentsCount,
    this.commentsList,
    this.details,
  });

  String tag;
  int congratsCount;
  List<dynamic> congratsByList;
  int commentsCount;
  List<Detail> commentsList;
  List<Detail> details;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        tag: json["tag"] == null ? null : json["tag"],
        congratsCount:
            json["congratsCount"] == null ? null : json["congratsCount"],
        congratsByList: json["congratsByList"] == null
            ? null
            : List<dynamic>.from(json["congratsByList"].map((x) => x)),
        commentsCount:
            json["commentsCount"] == null ? null : json["commentsCount"],
        commentsList: json["commentsList"] == null
            ? null
            : List<Detail>.from(json["commentsList"].map((x) => Detail.fromJson(x))),
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag == null ? null : tag,
        "congratsCount": congratsCount == null ? null : congratsCount,
        "congratsByList": congratsByList == null
            ? null
            : List<dynamic>.from(congratsByList.map((x) => x)),
        "commentsCount": commentsCount == null ? null : commentsCount,
        "commentsList": commentsList == null
            ? null
            : List<dynamic>.from(commentsList.map((x) => x.toJson())),
        "details": details == null
            ? null
            : List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.postedBy,
    this.description,
    this.postedOn,
    this.pic,
  });

  UserInfo postedBy;
  String description;
  String postedOn;
  String pic;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        postedBy: json["postedBy"] == null
            ? null
            : UserInfo.fromJson(json["postedBy"]),
        description: json["description"] == null ? null : json["description"],
        postedOn: json["postedOn"] == null ? null : json["postedOn"],
        pic: json["pic"] == null ? null : json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "postedBy": postedBy == null ? null : postedBy.toJson(),
        "description": description == null ? null : description,
        "postedOn": postedOn == null ? null : postedOn,
        "pic": pic == null ? null : pic,
      };
}
