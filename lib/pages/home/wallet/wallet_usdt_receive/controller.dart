import 'package:get/get.dart';

class WalletUsdtReceiveController extends GetxController {
  WalletUsdtReceiveController();

  _initData() {
    update(["wallet_usdt_receive"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
