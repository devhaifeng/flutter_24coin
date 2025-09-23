import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageWidget.svg(AssetsSvgs.welcomeSvg, fit: BoxFit.fill),
        Positioned(
          left: 30.w,
          right: 30.w,
          bottom: 60.w,
          child:
              <Widget>[
                ButtonWidget.primary(
                  elevation: 0,
                  LocaleKeys.welcomLoginButton.tr,
                  height: 50,
                  borderRadius: 35,
                  onTap: () => controller.goLoginView(),
                  width: double.infinity,
                ),
                SizedBox(height: 10.h),
                ButtonWidget.ghost(
                  elevation: 0,
                  textColor: Color(0xFF333333),
                  backgroundColor: Color(0xFFF5F5F5),
                  LocaleKeys.welcomCreateAccount.tr,
                  height: 50,
                  borderRadius: 35,
                  onTap: () => controller.createAccount(),
                  width: double.infinity,
                ),
              ].toColumn(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      id: "welcome",
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle.dark),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
