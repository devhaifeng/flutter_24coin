import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../../common/index.dart';

class WalletUsdtReceiveController extends GetxController {
  WalletUsdtReceiveController();

  int? coinType = Get.arguments["coinType"];

  String? coinAddress = Get.arguments["coinAddress"];

  _initData() {
    update(["wallet_usdt_receive"]);
  }

  void onTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  Future<void> copyToClipboardSafely(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      SmartDialog.showToast(LocaleKeys.commonCopySuccess.tr);
      // 显示成功提示
    } catch (e) {
      SmartDialog.showToast(LocaleKeys.commonCopyFail.tr);
    }
  }
}
