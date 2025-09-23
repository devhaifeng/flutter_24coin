import 'package:get/get.dart';

class OtcController extends GetxController {
  OtcController();

  _initData() {
    update(["otc"]);
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
