// To parse this JSON data, do
//
//     final goalModel = goalModelFromJson(jsonString);

import 'dart:convert';

GoalModel goalModelFromJson(String str) => GoalModel.fromJson(json.decode(str));

String goalModelToJson(GoalModel data) => json.encode(data.toJson());

class GoalModel {
  GoalModel(
      {this.id,
      this.goalName,
      // this.actionPlanList,
      // this.reasons,
      this.by,
      this.createdOn,
      // this.isPrivate,
      this.acTeamId,
      this.status,
      this.commitment = "",
      this.accomplishedFeeling = ""});
  String status;
  String commitment;
  String accomplishedFeeling;
  String id;
  String goalName;
  // List<ActionPlan> actionPlanList = [];
  // List<Reason> reasons;
  By by;
  DateTime createdOn;
  // bool isPrivate;
  String acTeamId;

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        goalName: json["goalName"] == null ? null : json["goalName"],
        commitment: json["commitment"] == null ? "" : json["commitment"],
        accomplishedFeeling: json["accomplishedFeeling"] == null
            ? ""
            : json["accomplishedFeeling"],
        // actionPlanList: json["actionPlan"] == null
        // ? null
        // : List<ActionPlan>.from(
        //     json["actionPlan"].map((x) => ActionPlan.fromJson(x))),

        // reasons: json["reasons"] == null
        //     ? null
        //     : List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),

        by: json["by"] == null ? null : By.fromJson(json["by"]),
        createdOn: DateTime.parse(json["createdOn"]),
        // isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        acTeamId: json["acTeamId"] == null ? null : json["acTeamId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "goalName": goalName == null ? null : goalName,
        "commitment": commitment == null ? "" : commitment,
        "accomplishedFeeling":
            accomplishedFeeling == null ? "" : accomplishedFeeling,
        "acTeamId": acTeamId == null ? null : acTeamId,
        // "actionPlan": actionPlanList == null
        //     ? null
        //     : List<dynamic>.from(actionPlanList.map((x) => x.toJson())),

        // "reasons": reasons == null
        //     ? null
        //     : List<dynamic>.from(reasons.map((x) => x.toJson())),

        "by": by == null ? null : by.toJson(),
        "createdOn": createdOn?.toIso8601String(),
        // "isPrivate": isPrivate == null ? null : isPrivate,
      };
}

class ActionPlan {
  ActionPlan({
    this.action,
    this.isPrivate,
    this.duration,
    this.repeats,
    this.status,
    this.start,
    this.end,
    this.streak,
    this.streakHistory,
  });

  String action;
  bool isPrivate;
  String duration;
  String repeats;
  String status;
  End start;
  End end;
  int streak;
  List<StreakHistory> streakHistory;

  factory ActionPlan.fromJson(Map<String, dynamic> json) => ActionPlan(
        action: json["action"] == null ? null : json["action"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        duration: json["duration"] == null ? null : json["duration"],
        repeats: json["repeats"] == null ? null : json["repeats"],
        status: json["status"] == null ? null : json["status"],
        start: json["start"] == null ? null : End.fromJson(json["start"]),
        end: json["end"] == null ? null : End.fromJson(json["end"]),
        streak: json["streak"] == null ? null : json["streak"],
        streakHistory: json["streakHistory"] == null
            ? null
            : List<StreakHistory>.from(
                json["streakHistory"].map((x) => StreakHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "action": action == null ? null : action,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "duration": duration == null ? null : duration,
        "repeats": repeats == null ? null : repeats,
        "status": status == null ? null : status,
        "start": start == null ? null : start.toJson(),
        "end": end == null ? null : end.toJson(),
        "streak": streak == null ? null : streak,
        "streakHistory": streakHistory == null
            ? null
            : List<dynamic>.from(streakHistory.map((x) => x.toJson())),
      };
}

class End {
  End({
    this.date,
    this.time,
  });

  String date;
  String time;

  factory End.fromJson(Map<String, dynamic> json) => End(
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "time": time == null ? null : time,
      };
}

class StreakHistory {
  StreakHistory({
    this.date,
  });

  bool date;

  factory StreakHistory.fromJson(Map<String, dynamic> json) => StreakHistory(
      // date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
      };
}

// To parse this JSON data, do
//
//     final by = byFromJson(jsonString);

By byFromJson(String str) => By.fromJson(json.decode(str));

String byToJson(By data) => json.encode(data.toJson());

class By {
  By({
    this.userName,
    this.displayName,
    this.email,
    this.userId,
  });

  String userName;
  String displayName;
  String email;
  String userId;

  factory By.fromJson(Map<String, dynamic> json) => By(
        userName: json["userName"] == null ? "" : json["userName"],
        displayName: json["displayName"] == null ? "" : json["displayName"],
        email: json["email"] == null ? "" : json["email"],
        userId: json["userId"] == null ? "" : json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName == null ? "" : userName,
        "displayName": displayName == null ? "" : displayName,
        "email": email == null ? "" : email,
        "userId": userId == null ? "" : userId,
      };
}

class Reason {
  Reason({
    this.text,
    this.isPrivate,
  });

  String text;
  bool isPrivate;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        text: json["text"] == null ? null : json["text"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "isPrivate": isPrivate == null ? null : isPrivate,
      };
}
