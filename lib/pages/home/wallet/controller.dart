import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/api/wallet.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../common/models/result/wallet/coin_socket_model/drate.dart';

class WebSocketToken {
  String token;
  WebSocketToken({required this.token});
  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}

class WalletController extends GetxController with GetSingleTickerProviderStateMixin {
  WalletController();
  final Uuid uuid = const Uuid();
  String generatedUUID = '';
  late TabController tabController;
  late WebSocketService webSocketService;
  final ScrollController scrollController = ScrollController();
  List<ItemEntity>? hotList = [];
  List<ItemEntity>? drateList = [];
  List<ItemEntity>? irateList = [];
  List<ItemEntity>? dealList = [];
  List<CoinNewsListData>? coinNewsList = [];
  List<CoinAllowData>? allowedCoinList = [];
  List<CoinWalletShow>? walletBalanceList = [];
  CoinWalletIndexData? walletIndexData;
  CoinBalanceData? mCoinBalanceData;
  late int? lastCoinType = 3;

  ///资讯
  int startPage = -50;
  int endPage = -1;

  // 发送消息
  void sendMessage() {
    final request = WebSocketToken(token: Constants.wsToken);
    webSocketService.send(jsonEncode(request.toJson()));
  }

  void onTap() {}

  @override
  void onInit() async {
    String? coinList = Storage().getString(SPConstants.storageCoinType);
    if (coinList.isNotEmpty) {
      List<dynamic> jsonData = jsonDecode(coinList);
      allowedCoinList = jsonData.map((e) => CoinAllowData.fromJson(e)).toList();
      for (var element in allowedCoinList!) {
        if (element.isSelected == true) {
          lastCoinType = element.value;
        }
      }
    }
    requestAllowedCoinList();
    requestWallBalanceData();
    requestCoinBalanceData();
    generatedUUID = uuid.v4().replaceAll('-', '');
    tabController = TabController(length: 5, vsync: this);
    initSocketService();
    webSocketService.connect();
    super.onInit();
  }

  ///初始化 WebSocket 服务
  void initSocketService() {
    webSocketService = WebSocketService(
      url: 'ws://dctools.24pay01.cn/ws/rank/$generatedUUID',
      onMessage: (message) {
        // 处理接收到的消息
        if (message.contains('DRATE')) {
          final data = jsonDecode(message);
          final model = CoinSocketDrateModel.fromJson(data);
          drateList = model.list;
        }
        if (message.contains('IRATE')) {
          final data = jsonDecode(message);
          final model = CoinSocketIrateModel.fromJson(data);
          irateList = model.drate;
        }
        if (message.contains('HOT')) {
          final data = jsonDecode(message);
          final model = CoinSocketHotModel.fromJson(data);
          hotList = model.drate;
        }
        if (message.contains('DEAL')) {
          final data = jsonDecode(message);
          final model = CoinSocketDealModel.fromJson(data);
          dealList = model.drate;
        }
        update(['wallet']);
      },
      onConnected: () {
        sendMessage();
      },
      onDisconnected: () {
        webSocketService.connect();
      },
    );
  }

  ///获取资讯信息
  Future<void> requestCoinNews() async {
    CoinNewsResponse model = await WalletApi.getWalletNews(startPage, endPage);
    List<CoinNewsFormat> list = [];
    model.data?.data?.forEach((element) {
      CoinNewsFormat item = CoinNewsFormat(datum: element, timestamp: element.timestamp ?? 0);
      list.add(item);
    });
    // 使用
    var groupedItems = groupItemsByDay(list);
    coinNewsList?.clear();
    groupedItems.forEach((key, value) {
      CoinNewsListData item = CoinNewsListData(
        date: DateFormat('yyyy年MM月dd日').format(key),
        data: value.map((e) => e.datum!).toList(),
      );
      coinNewsList?.add(item);
    });
    update(["wallet"]);
  }

  /// 将数据按天分组
  Map<DateTime, List<CoinNewsFormat>> groupItemsByDay(List<CoinNewsFormat> items) {
    Map<DateTime, List<CoinNewsFormat>> groupedMap = {};
    for (var item in items) {
      // 获取日期（不含时间部分）
      final day = DateTime(item.date.year, item.date.month, item.date.day);
      groupedMap.putIfAbsent(day, () => []).add(item);
    }
    return groupedMap;
  }

  Future<void> requestWallBalanceData() async {
    int coinType = 3;
    if (allowedCoinList != null && allowedCoinList!.isNotEmpty) {
      coinType =
          allowedCoinList!.firstWhere((element) => element.isSelected == true, orElse: () => CoinAllowData()).value ??
          3;
    }
    BaseResponse<CoinWalletIndexData> response = await WalletApi.getHomeWalletData(coinType);
    walletIndexData = response.data!;
    update(["wallet"]);
  }

  Future<void> requestCoinBalanceData() async {
    BaseResponse<CoinBalanceData> response = await WalletApi.getCoinBalanceList();
    mCoinBalanceData = response.data;
    print('余额数据===>${mCoinBalanceData?.toJson()}');
    BaseListResponse<CoinWalletShow> coinWalletShow = await WalletApi.getWalletCoinShow();
    walletBalanceList = coinWalletShow.data;
    walletBalanceList?.forEach((element) {
      print("展示币种 ${element.toJson()}");
    });
    update(["wallet"]);
  }

  /// 获取允许的币种列表
  Future<void> requestAllowedCoinList() async {
    BaseListResponse<CoinAllowData> model = await WalletApi.getAllowedCoinList();
    allowedCoinList?.clear();
    allowedCoinList?.addAll(model.data ?? []);
    allowedCoinList?.add(CoinAllowData(value: 2, appDisplay: 'USDT(ERC20)', isSelected: false));
    allowedCoinList?.forEach((element) {
      switch (element.value) {
        case 1:
          element.isSelected = lastCoinType == 1;
          element.assetsPath = AssetsSvgs.iconWalletTrcCoinSvg;
          break;
        case 2:
          element.isSelected = lastCoinType == 2;
          element.assetsPath = AssetsSvgs.iconWalletErcCoinSvg;
          break;
        case 3:
          element.isSelected = lastCoinType == 3;
          element.assetsPath = AssetsImages.iconWalletCoinPng;
          break;
        case 4:
          element.isSelected = lastCoinType == 4;
          element.assetsPath = AssetsImages.iconWalletCoin2Png;
          break;
      }
    });
    Storage().setString(SPConstants.storageCoinType, jsonEncode(allowedCoinList));
    requestWallBalanceData();
  }

  @override
  void onReady() {
    super.onReady();
    requestCoinNews();
  }

  @override
  void onClose() {
    webSocketService.disconnect();
    tabController.dispose();
    scrollController.dispose();
  }

  /// 选择币种
  void onSelectorCoinChanged(CoinAllowData? value) {
    if (allowedCoinList != null && allowedCoinList!.isNotEmpty) {
      for (var element in allowedCoinList!) {
        element.isSelected = false;
        if (element.value == value?.value) {
          element.isSelected = true;
        }
      }
      Storage().setString(SPConstants.storageCoinType, jsonEncode(allowedCoinList));
      requestWallBalanceData();
      update(['wallet']);
    }
  }
}
