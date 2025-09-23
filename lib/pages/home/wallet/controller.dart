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

  ///资讯
  int startPage = -50;
  int endPage = -1;
  _initData() {
    update(["wallet"]);
  }

  // 发送消息
  void sendMessage() {
    final request = WebSocketToken(token: Constants.wsToken);
    webSocketService.send(jsonEncode(request.toJson()));
  }

  void onTap() {}

  @override
  void onInit() async {
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
  Future<void> requestCountryCode() async {
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

  /// 获取允许的币种列表
  Future<void> getAllowedCoinList() async {
    BaseListResponse<CoinAllowData> model = await WalletApi.getAllowedCoinList();
    allowedCoinList?.addAll(model.data ?? []);
    // 处理 model 数据
    update(["wallet"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
    requestCountryCode();
    getAllowedCoinList();
  }

  @override
  void onClose() {
    webSocketService.disconnect();
    tabController.dispose();
    scrollController.dispose();
  }
}
