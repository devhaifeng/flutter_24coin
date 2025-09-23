import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  _initData() {
    update(["welcome"]);
  }

  void onTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  ///创建账户
  void createAccount() {
    Get.toNamed(RouteNames.systemRegister);
  }

  ///登录
  void goLoginView() {
    Get.toNamed(RouteNames.systemLogin);
  }
}
