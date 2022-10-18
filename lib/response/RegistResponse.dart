
class RegistResponse {
  RegistResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });
  late final Data data;
  late final int errorCode;
  late final String errorMsg;

  RegistResponse.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }
}

class Data {
  Data({
    required this.admin,
    required this.chapterTops,
    required this.coinCount,
    required this.collectIds,
    required this.email,
    required this.icon,
    required this.id,
    required this.nickname,
    required this.password,
    required this.publicName,
    required this.token,
    required this.type,
    required this.username,
  });
  late final bool admin;
  late final List<dynamic> chapterTops;
  late final int coinCount;
  late final List<dynamic> collectIds;
  late final String email;
  late final String icon;
  late final int id;
  late final String nickname;
  late final String password;
  late final String publicName;
  late final String token;
  late final int type;
  late final String username;

  Data.fromJson(Map<String, dynamic> json){
    admin = json['admin'];
    chapterTops = List.castFrom<dynamic, dynamic>(json['chapterTops']);
    coinCount = json['coinCount'];
    collectIds = List.castFrom<dynamic, dynamic>(json['collectIds']);
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['admin'] = admin;
    _data['chapterTops'] = chapterTops;
    _data['coinCount'] = coinCount;
    _data['collectIds'] = collectIds;
    _data['email'] = email;
    _data['icon'] = icon;
    _data['id'] = id;
    _data['nickname'] = nickname;
    _data['password'] = password;
    _data['publicName'] = publicName;
    _data['token'] = token;
    _data['type'] = type;
    _data['username'] = username;
    return _data;
  }
}