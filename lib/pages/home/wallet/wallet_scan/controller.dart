import 'package:get/get.dart';

class WalletScanController extends GetxController {
  WalletScanController();

  _initData() {
    update(["wallet_scan"]);
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
