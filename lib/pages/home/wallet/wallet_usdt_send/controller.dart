import 'package:get/get.dart';

class WalletUsdtSendController extends GetxController {
  WalletUsdtSendController();

  _initData() {
    update(["wallet_usdt_send"]);
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
