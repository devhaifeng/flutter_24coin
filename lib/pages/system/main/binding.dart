import 'package:flutter_24coin/pages/home/otc/controller.dart';
import 'package:flutter_24coin/pages/home/wallet/controller.dart';
import 'package:flutter_24coin/pages/index.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<OtcController>(() => OtcController());
    Get.lazyPut<OtcController>(() => OtcController());
    Get.lazyPut<OtcController>(() => OtcController());
    Get.lazyPut<OtcController>(() => OtcController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
