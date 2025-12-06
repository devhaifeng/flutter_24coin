import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
                color: context.colors.scheme.onSurfaceVariant,
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
                '${LocaleKeys.walletSendNumber.tr}（${(controller.coinBalance! / 100).toString()}）',
                color: context.colors.scheme.onSurfaceVariant,
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
              SizedBox(height: 15),
              <Widget>[
                TextWidget.muted(LocaleKeys.walletSendActuallyArrived.tr, color: AppTheme.info),
                SizedBox(width: 3),
                TextWidget.muted(
                  controller.coinNumberEditeTextControll.text.isEmpty
                      ? '- USDT'
                      : '${(formatNumber(double.parse(controller.coinNumberEditeTextControll.text) - (controller.gasFee.toDouble())))} USDT',
                  color: context.colors.scheme.onSurfaceVariant,
                ),
                TextWidget.muted(
                  '（${LocaleKeys.walletSendHandlingFee.tr}：${(controller.gasFee)} USDT）',
                  color: AppTheme.info,
                ),
              ].toRow().marginSymmetric(horizontal: 35),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ButtonWidget.primary(
              elevation: 0,
              LocaleKeys.commonNextStep.tr,
              height: 50,
              borderRadius: 35,
              onTap: () => displayWalletSendDialog(context),
              width: double.infinity,
            ).alignBottom().marginSymmetric(horizontal: 15, vertical: 20),
          ].toStack(),
    );
  }

  ///确认发送弹窗
  void displayWalletSendDialog(BuildContext context) {
    if (controller.coinAddressEditeTextControll.text.isEmpty) {
      SmartDialog.showToast(LocaleKeys.walletSendInputAddress.tr, alignment: Alignment.center);
      return;
    }
    if (controller.coinNumberEditeTextControll.text.isEmpty || controller.coinNumberEditeTextControll.text == '0') {
      SmartDialog.showToast(LocaleKeys.walletSendInputNumber.tr, alignment: Alignment.center);
      return;
    }
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // 点击背景是否关闭
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel, //点击关闭折罩
      barrierColor: Colors.black54, // 背景遮罩颜色
      transitionDuration: const Duration(milliseconds: 300), // 动画时长
      pageBuilder: (context, animation, secondaryAnimation) {
        return GetBuilder<WalletUsdtSendController>(
          id: "next_step",
          init: WalletUsdtSendController(),
          builder: (controller) {
            return Material(
              type: MaterialType.transparency,
              child: Align(
                alignment: Alignment.bottomCenter, // 底部对齐
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 580,
                  decoration: BoxDecoration(
                    color: context.colors.scheme.surfaceContainer,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child:
                      <Widget>[
                        dialogBackIconWidget(context).align(Alignment.topLeft),
                        <Widget>[
                          TextWidget.h5(LocaleKeys.walletSendConfirm.tr, color: context.colors.scheme.onSurfaceVariant),
                          SizedBox(height: 40),
                          controller.coinType == 0
                              ? ImageWidget.svg(AssetsSvgs.iconWalletErcCoinSvg, width: 60, height: 60)
                              : controller.coinType == 1
                              ? ImageWidget.svg(AssetsSvgs.iconWalletTrcCoinSvg, width: 60, height: 60)
                              : ImageWidget.svg(AssetsSvgs.iconWalletTrcCoinSvg, width: 60, height: 60),
                          SizedBox(height: 15),
                          TextWidget.body(
                            '-${controller.coinNumberEditeTextControll.text} USDT',
                            color: context.colors.scheme.onSurfaceVariant,
                            size: 28,
                          ),
                          SizedBox(height: 40),
                          Container(
                            decoration: BoxDecoration(
                              color: context.colors.scheme.tertiary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: <Widget>[
                              <Widget>[
                                TextWidget.label(LocaleKeys.walletSendAssetType.tr, color: AppTheme.info),
                                IconWidget.svg(
                                  controller.coinType == 0
                                      ? AssetsSvgs.iconWalletErcCoinSvg
                                      : controller.coinType == 1
                                      ? AssetsSvgs.iconWalletTrcCoinSvg
                                      : AssetsSvgs.iconWalletTrcCoinSvg,
                                  width: 12,
                                  height: 12,
                                  text:
                                      controller.coinType == 0
                                          ? 'Tether (USDT)-ERC20'
                                          : controller.coinType == 1
                                          ? 'Tether (USDT)-TRC20'
                                          : 'Tether (USDT)-TRC20',
                                ),
                              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                              SizedBox(height: 20),
                              <Widget>[
                                TextWidget.label(LocaleKeys.walletSendPaymentAddress.tr, color: AppTheme.info),
                                TextWidget.label(
                                  controller.coinAddressEditeTextControll.text,
                                  color: context.colors.scheme.onSurfaceVariant,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                ).width(120),
                              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                              SizedBox(height: 20),
                              <Widget>[
                                TextWidget.label(LocaleKeys.walletSendFee.tr, color: AppTheme.info),
                                TextWidget.label(
                                  '${controller.gasFee} USDT',
                                  color: context.colors.scheme.onSurfaceVariant,
                                ),
                              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                              SizedBox(height: 20),
                              <Widget>[
                                TextWidget.label(LocaleKeys.walletSendActualAmountReceived.tr, color: AppTheme.info),
                                TextWidget.label(
                                  '${(formatNumber(double.parse(controller.coinNumberEditeTextControll.text) - (controller.gasFee.toDouble())))} USDT',
                                  color: context.colors.scheme.onSurfaceVariant,
                                ),
                              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                            ].toColumn().align(Alignment.topLeft).paddingSymmetric(vertical: 20, horizontal: 15),
                          ),
                        ].toColumn().align(Alignment.center),
                        ButtonWidget.primary(
                          elevation: 0,
                          LocaleKeys.commonConfirm.tr,
                          height: 50,
                          enabled: true,
                          borderRadius: 35,
                          onTap:
                              () => payPasswordWidget(context, controller.coinNumberEditeTextControll.text, (
                                String password,
                              ) {
                                controller.sendUsdtTransaction(password);
                              }),
                          width: double.infinity,
                        ).alignBottom().marginOnly(top: 20),
                      ].toStack(),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // 添加动画效果
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // 从底部开始
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
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
