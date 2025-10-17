import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  // 用户令牌
  String token = '';

  // 用户的资料
  final _profile = UserModel().obs;

  /// 是否登录
  bool get isLogin => _isLogin.value;

  /// 用户 profile
  UserModel get profile => _profile.value;

  /// 是否有令牌 token
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    // 读 token
    token = Storage().getString(SPConstants.storageToken);
    _isLogin.value = token.isNotEmpty;
  }

  /// 获取用户手机号
  String getPhoneNumber() {
    return Storage().getString(SPConstants.phoneNumber);
  }

  ///获取用户密码
  String getPassword() {
    return Storage().getString(SPConstants.storagePassword);
  }

  String? getToken() {
    token = Storage().getString(SPConstants.storageToken);
    return token;
  }

  /// 设置令牌
  Future<void> setToken(String value) async {
    await Storage().setString(SPConstants.storageToken, value);
    token = value;
    _isLogin.value = true;
  }
}
