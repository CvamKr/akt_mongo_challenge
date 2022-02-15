// To parse this JSON data, do
//
//     final accountabilityTeamModel = accountabilityTeamModelFromJson(jsonString);

import 'dart:convert';

AccountabilityTeamModel accountabilityTeamModelFromJson(String str) =>
    AccountabilityTeamModel.fromJson(json.decode(str));

String accountabilityTeamModelToJson(AccountabilityTeamModel data) =>
    json.encode(data.toJson());

class AccountabilityTeamModel {
  AccountabilityTeamModel({
    this.id,
    this.goalsAccomplishedTogetherCount,
    this.today,
    this.members,
    this.goalsCommittedTogetherCount,
  });

  String id;
  int goalsAccomplishedTogetherCount;
  int goalsCommittedTogetherCount;
  Today today;
  List<Member> members = List.generate(3, (index) => Member());

  factory AccountabilityTeamModel.fromJson(Map<String, dynamic> json) =>
      AccountabilityTeamModel(
        id: json["_id"] == null ? null : json["_id"],
        goalsAccomplishedTogetherCount: json["goalsAccomplishedTogetherCount"] == null
            ? 0
            : json["goalsAccomplishedTogetherCount"],
        goalsCommittedTogetherCount: json["goalsCommittedTogetherCount"] == null
            ? 0
            : json["goalsCommittedTogetherCount"],
        today: json["today"] == null ? null : Today.fromJson(json["today"]),
        members: json["members"] == null
            ?
            //not sure how useful the below code is.
            List<Member>.generate(
                2, (index) => Member(email: "no email is there", streak: 0))
            : List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "goalsAccomplishedTogetherCount": goalsAccomplishedTogetherCount == null
            ? 0
            : goalsAccomplishedTogetherCount,
        "goalsCommittedTogetherCount": goalsCommittedTogetherCount == null
            ? 0
            : goalsCommittedTogetherCount,
        "today": today == null ? null : today.toJson(),
        "members": members == null
            ? null
            : List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  Member(
      {this.displayName,
      this.streak,
      this.id,
      this.goalIds,
      this.email,
      this.goalsAccomplishedCount,
      this.goalsCommittedCount});

  String displayName;
  int streak;
  String id;
  List<String> goalIds;
  String email;
  int goalsAccomplishedCount;
  int goalsCommittedCount;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        displayName: json["displayName"] == null ? null : json["displayName"],
        streak: json["streak"] == null ? null : json["streak"],
        id: json["id"] == null ? null : json["id"],
        goalIds: json["goalIds"] == null
            ? null
            : List<String>.from(json["goalIds"].map((x) => x)),
        email: json["email"] == null ? "no email is there" : json["email"],
        goalsAccomplishedCount: json["goalsAccomplishedCount"] == null
            ? 0
            : json["goalsAccomplishedCount"],
        goalsCommittedCount: json["goalsCommittedCount"] == null
            ? 0
            : json["goalsCommittedCount"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName == null ? null : displayName,
        "streak": streak == null ? null : streak,
        "id": id == null ? null : id,
        "goalIds":
            goalIds == null ? null : List<dynamic>.from(goalIds.map((x) => x)),
        "email": email == null ? null : email,
        "goalsAccomplishedCount":
            goalsAccomplishedCount == null ? 0 : goalsAccomplishedCount,
        "goalsCommittedCount":
            goalsCommittedCount == null ? 0 : goalsCommittedCount,
      };
}

class Today {
  Today({
    this.date,
    this.accomplishedTasks,
    this.totalTasks,
  });

  String date;
  int accomplishedTasks;
  int totalTasks;

  factory Today.fromJson(Map<String, dynamic> json) => Today(
        date: json["date"] == null ? null : json["date"],
        accomplishedTasks: json["accomplishedTasks"] == null
            ? null
            : json["accomplishedTasks"],
        totalTasks: json["totalTasks"] == null ? null : json["totalTasks"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "accomplishedTasks":
            accomplishedTasks == null ? null : accomplishedTasks,
        "totalTasks": totalTasks == null ? null : totalTasks,
      };
}
