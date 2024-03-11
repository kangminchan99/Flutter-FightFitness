// 유저 모델
class UserModel {
  late String loginType;
  late String userUid;
  late String userName;
  late String userDeviceToken;
  late int userAge;

  UserModel.fromJson(Map<String, dynamic> json) {
    loginType = json['loginType'];
    userUid = json['userUid'];
    userName = json['userName'];
    userDeviceToken = json['userDeviceToken'];
    userAge = json['userAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginType'] = loginType;
    data['userUid'] = userUid;
    data['userName'] = userName;
    data['userDeviceToken'] = userDeviceToken;
    data['userAge'] = userAge;

    return data;
  }
}
