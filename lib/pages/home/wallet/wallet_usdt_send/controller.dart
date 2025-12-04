import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletUsdtSendController extends GetxController {
  WalletUsdtSendController();

  ///币地址输入框控制器
  TextEditingController coinAddressEditeTextControll = TextEditingController();

  ///币数量输入框控制器
  TextEditingController coinNumberEditeTextControll = TextEditingController();

  int? coinType = Get.arguments["coinType"];

  int? coinBalance = Get.arguments["coinBalance"];

  _initData() {
    update(["wallet_usdt_send"]);
  }

  @override
  void onInit() {
    super.onInit();
    coinNumberEditeTextControll.addListener(() {
      String text = coinNumberEditeTextControll.text;
      // 检查输入是否以小数点开头
      if (text.startsWith('.')) {
        // 如果是，则在小数点前添加一个零
        coinNumberEditeTextControll.text = '0$text';
        // 将光标移动到文本的末尾
        coinNumberEditeTextControll.selection = TextSelection.fromPosition(
          TextPosition(offset: coinNumberEditeTextControll.text.length),
        );
      } else {
        text.toDouble() > coinBalance! / 100
            ? coinNumberEditeTextControll.text = (coinBalance! / 100).toString()
            : null;
      }
    });
  }

  void inputMaxNumber() {
    coinNumberEditeTextControll.text = (coinBalance! / 100).toString();
    _initData();
  }

  void onTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // 在异步方法中执行粘贴操作
  Future<void> pasteText() async {
    // 从剪贴板获取数据，指定需要纯文本格式[1,6](@ref)
    ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    // 检查获取到的数据以及其中的text是否非空
    if (clipboardData != null && clipboardData.text != null) {
      String pastedText = clipboardData.text!;
      coinAddressEditeTextControll.text = pastedText;
      _initData();
    } else {
      print('剪贴板为空或无法读取内容。');
    }
  }

  @override
  void onClose() {
    super.onClose();
    coinAddressEditeTextControll.dispose();
    coinNumberEditeTextControll.dispose();
  }
}
