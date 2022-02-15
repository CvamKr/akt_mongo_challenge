
// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:akt_mongo/consistent_app/constants/string_const.dart';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.username,
      this.displayName,
      this.id,
      this.gender,
      this.age,
      this.joinedOn,
      this.accountabilityTeamId,
      this.email,
      this.photoUrl,
      this.bio,
      this.membersCount,
      this.status});

  String username;
  String displayName;
  String id;
  String gender;
  int age;
  String joinedOn;
  String accountabilityTeamId;
  String email;
  String photoUrl;
  String bio;
  int membersCount;
  String status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"] == null ? "" : json["username"],
        status: json["status"] == null ? "" : json["status"],
        displayName: json["displayName"] == null ? "" : json["displayName"],
        // membersCount: json["membersCount"] ?? 0,
        id: json["id"] ?? "",
        gender: json["gender"] ?? "",
        age: json["age"] ?? 0,
        joinedOn: json["joinedOn"] ?? "",
        accountabilityTeamId: json["accountabilityTeamId"] ?? "",
        // accountabilityTeam: json["accountabilityTeam"] == null
        //     ? null
        //     : List<AccountabilityTeam>.from(
        //         json["accountabilityTeam"].map((x) => AccountabilityTeam.fromJson(x))),
        email: json["email"] ?? "",
        photoUrl: json["photoUrl"] ?? "",
        bio: json["bio"] ?? "",
      );
  // factory User.fromDocument(DocumentSnapshot doc, Map docData) {
  //   return User(
  //     id: docData['id'],
  //     displayName: docData['displayName'],
  //     email: docData['email'],
  //     username: docData['username'],
  //     photoUrl: docData['photoUrl'],
  //     bio: docData['bio'],
  //   );
  // }
  Map<String, dynamic> toJson() => {
        "username": username ?? "",
        "displayName": displayName ?? "",
        "status": status ?? "",
        "membersCount": membersCount ?? 0,
        "id": id ?? "",
        "gender": gender ?? "",
        "age": age ?? 0,
        "joinedOn": DateTime.now().toString(),
        "accountabilityTeamId": accountabilityTeamId ?? dontWant,
        // "accountabilityTeam": accountabilityTeam == null
        //     ? null
        //     : List<dynamic>.from(accountabilityTeam.map((x) => x.toJson())),
        "email": email ?? "",
        "photoUrl": photoUrl ?? "",
        "bio": bio ?? ""
      };
}
