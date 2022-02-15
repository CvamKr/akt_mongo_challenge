class UserInfo {
  UserInfo({
    this.userId,
    this.displayName,
    this.displayPic,
    this.userName,
  });

  String userId;
  String displayName;
  String displayPic;
  String userName;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["userId"] == null ? null : json["userId"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        displayPic: json["displayPic"] == null ? null : json["displayPic"],
        userName: json["userName"] == null ? null : json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "displayName": displayName == null ? null : displayName,
        "displayPic": displayPic == null ? null : displayPic,
        "userName": userName == null ? null : userName,
      };
}
