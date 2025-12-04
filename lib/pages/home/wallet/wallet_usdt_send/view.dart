import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/index.dart';
import 'index.dart';

class WalletUsdtSendPage extends GetView<WalletUsdtSendController> {
  const WalletUsdtSendPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    return Container(
      child:
          <Widget>[
            <Widget>[
              AppTopBar(titleString: LocaleKeys.walletSend.tr),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: context.colors.scheme.secondary,
                ),
                child: <Widget>[
                  ImageWidget.svg(AssetsSvgs.iconWalletSendHintSvg),
                  SizedBox(width: 8),
                  TextWidget.muted(LocaleKeys.walletSendHint.tr, color: AppTheme.info, size: 10).expanded(),
                ].toRow().paddingSymmetric(horizontal: 15, vertical: 9),
              ).marginSymmetric(horizontal: 15, vertical: 10),
              SizedBox(height: 5),
              TextWidget.label(
                LocaleKeys.walletSendAddress.tr,
                color: context.colors.scheme.onSecondary,
              ).marginOnly(left: 35, bottom: 10),
              SizedBox(
                    width: double.infinity,
                    height: 60,
                    child:
                        <Widget>[
                          RegisterInputWidget(
                            placeholder: LocaleKeys.walletSendInputAddress.tr,
                            radius: 30,
                            cleanable: false,
                            controller: controller.coinAddressEditeTextControll,
                          ),
                          TextWidget.label(
                            LocaleKeys.walletSendPaste.tr,
                            color: context.colors.scheme.primary,
                            onTap: () => controller.pasteText(),
                          ).alignRight().center().marginOnly(right: 65),
                          ImageWidget.svg(AssetsSvgs.iconWalletSendScanSvg).alignRight().center().marginOnly(right: 20),
                        ].toStack(),
                  )
                  .decorated(
                    color: context.colors.scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(30),
                  )
                  .marginSymmetric(horizontal: 15),
              SizedBox(height: 15),
              TextWidget.label(
                LocaleKeys.walletSendNumber.tr,
                color: context.colors.scheme.onSecondary,
              ).marginOnly(left: 35, bottom: 10),
              SizedBox(
                    width: double.infinity,
                    height: 60,
                    child:
                        <Widget>[
                          RegisterInputWidget(
                            placeholder: LocaleKeys.walletSendInputNumber.tr,
                            radius: 30,
                            keyboardType: TextInputType.number,
                            cleanable: false,
                            controller: controller.coinNumberEditeTextControll,
                          ),
                          TextWidget.label(
                            LocaleKeys.walletSendAll.tr,
                            color: context.colors.scheme.primary,
                            onTap: () => controller.inputMaxNumber(),
                          ).alignRight().center().marginOnly(right: 20),
                        ].toStack(),
                  )
                  .decorated(
                    color: context.colors.scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(30),
                  )
                  .marginSymmetric(horizontal: 15),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ButtonWidget.primary(
              elevation: 0,
              LocaleKeys.commonNextStep.tr,
              height: 50,
              borderRadius: 35,
              onTap: () => {},
              width: double.infinity,
            ).alignBottom().marginSymmetric(horizontal: 15, vertical: 20),
          ].toStack(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletUsdtSendController>(
      init: WalletUsdtSendController(),
      id: "wallet_usdt_send",
      builder: (_) {
        return Scaffold(body: SafeArea(child: _buildView(context)));
      },
    );
  }
}
