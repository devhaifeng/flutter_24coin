import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:flutter_24coin/pages/home/wallet/index.dart';
import 'package:get/get.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _WalletViewGetX();
  }
}

class _WalletViewGetX extends GetView<WalletController> {
  const _WalletViewGetX();

  /// 钱包余额
  Widget _buildWalletBalance(BuildContext context) {
    return SizedBox(
      height: 225,
      width: double.infinity,
      child: Center(
        child:
            controller.walletIndexData?.address != null
                ? <Widget>[
                  TextWidget.label(
                    controller.walletIndexData?.balance != null
                        ? formatNumber(controller.walletIndexData!.balance! / 100)
                        : "0",
                    size: 40,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  TextWidget.label(
                    controller.walletIndexData?.address ?? "",
                    size: 14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    color: AppTheme.commonTextColorSecondery,
                  ).width(200),
                  SizedBox(height: 16),
                  <Widget>[
                    <Widget>[
                          ImageWidget.svg(
                            controller.walletIndexData?.type == 3 || controller.walletIndexData?.type == 4
                                ? Get.isDarkMode
                                    ? AssetsSvgs.iconWalletTransferUnableDarkSvg
                                    : AssetsSvgs.iconWalletTransferUnableSvg
                                : Get.isDarkMode
                                ? AssetsSvgs.iconWalletTransferDarkSvg
                                : AssetsSvgs.iconWalletTransferSvg,
                            width: 40,
                            height: 40,
                          ),
                          TextWidget.label(
                            LocaleKeys.walletSend.tr,
                            size: 14,
                            color:
                                controller.walletIndexData?.type == 3 || controller.walletIndexData?.type == 4
                                    ? AppTheme.info
                                    : Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ]
                        .toColumnSpace(
                          space: 8,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                        .onTap(() {
                          if (controller.walletIndexData?.type == 1 || controller.walletIndexData?.type == 2) {
                            Get.toNamed(
                              RouteNames.homeWalletWalletUsdtSend,
                              arguments: {
                                "coinType": controller.walletIndexData?.type,
                                "coinBalance": controller.walletIndexData?.balance,
                              },
                            );
                          }
                        }),
                    <Widget>[
                          ImageWidget.svg(
                            controller.walletIndexData?.type == 3 || controller.walletIndexData?.type == 4
                                ? Get.isDarkMode
                                    ? AssetsSvgs.iconWalletAcceptUnableDarkSvg
                                    : AssetsSvgs.iconWalletAcceptUnableSvg
                                : Get.isDarkMode
                                ? AssetsSvgs.iconWalletAcceptEnableDarkSvg
                                : AssetsSvgs.iconWalletAcceptEnableSvg,
                            width: 40,
                            height: 40,
                          ),
                          TextWidget.label(
                            LocaleKeys.walletReceive.tr,
                            size: 14,
                            color:
                                controller.walletIndexData?.type == 3 || controller.walletIndexData?.type == 4
                                    ? AppTheme.info
                                    : Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ]
                        .toColumnSpace(
                          space: 8,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                        .onTap(() {
                          if (controller.walletIndexData?.type == 1 || controller.walletIndexData?.type == 2) {
                            Get.toNamed(
                              RouteNames.homeWalletWalletUsdtReceive,
                              arguments: {
                                "coinType": controller.walletIndexData?.type,
                                "coinAddress": controller.walletIndexData?.address,
                              },
                            );
                          }
                        }),
                    <Widget>[
                      ImageWidget.svg(
                        Get.isDarkMode
                            ? AssetsSvgs.iconWalletExchangeEnableDarkSvg
                            : AssetsSvgs.iconWalletExchangeEnableSvg,
                        width: 40,
                        height: 40,
                      ),
                      TextWidget.label(
                        LocaleKeys.walletExchange.tr,
                        size: 14,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ].toColumnSpace(
                      space: 8,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    <Widget>[
                      ImageWidget.svg(
                        controller.walletIndexData?.type == 3
                            ? Get.isDarkMode
                                ? AssetsSvgs.iconWalletSellEnableDarkSvg
                                : AssetsSvgs.iconWalletSellEnableSvg
                            : controller.walletIndexData?.type == 4
                            ? Get.isDarkMode
                                ? AssetsSvgs.iconWalletScanUnableDarkSvg
                                : AssetsSvgs.iconWalletScanUnableSvg
                            : Get.isDarkMode
                            ? AssetsSvgs.iconWalletScanEnableDarkSvg
                            : AssetsSvgs.iconWalletScanEnableSvg,
                        width: 40,
                        height: 40,
                      ),
                      TextWidget.label(
                        controller.walletIndexData?.type == 3 ? LocaleKeys.walletSell.tr : LocaleKeys.walletScan.tr,
                        size: 14,
                        color:
                            controller.walletIndexData?.type == 4
                                ? AppTheme.info
                                : Get.isDarkMode
                                ? Colors.white
                                : Colors.black,
                      ),
                    ].toColumnSpace(
                      space: 8,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ].toColumn(mainAxisSize: MainAxisSize.min).padding(left: 55, right: 55)
                : _buildNoAddressCoinView(context).marginOnly(top: 40), //币种没有地址显示布局
      ),
    );
  }

  ///币种余额
  Widget _buildCoinBalance(BuildContext context) {
    return SizedBox(
          width: double.infinity,
          child: Center(
            child: <Widget>[
              _build24CoinIBalanceItem(context),
              Divider(height: 0.5, color: Get.isDarkMode ? Color(0xFF28343F) : Color(0xFFEEEEEE)),
              _build48CoinIBalanceItem(context),
              Divider(height: 0.5, color: Get.isDarkMode ? Color(0xFF28343F) : Color(0xFFEEEEEE)),
              _buildUsdtBalanceItem(context),
            ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          ),
        )
        .decorated(color: Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(16))
        .paddingHorizontal(16);
  }

  /// 币种余额项
  Widget _build24CoinIBalanceItem(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: InkWell(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        onTap: () {
          print("点击了48coin");
        },
        child: <Widget>[
          ImageWidget.img(AssetsImages.iconWalletCoinPng, width: 40, height: 40),
          <Widget>[
            TextWidget.label(
              "24coin",
              size: 14,
              weight: FontWeight.w400,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            TextWidget.label(
              LocaleKeys.wallet24CoinHint.tr,
              size: 12,
              color: AppTheme.commonTextColorSecondery,
              weight: FontWeight.w400,
            ),
          ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start).paddingLeft(13),
          Spacer(),
          TextWidget.label(
            controller.mCoinBalanceData?.balance?.toString() ?? "0",
            size: 14,
            weight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ].toRow().paddingAll(14),
      ),
    );
  }

  /// 币种余额项
  Widget _build48CoinIBalanceItem(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: InkWell(
        onTap: () {
          print("点击了48coin");
        },
        // 1. 点击时扩散的涟漪颜色（设置为蓝色）
        child: <Widget>[
          ImageWidget.img(AssetsImages.iconWalletCoin2Png, width: 40, height: 40),
          <Widget>[
            TextWidget.label(
              "48coin",
              size: 14,
              weight: FontWeight.w400,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            TextWidget.label(
              LocaleKeys.wallet48CoinHint.tr,
              size: 12,
              color: AppTheme.commonTextColorSecondery,
              weight: FontWeight.w400,
            ),
          ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start).paddingLeft(13),
          Spacer(),
          TextWidget.label(
            controller.mCoinBalanceData?.betBalance?.toString() ?? "0",
            size: 14,
            weight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ].toRow().paddingAll(14).width(double.infinity),
      ),
    );
  }

  /// 币种余额项
  Widget _buildUsdtBalanceItem(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: InkWell(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        onTap: () {},
        // 1. 点击时扩散的涟漪颜色（设置为蓝色）
        splashColor: Colors.transparent, // 加一点透明度通常更好看
        highlightColor: !Get.isDarkMode ? Color(0xFFE1DFDF) : Color(0xFF28343F),
        hoverColor: !Get.isDarkMode ? Color(0xFFE1DFDF) : Color(0xFF28343F),
        child: <Widget>[
          ImageWidget.svg(AssetsSvgs.iconWalletUsdtCoinSvg, width: 40, height: 40),
          <Widget>[
            TextWidget.label(
              "USDT",
              size: 14,
              weight: FontWeight.w400,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            TextWidget.label(
              LocaleKeys.walletUsdtHint.tr,
              size: 12,
              color: AppTheme.commonTextColorSecondery,
              weight: FontWeight.w400,
            ),
          ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start).paddingLeft(13),
          Spacer(),
          TextWidget.label(
            controller.mCoinBalanceData?.usdt != null ? (controller.mCoinBalanceData!.usdt! / 100).toString() : "0",
            size: 14,
            weight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ].toRow().paddingAll(14),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    if (controller.allowedCoinList?.isNotEmpty == true) {
      CoinAllowData? checkItem = controller.allowedCoinList?.firstWhere(
        (element) => element.isSelected!,
        orElse:
            () => CoinAllowData(
              value: 3,
              appDisplay: "24Coin",
              assetsPath: AssetsImages.iconWalletCoinPng,
              isSelected: true,
            ), // 或者返回一个默认的占位对象，例如 WalletItem.empty()
      );
      var commonDivideColor = Get.isDarkMode ? Color(0xFF2B3843) : Color(0xFFF5F5F5);
      return <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton2<CoinAllowData>(
            menuItemStyleData: MenuItemStyleData(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              height: 35,
              padding: EdgeInsets.only(left: 15, right: 15),
            ),
            // 按钮样式
            customButton: Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.surfaceContainer,
              height: 50,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: <Widget>[
                        checkItem?.value == 1 || checkItem?.value == 2
                            ? ImageWidget.svg(checkItem?.assetsPath ?? "", width: 18, height: 18)
                            : ImageWidget.img(checkItem?.assetsPath ?? "", width: 18, height: 18),

                        SizedBox(width: 6),
                        TextWidget.label(checkItem!.appDisplay!, size: 15, weight: FontWeight.w400),
                        SizedBox(width: 2),
                        IconWidget.svg(AssetsSvgs.iconCommonArrowRightSvg, size: 16),
                      ]
                      .toRow(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      )
                      .paddingHorizontal(10)
                      .height(34),
                ),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              width: 175,
              padding: EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
              offset: Offset(MediaQuery.of(context).size.width / 2 - 175 / 2, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: Radius.circular(15),
                thickness: WidgetStateProperty.all(0),
                thumbColor: WidgetStateProperty.all(Colors.grey.shade400),
              ),
            ),
            // 扩展
            isExpanded: false,

            // 提示组件
            // 下拉项列表
            items:
                controller.allowedCoinList
                    ?.map(
                      (item) => DropdownMenuItem<CoinAllowData>(
                        value: item,
                        child:
                            <Widget>[
                              item.value == 1 || item.value == 2
                                  ? ImageWidget.svg(item.assetsPath ?? "", width: 18, height: 18)
                                  : ImageWidget.img(item.assetsPath ?? "", width: 18, height: 18),
                              SizedBox(width: 7),
                              TextWidget.label(
                                item.appDisplay ?? "",
                                color: item.isSelected! ? context.colors.scheme.onSurface : AppTheme.info,
                              ),
                              Expanded(
                                // 占据剩余空间
                                child: SizedBox(), // 使用一个空的SizedBox，或者你可以放置一个空的Container
                              ),
                              item.isSelected!
                                  ? ImageWidget.svg(AssetsSvgs.svgCommonTickSvg, width: 12, height: 9)
                                  : SizedBox(),
                            ].toRow(),
                      ),
                    )
                    .toList(),

            // 选中项
            value: controller.allowedCoinList?.firstWhere((element) => element.isSelected!),
            // 改变事件
            onChanged: controller.onSelectorCoinChanged,
          ),
        ),
        Expanded(
          child: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildWalletBalance(context),
                      SizedBox(height: 10),
                      _buildCoinBalance(context),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                // TabBar
                SliverPadding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  sliver: SliverPersistentHeader(
                    pinned: false,
                    floating: true,
                    delegate: _StickyTabBarDelegate(
                      child: TabBar(
                        indicatorColor: Colors.transparent,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory, // 关闭水波纹效果
                        dividerHeight: 0.5,
                        dividerColor: Get.isDarkMode ? Color(0xFF28343F) : Color(0xFFEEEEEE),
                        labelColor: AppTheme.primary,
                        unselectedLabelColor: AppTheme.commonTextColorSecondery,
                        controller: controller.tabController,
                        labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                        tabs: [
                          Tab(text: LocaleKeys.walletTabHot.tr),
                          Tab(text: LocaleKeys.walletTabGainer.tr),
                          Tab(text: LocaleKeys.walletTabLoser.tr),
                          Tab(text: LocaleKeys.walletTabTransaction.tr),
                          Tab(text: LocaleKeys.walletTabInformation.tr),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
                  controller: controller.tabController,
                  children: [
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.hotList?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) {
                        return index != 0
                            ? Divider(
                              thickness: 1,
                              height: 0,
                              color: commonDivideColor,
                            ).marginSymmetric(horizontal: 16, vertical: 0)
                            : Divider(height: 0, color: Colors.transparent);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final coinItem = controller.hotList?[index];
                        if (index == 0) {
                          return Row(
                            children: [
                              TextWidget.label(
                                LocaleKeys.walletTabCoinType.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              Spacer(),
                              TextWidget.label(
                                LocaleKeys.walletTabNewPrice.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              SizedBox(width: 60),
                              TextWidget.label(
                                LocaleKeys.walletTabDayGainerLoser.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                            ],
                          ).marginOnly(left: 16, top: 10, right: 16);
                        } else {
                          return CoinItemWidget(
                            coinName: coinItem?.S,
                            logoUrl: coinItem?.logoUrl,
                            newPrice: coinItem!.u.toString(),
                            rightText:
                                Reguix.isPositiveNumber(coinItem.c.toString())
                                    ? "+${coinItem.c?.toStringAsFixed(2)}%"
                                    : "${coinItem.c?.toStringAsFixed(2)}%",
                            rightColor:
                                Reguix.isPositiveNumber(coinItem.c.toString()) ? Color(0xff13BD57) : Color(0xffF25644),
                          );
                        }
                      },
                    ),
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.irateList?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) {
                        return index != 0
                            ? Divider(
                              thickness: 1,
                              height: 0,
                              color: commonDivideColor,
                            ).marginSymmetric(horizontal: 16, vertical: 0)
                            : Divider(height: 0, color: Colors.transparent);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final irateItem = controller.irateList?[index];
                        if (index == 0) {
                          return Row(
                            children: [
                              TextWidget.label(
                                LocaleKeys.walletTabCoinType.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              Spacer(),
                              TextWidget.label(
                                LocaleKeys.walletTabNewPrice.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              SizedBox(width: 60),
                              TextWidget.label(
                                LocaleKeys.walletTabDayGainer.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                            ],
                          ).marginOnly(left: 16, top: 10, right: 16);
                        } else {
                          return CoinItemWidget(
                            coinName: irateItem?.S,
                            logoUrl: irateItem?.logoUrl,
                            newPrice: irateItem?.v.toString(),
                            rightText:
                                Reguix.isPositiveNumber(irateItem!.c.toString())
                                    ? "+${irateItem.c?.toStringAsFixed(2)}%"
                                    : "${irateItem.c?.toStringAsFixed(2)}%",
                            rightColor: AppTheme.success,
                          );
                        }
                      },
                    ),
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.drateList?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) {
                        return index != 0
                            ? Divider(
                              thickness: 1,
                              height: 0,
                              color: commonDivideColor,
                            ).marginSymmetric(horizontal: 16, vertical: 0)
                            : Divider(height: 0, color: Colors.transparent);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final coinItem = controller.drateList?[index];
                        if (index == 0) {
                          return Row(
                            children: [
                              TextWidget.label(
                                LocaleKeys.walletTabCoinType.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              Spacer(),
                              TextWidget.label(
                                LocaleKeys.walletTabNewPrice.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              SizedBox(width: 60),
                              TextWidget.label(
                                LocaleKeys.walletTabDayLoser.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                            ],
                          ).marginOnly(left: 16, top: 10, right: 16);
                        } else {
                          return CoinItemWidget(
                            coinName: coinItem?.S,
                            logoUrl: coinItem?.logoUrl,
                            newPrice: coinItem?.u.toString(),
                            rightText:
                                Reguix.isPositiveNumber(coinItem!.c.toString())
                                    ? "+${coinItem.c?.toStringAsFixed(2)}%"
                                    : "${coinItem.c?.toStringAsFixed(2)}%",
                            rightColor: AppTheme.error,
                          );
                        }
                      },
                    ),
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.dealList?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) {
                        return index != 0
                            ? Divider(
                              thickness: 1,
                              height: 0,
                              color: commonDivideColor,
                            ).marginSymmetric(horizontal: 16, vertical: 0)
                            : Divider(height: 0, color: Colors.transparent);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final coinItem = controller.dealList?[index];
                        if (index == 0) {
                          return Row(
                            children: [
                              TextWidget.label(
                                LocaleKeys.walletTabCoinType.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              Spacer(),
                              TextWidget.label(
                                LocaleKeys.walletTabNewPrice.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                              SizedBox(width: 60),
                              TextWidget.label(
                                LocaleKeys.walletTabDayVolume.tr,
                                size: 10,
                                color: AppTheme.commonTextColorSecondery,
                              ),
                            ],
                          ).marginOnly(left: 16, top: 10, right: 16);
                        } else {
                          return CoinItemWidget(
                            coinName: coinItem?.S,
                            logoUrl: coinItem?.logoUrl,
                            newPrice: coinItem?.u.toString(),
                            rightText: Reguix.formatNumberWithUnit(coinItem!.v!),
                            rightColor: Get.isDarkMode ? Colors.white : Colors.black,
                          );
                        }
                      },
                    ),

                    /// 资讯
                    CustomScrollView(physics: ClampingScrollPhysics(), slivers: buildAllNewsSlivers()),
                  ],
                )
                .decorated(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                )
                .paddingHorizontal(16),
          ),
        ),
      ].toColumn();
    } else {
      return SizedBox();
    }
  }

  /// 构建所有新闻的 Slivers 列表
  List<Widget> buildAllNewsSlivers() {
    List<Widget> allSlivers = [];
    for (var item in controller.coinNewsList!) {
      // 1. 添加日期标题（作为一个普通的 Sliver）
      allSlivers.add(
        SliverToBoxAdapter(
          child: <Widget>[
            ImageWidget.svg(AssetsSvgs.iconWalletNewsTimeSvg, width: 6, height: 6),
            SizedBox(width: 8),
            TextWidget.label(item.date ?? "", size: 13, color: Get.isDarkMode ? Colors.white : Colors.black),
          ].toRow().marginOnly(left: 9, top: 9), // 你原来的日期行 Widget
        ),
      );
      // 2. 添加该日期下的所有新闻项（作为一个 SliverList）
      allSlivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Datum contentItem = item.data![index];
            String time =
                "${DateTime.fromMillisecondsSinceEpoch(contentItem.timestamp!).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(contentItem.timestamp!).minute.toString().padLeft(2, '0')}";

            // 返回你原来的那个时间轴条目 Stack 布局的 Widget
            return <Widget>[
              Positioned(
                left: 11.5,
                top: index == 0 ? 13 : 0,
                bottom: 0,
                child: DashedLine(
                  size: double.infinity,
                  dashedWidth: 0.5,
                  dashedHeight: 4,
                  density: item.data![index].content!.length >= 100 ? 15 : 10,
                  axis: Axis.vertical,
                  dashedColor: Color(0xFF9BA9B6),
                ),
              ),
              <Widget>[
                ImageWidget.svg(AssetsSvgs.iconCommonCircleSvg, width: 4, height: 4),
              ].toColumn().paddingSymmetric(horizontal: 10, vertical: 14),
              <Widget>[
                TextWidget.label(time, size: 12, color: AppTheme.commonTextColorSecondery),
                TextWidget.label(
                  contentItem.title.toString(),
                  size: 13,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                TextWidget.label(
                  contentItem.content.toString(),
                  size: 11,
                  maxLines: 3,
                  color: AppTheme.commonTextColorSecondery,
                ),
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).paddingSymmetric(horizontal: 24, vertical: 7),
            ].toStack();
          }, childCount: item.data?.length ?? 0),
        ),
      );
    }
    return allSlivers;
  }

  /// 币种没有地址显示布局
  Widget _buildNoAddressCoinView(BuildContext context) {
    return <Widget>[
      ImageWidget.svg(
        controller.walletIndexData?.type == 1
            ? AssetsSvgs.iconWalletTrcCoinSvg
            : controller.walletIndexData?.type == 2
            ? AssetsSvgs.iconWalletErcCoinSvg
            : controller.walletIndexData?.type == 3
            ? AssetsImages.iconWalletCoinPng
            : AssetsImages.iconWalletCoin2Png,
        width: 60,
        height: 60,
      ),
      SizedBox(height: 20),
      TextWidget.label("暂未生成地址，无法使用相应功能", size: 14, color: context.colors.scheme.onSecondary),
      SizedBox(height: 15),
      ButtonWidget.primary("生成地址", width: 92, height: 32, borderRadius: 16, enabled: true, onTap: () => {}),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      init: Get.find<WalletController>(),
      id: "wallet",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(backgroundColor: context.colors.scheme.surfaceContainer, elevation: 0, toolbarHeight: 0),
          body: SafeArea(child: _buildView(context)),
          backgroundColor: context.colors.scheme.surfaceContainerHighest,
        );
      },
    );
  }
}

// 自定义SliverPersistentHeaderDelegate实现粘性TabBar
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabBarDelegate({required this.child});

  final TabBar child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: child).decorated(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
