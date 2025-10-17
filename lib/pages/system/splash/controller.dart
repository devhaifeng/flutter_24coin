import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  _initData() {
    update(["splash"]);
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      if (UserService.to.getToken() != null && UserService.to.getToken() != '') {
        Get.offNamed(RouteNames.systemMain);
      } else {
        Get.offNamed(RouteNames.systemWelcome);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
