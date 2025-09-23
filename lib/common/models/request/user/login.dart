class UserLoginReq {
  String phoneNo;
  String password;
  String ip;
  String deviceInfo;
  String uuid;
  int deviceType = 1;
  String version = '1.0.0';

  UserLoginReq({
    required this.phoneNo,
    required this.password,
    required this.ip,
    required this.deviceInfo,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
    'phoneNo': phoneNo,
    'password': password,
    'ip': ip,
    'deviceInfo': deviceInfo,
    'uuid': uuid,
    'deviceType': deviceType,
    'version': version,
  };
}
