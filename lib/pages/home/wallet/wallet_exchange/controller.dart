import 'package:get/get.dart';

class WalletExchangeController extends GetxController {
  WalletExchangeController();

  _initData() {
    update(["wallet_exchange"]);
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
