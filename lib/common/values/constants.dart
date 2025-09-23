/// 常量
class Constants {
  // 服务 api
  static const apiUrl = 'http://3.1.213.205:8083';
  static const coinApiUrl = 'http://dctools.24pay01.cn';
  static const wsToken = 'oKRBn6Z4E7GmbINzTOK8';

  ///接口成功状态
  static const successCode = 200;

  static const netLineList = [
    "https://test.lalashi.cn/",
    "http://3.1.213.205:8083/",
    "https://13593x8f03.vicp.fun/",
    "http://s2.gnip.vip:12201/",
    "https://huhuhu.xiaomiqiu.com/",
    "http://18auor894856.vicp.fun/ ",
  ];
}

class SPConstants {
  ///语言
  static const storageLanguageCode = 'language_code';

  ///首次打开
  static const storageAlreadyOpen = 'already_open';

  ///最后一次选择的线路
  static const storageNetLine = 'net_line_choose';

  ///接口token
  static const storageToken = 'token';

  ///用户资料
  static const storageProfile = 'user_profile';

  ///保存手机号
  static const isRememberPwd = 'remember_password';

  ///保存用户密码
  static const storagePassword = 'password';

  ///保存手机号
  static const phoneNumber = 'phoneNumber';
}
