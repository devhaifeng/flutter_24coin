import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'index.dart';

class WalletUsdtReceivePage extends GetView<WalletUsdtReceiveController> {
  const WalletUsdtReceivePage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      _buildAppBar(context),
      Container(
        color: context.colors.scheme.surfaceContainerHighest,
        child: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFF3B511).withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: <Widget>[
              ImageWidget.svg(AssetsSvgs.iconWalletReceiveWarnSvg),
              SizedBox(width: 8),
              TextWidget.muted(LocaleKeys.walletReceiveHint.tr, color: Color(0xFFF3B511)),
            ].toRow().paddingLeft(15),
          ).width(double.infinity).height(40),
          SizedBox(height: 20),
          ImageWidget.svg(
            controller.coinType == 1 ? AssetsSvgs.iconWalletTrcCoinSvg : AssetsSvgs.iconWalletErcCoinSvg,
            width: 40,
            height: 40,
          ),
          SizedBox(height: 10),
          <Widget>[
            TextWidget.minbody(LocaleKeys.walletReceiveUsdt.tr, color: context.colors.scheme.onSecondary),
            TextWidget.minbody(
              controller.coinType == 1 ? '（TRC20）' : '（ERC20）',
              color: AppTheme.commonTextColorSecondery,
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start),
          SizedBox(height: 20),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
            child: <Widget>[
              if (controller.coinAddress != null)
                <Widget>[
                  QrImageView(
                    data: controller.coinAddress!, // 你的字符串数据
                    size: 260,
                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.white),
                    child: ImageWidget.svg(AssetsSvgs.iconWalletReceiveQrcodeLogoSvg, width: 50, height: 50),
                  ),
                ].toStack(alignment: Alignment.center),

              SizedBox(height: 7),
              TextWidget.body(
                controller.coinAddress ?? '',
                color: Colors.black,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 20),
            ].toColumn().marginOnly(top: 20, bottom: 20),
          ).width(double.infinity).marginSymmetric(horizontal: 20),
          SizedBox(height: 30),
          <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.scheme.secondaryFixed,
                borderRadius: BorderRadius.all(Radius.circular(19)),
              ),
              child: <Widget>[
                ImageWidget.svg(
                  AssetsSvgs.iconWalletReceiveCopySvg,
                  width: 18,
                  height: 18,
                  color: context.colors.scheme.onSecondary,
                ),
                SizedBox(width: 5),
                TextWidget.minbody(LocaleKeys.commonCopy.tr, color: context.colors.scheme.onTertiaryContainer),
              ].toRow().paddingSymmetric(horizontal: 15),
            ).width(90).height(38).onTap(() => controller.copyToClipboardSafely(controller.coinAddress ?? '')),
            ImageWidget.svg(
              Get.isDarkMode ? AssetsSvgs.iconWalletReceiveExportDarkSvg : AssetsSvgs.iconWalletReceiveExportSvg,
            ),
          ].toRowSpace(space: 10, mainAxisAlignment: MainAxisAlignment.center),
        ].toColumn().paddingAll(16),
      ).expanded(),
    ].toColumn();
  }

  Widget _buildAppBar(BuildContext context) {
    return AppTopBar(
      backIcon: IconWidget.svg(
        Get.isDarkMode ? AssetsSvgs.iconWalletReceiveBackDarkSvg : AssetsSvgs.iconWalletReceiveBackSvg,
        size: 28,
      ),
    ).backgroundColor(context.theme.colorScheme.surfaceContainerHigh).onTap(() {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletUsdtReceiveController>(
      init: WalletUsdtReceiveController(),
      id: "wallet_usdt_receive",
      builder: (_) {
        return Scaffold(body: SafeArea(bottom: false, child: _buildView(context)), resizeToAvoidBottomInset: false);
      },
    );
  }
}
