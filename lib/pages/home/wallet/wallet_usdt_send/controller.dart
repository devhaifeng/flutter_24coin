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

  int? coinType;

  int? coinBalance;

  int gasFee = 1;

  ///密码输入框控制器
  final passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();

  _initData() {
    update(["wallet_usdt_send"]);
  }

  @override
  void onInit() {
    super.onInit();
    coinType = Get.arguments["coinType"];
    coinBalance = Get.arguments["coinBalance"];
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
        if (text.isEmpty) {
          return;
        }
        text.toDouble() > coinBalance! / 100
            ? coinNumberEditeTextControll.text = (coinBalance! / 100).toString()
            : null;
        update(["wallet_usdt_send"]);
      }
    });

    passwordController.addListener(() {
      update(["wallet_usdt_send"]);
    });
  }

  void inputMaxNumber() {
    coinNumberEditeTextControll.text = (coinBalance! / 100).toString();
    _initData();
  }

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

  void sendUsdtTransaction(String value) {
    // 在这里处理发送USDT交易的逻辑，使用传入的密码value
    passwordController.clear();
    passwordFocusNode.unfocus();

    ///调用API接口
  }

  @override
  void onClose() {
    super.onClose();
    coinAddressEditeTextControll.dispose();
    coinNumberEditeTextControll.dispose();
  }
}
