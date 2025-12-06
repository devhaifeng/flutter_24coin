import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

typedef StringCallbackWithParam = Function(String password);

class PayPasswordControll extends GetxController {
  PayPasswordControll();

  ///密码输入框控制器
  final passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }
}

///输入密码弹窗
void payPasswordWidget(BuildContext context, String payAmount, StringCallbackWithParam sendUsdtTransaction) {
  PinTheme defaultPinTheme = PinTheme(
    width: 45,
    height: 45,
    decoration: BoxDecoration(color: Get.isDarkMode ? Color(0xFF28323E) : Colors.transparent),
  );

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return GetBuilder<PayPasswordControll>(
        id: "password_input",
        init: PayPasswordControll(),
        builder: (controller) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              // 使用 Center 组件实现居中
              child: Container(
                width: 315,
                height: 220,
                decoration: BoxDecoration(
                  color: context.colors.scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: <Widget>[
                  dialogBackIconWidget(context).align(Alignment.topLeft).align(Alignment.topLeft),
                  <Widget>[
                    TextWidget.h5(
                      LocaleKeys.commonInputPayPassword.tr,
                      color: context.colors.scheme.onSurfaceVariant,
                    ).marginOnly(top: 20),
                    SizedBox(height: 10),
                    <Widget>[
                      TextWidget.body(payAmount, color: context.colors.scheme.onSurfaceVariant, size: 40),
                      TextWidget.body(
                        'USDT',
                        color: context.colors.scheme.onSurfaceVariant,
                        size: 20,
                      ).marginOnly(bottom: 8),
                    ].toRowSpace(
                      space: 5,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(height: 10),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 0.5, color: Get.isDarkMode ? Color(0xFF3B4757) : Color(0xFFCDCDCD)),
                      ),
                      child: Pinput(
                        length: 6,
                        obscureText: true,
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocusNode,

                        separatorBuilder:
                            (index) => Container(
                              height: 45,
                              width: 0.5,
                              color: Get.isDarkMode ? Color(0xFF3B4757) : Color(0xFFCDCDCD),
                            ),
                        defaultPinTheme: defaultPinTheme,
                        showCursor: true,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: BoxDecoration(color: Get.isDarkMode ? Color(0xFF3B4757) : Color(0xFFCDCDCD)),
                        ),
                        autofocus: true,
                        onCompleted: (value) {
                          Get.back();
                          sendUsdtTransaction(value);
                        },
                      ),
                    ),
                  ].toColumn(),
                ].toStack(alignment: Alignment.center).paddingAll(15),
              ),
            ),
          );
        },
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // 添加动画效果
      return ScaleTransition(scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack), child: child);
    },
  );
}
