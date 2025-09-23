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
        child: <Widget>[
          TextWidget.label("4500", size: 40, color: Get.isDarkMode ? Colors.white : Colors.black),
          TextWidget.label("EJD65K69N9…D204LDLJSU", size: 14, color: AppTheme.commonTextColorSecondery),
          SizedBox(height: 16),
          <Widget>[
            <Widget>[
              ImageWidget.svg(
                Get.isDarkMode ? AssetsSvgs.iconWalletTransferDarkSvg : AssetsSvgs.iconWalletTransferSvg,
                width: 40,
                height: 40,
              ),
              TextWidget.label("发送", size: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
            ].toColumnSpace(space: 8, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center),
            <Widget>[
              ImageWidget.svg(
                Get.isDarkMode ? AssetsSvgs.iconWalletAcceptEnableDarkSvg : AssetsSvgs.iconWalletAcceptEnableSvg,
                width: 40,
                height: 40,
              ),
              TextWidget.label("接收", size: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
            ].toColumnSpace(space: 8, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center),
            <Widget>[
              ImageWidget.svg(
                Get.isDarkMode ? AssetsSvgs.iconWalletExchangeEnableDarkSvg : AssetsSvgs.iconWalletExchangeEnableSvg,
                width: 40,
                height: 40,
              ),
              TextWidget.label("兑换", size: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
            ].toColumnSpace(space: 8, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center),
            <Widget>[
              ImageWidget.svg(
                Get.isDarkMode ? AssetsSvgs.iconWalletSellEnableDarkSvg : AssetsSvgs.iconWalletSellEnableSvg,
                width: 40,
                height: 40,
              ),
              TextWidget.label("出售", size: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
            ].toColumnSpace(space: 8, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        ].toColumn(mainAxisSize: MainAxisSize.min).padding(left: 55, right: 55),
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
              "可进行任意交易买卖/转账",
              size: 12,
              color: AppTheme.commonTextColorSecondery,
              weight: FontWeight.w400,
            ),
          ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start).paddingLeft(13),
          Spacer(),
          TextWidget.label(
            "4500",
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
              "交易购买所得，只允许转账",
              size: 12,
              color: AppTheme.commonTextColorSecondery,
              weight: FontWeight.w400,
            ),
          ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start).paddingLeft(13),
          Spacer(),
          TextWidget.label(
            "4500",
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
            TextWidget.label("可进行任何转账", size: 12, color: AppTheme.commonTextColorSecondery, weight: FontWeight.w400),
          ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start).paddingLeft(13),
          Spacer(),
          TextWidget.label(
            "730",
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
    var commonDivideColor = Get.isDarkMode ? Color(0xFF2B3843) : Color(0xFFF5F5F5);
    return <Widget>[
      Container(
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
                  ImageWidget.img(AssetsImages.iconWalletCoinPng, width: 18, height: 18, radius: 0, fit: BoxFit.cover),
                  SizedBox(width: 6),
                  TextWidget.label("24Coin", size: 15, weight: FontWeight.w400),
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
                      tabs: const [
                        Tab(text: "热门"),
                        Tab(text: "涨幅榜"),
                        Tab(text: "跌幅榜"),
                        Tab(text: "成交榜"),
                        Tab(text: "资讯"),
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
                            TextWidget.label("币种", size: 10, color: AppTheme.commonTextColorSecondery),
                            Spacer(),
                            TextWidget.label("最新价", size: 10, color: AppTheme.commonTextColorSecondery),
                            SizedBox(width: 60),
                            TextWidget.label("24涨跌幅", size: 10, color: AppTheme.commonTextColorSecondery),
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
                            TextWidget.label("币种", size: 10, color: AppTheme.commonTextColorSecondery),
                            Spacer(),
                            TextWidget.label("最新价", size: 10, color: AppTheme.commonTextColorSecondery),
                            SizedBox(width: 60),
                            TextWidget.label("24h涨幅", size: 10, color: AppTheme.commonTextColorSecondery),
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
                            TextWidget.label("币种", size: 10, color: AppTheme.commonTextColorSecondery),
                            Spacer(),
                            TextWidget.label("最新价", size: 10, color: AppTheme.commonTextColorSecondery),
                            SizedBox(width: 60),
                            TextWidget.label("24h跌幅", size: 10, color: AppTheme.commonTextColorSecondery),
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
                            TextWidget.label("币种", size: 10, color: AppTheme.commonTextColorSecondery),
                            Spacer(),
                            TextWidget.label("最新价", size: 10, color: AppTheme.commonTextColorSecondery),
                            SizedBox(width: 60),
                            TextWidget.label("24h成交量", size: 10, color: AppTheme.commonTextColorSecondery),
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
