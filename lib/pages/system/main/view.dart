import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:flutter_24coin/pages/home/contract/view.dart';
import 'package:flutter_24coin/pages/home/message/view.dart';
import 'package:flutter_24coin/pages/home/mine/view.dart';
import 'package:flutter_24coin/pages/home/otc/index.dart';
import 'package:flutter_24coin/pages/home/wallet/view.dart';
import 'package:get/get.dart';

import '../../home/wallet/index.dart';
import 'index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MainViewGetX();
  }
}

class _MainViewGetX extends GetView<MainController> {
  const _MainViewGetX();

  // 主视图
  Widget _buildView(BuildContext context) {
    return PopScope(
      // 允许返回
      canPop: false,
      // 防止连续点击两次退出
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        // 如果返回，则不执行退出请求
        if (didPop) {
          return;
        }
        // 退出请求
        if (controller.closeOnConfirm(context)) {
          SystemNavigator.pop(); // 系统级别导航栈 退出程序
        }
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: context.colors.scheme.surfaceContainerHighest,
        bottomNavigationBar: GetBuilder<MainController>(
          id: "navigation",
          builder: (controller) {
            return BuildNavigation(
              currentIndex: controller.currentIndex,
              items: [
                NavigationItemModel(
                  label: LocaleKeys.mainNavigationWallet.tr,
                  icon:
                      controller.currentIndex == 0
                          ? AssetsSvgs.iconMainNagivationWalletLightSvg
                          : AssetsSvgs.iconMainNagivationWalletSvg,
                ),
                NavigationItemModel(
                  label: LocaleKeys.mainNavigationOtc.tr,
                  icon:
                      controller.currentIndex == 1
                          ? AssetsSvgs.iconMainNagivationOtcLightSvg
                          : AssetsSvgs.iconMainNagivationOtcSvg,
                ),
                NavigationItemModel(
                  label: LocaleKeys.mainNavigationMessage.tr,
                  icon:
                      controller.currentIndex == 2
                          ? AssetsSvgs.iconMainNagivationMessageLightSvg
                          : AssetsSvgs.iconMainNagivationMessageSvg,
                  // 购物车数量
                  count: 9,
                ),
                NavigationItemModel(
                  label: LocaleKeys.mainNavigationAddressBook.tr,
                  icon:
                      controller.currentIndex == 3
                          ? AssetsSvgs.iconMainNagivationAddressBookLightSvg
                          : AssetsSvgs.iconMainNagivationAddressBookSvg,
                ),
                NavigationItemModel(
                  label: LocaleKeys.mainNavigationSetting.tr,
                  icon:
                      controller.currentIndex == 4
                          ? AssetsSvgs.iconMainNagivationSettingLightSvg
                          : AssetsSvgs.iconMainNagivationSettingSvg,
                ),
              ],
              onTap: controller.onJumpToPage,
            );
          },
        ),
        // 内容页
        body: IndexedStack(
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: controller.onIndexChanged,
              children: const [WalletPage(), OtcPage(), MessagePage(), ContractPage(), MinePage()],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      // init: MainController(),
      id: "main",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
