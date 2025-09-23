class UserModel {
  int? userId;
  String? userName;
  String? nickName;
  String? phoneCode;
  String? phoneNo;
  String? avatar;
  dynamic token;
  String? yxToken;
  String? signature;
  int? sex;
  String? inviteCode;
  dynamic superiorCode;
  double? betBalance;
  double? balance;
  int? inviterNum;
  double? inviterMoney;
  int? clubId;
  int? identityType;
  int? addVerify;
  int? usdt;
  int? betFlow;
  int? friendSta;
  int? teamSta;
  int? idCardSta;
  int? otcLeader;
  String? realName;
  String? wechat;
  String? birthday;
  int? menuType;

  UserModel({
    this.userId,
    this.userName,
    this.nickName,
    this.phoneCode,
    this.phoneNo,
    this.avatar,
    this.token,
    this.yxToken,
    this.signature,
    this.sex,
    this.inviteCode,
    this.superiorCode,
    this.betBalance,
    this.balance,
    this.inviterNum,
    this.inviterMoney,
    this.clubId,
    this.identityType,
    this.addVerify,
    this.usdt,
    this.betFlow,
    this.friendSta,
    this.teamSta,
    this.idCardSta,
    this.otcLeader,
    this.realName,
    this.wechat,
    this.birthday,
    this.menuType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['userId'] as int?,
    userName: json['userName'] as String?,
    nickName: json['nickName'] as String?,
    phoneCode: json['phoneCode'] as String?,
    phoneNo: json['phoneNo'] as String?,
    avatar: json['avatar'] as String?,
    token: json['token'] as dynamic,
    yxToken: json['yxToken'] as String?,
    signature: json['signature'] as String?,
    sex: json['sex'] as int?,
    inviteCode: json['inviteCode'] as String?,
    superiorCode: json['superiorCode'] as dynamic,
    betBalance: (json['betBalance'] as num?)?.toDouble(),
    balance: (json['balance'] as num?)?.toDouble(),
    inviterNum: json['inviterNum'] as int?,
    inviterMoney: json['inviterMoney'] as double?,
    clubId: json['clubId'] as int?,
    identityType: json['identityType'] as int?,
    addVerify: json['addVerify'] as int?,
    usdt: json['usdt'] as int?,
    betFlow: json['betFlow'] as int?,
    friendSta: json['friendSta'] as int?,
    teamSta: json['teamSta'] as int?,
    idCardSta: json['idCardSta'] as int?,
    otcLeader: json['otcLeader'] as int?,
    realName: json['realName'] as String?,
    wechat: json['wechat'] as String?,
    birthday: json['birthday'] as String?,
    menuType: json['menuType'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'nickName': nickName,
    'phoneCode': phoneCode,
    'phoneNo': phoneNo,
    'avatar': avatar,
    'token': token,
    'yxToken': yxToken,
    'signature': signature,
    'sex': sex,
    'inviteCode': inviteCode,
    'superiorCode': superiorCode,
    'betBalance': betBalance,
    'balance': balance,
    'inviterNum': inviterNum,
    'inviterMoney': inviterMoney,
    'clubId': clubId,
    'identityType': identityType,
    'addVerify': addVerify,
    'usdt': usdt,
    'betFlow': betFlow,
    'friendSta': friendSta,
    'teamSta': teamSta,
    'idCardSta': idCardSta,
    'otcLeader': otcLeader,
    'realName': realName,
    'wechat': wechat,
    'birthday': birthday,
    'menuType': menuType,
  };
}
