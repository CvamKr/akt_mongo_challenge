import 'dart:convert';

InspireChatModel welcomeFromJson(String str) =>
    InspireChatModel.fromJson(json.decode(str));

String welcomeToJson(InspireChatModel data) => json.encode(data.toJson());

class InspireChatModel {
  InspireChatModel(
      {this.userName,
      this.userMessage,
      this.tags,
      this.postedOn,
      this.id,
      this.userId,
      this.displayName,
      this.isTickMark,
      this.accountabilityTeamId,
      this.goalName,
      this.goalStatus});

  String userName;
  String displayName;
  String goalName;
  String goalStatus;
  String userMessage;
  String userId;
  List<dynamic> tags;
  DateTime postedOn;
  String id;
  bool isTickMark;
  String accountabilityTeamId;

  factory InspireChatModel.fromJson(Map<String, dynamic> json) =>
      InspireChatModel(
        userId: json["userId"] == null ? "" : json["userId"],
        displayName: json["displayName"] == null ? "" : json["displayName"],
        accountabilityTeamId: json["accountabilityTeamId"] == null
            ? ""
            : json["accountabilityTeamId"],
        goalName: json["goalName"] == null ? "" : json["goalName"],
        goalStatus: json["goalStatus"] == null ? "" : json["goalStatus"],
        userName: json["userName"] ?? "",
        id: json["_id"] ?? "",
        userMessage: json["userMessage"] ?? "",
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"].map((x) => x)),
        postedOn: DateTime.parse(json["postedOn"]),
        isTickMark: json["isTickMark"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "userName": userName ?? "",
        "displayName": displayName ?? "",
        "accountabilityTeamId": accountabilityTeamId ?? "",
        "goalName": goalName ?? "",
        "goalStatus": goalStatus ?? "",
        "userMessage": userMessage ?? "",
        "userId": userId ?? "",
        "tags": List<dynamic>.from(tags?.map((x) => x)),
        "postedOn": postedOn?.toIso8601String(),
        // "isTickMark": isTickMark ?? "",
      };
}
