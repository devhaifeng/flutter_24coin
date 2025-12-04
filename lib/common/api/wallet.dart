import 'package:flutter_24coin/common/index.dart';

class WalletApi {
  ///获取钱包资讯
  static Future<CoinNewsResponse> getWalletNews(int startPage, int endPage) async {
    var request = CoinNewsRequest(start: startPage, end: endPage);
    final response = await CoinHttpService.to.post('/slug/api/getFastNewsData', data: request);
    return CoinNewsResponse.fromJson(response.data);
  }

  ///获取币种列表
  static Future<BaseListResponse<CoinAllowData>> getAllowedCoinList() async {
    final response = await WPHttpService.to.post('/dc/wallet/coin/list');
    return BaseListResponse<CoinAllowData>.fromJson(response.data, (data) => CoinAllowData.fromJson(data));
  }

  ///首页钱包数据
  static Future<BaseResponse<CoinWalletIndexData>> getHomeWalletData(int type) async {
    CoinWalletIndexRequest request = CoinWalletIndexRequest(type: type);
    final response = await WPHttpService.to.post('/dc/wallet/index', data: request);
    return BaseResponse<CoinWalletIndexData>.fromJson(response.data, (data) => CoinWalletIndexData.fromJson(data));
  }

  ///获取币种余额
  static Future<BaseResponse<CoinBalanceData>> getCoinBalanceList() async {
    final response = await WPHttpService.to.post('/dc/wallet/get/balance/all');
    return BaseResponse<CoinBalanceData>.fromJson(response.data, (data) => CoinBalanceData.fromJson(data));
  }

  ///获取当前用户展示的大类币种
  static Future<BaseListResponse<CoinWalletShow>> getWalletCoinShow() async {
    final response = await WPHttpService.to.post('/dc/wallet/get/coin/show');
    return BaseListResponse<CoinWalletShow>.fromJson(response.data, (data) => CoinWalletShow.fromJson(data));
  }

  ///获取币种地址 转化成二维码
  static Future<BaseResponse<String>> getWalletCoinAddress(int type) async {
    CoinWalletIndexRequest request = CoinWalletIndexRequest(type: type);
    final response = await WPHttpService.to.post('/dc/wallet/exist/addr', data: request);
    return BaseResponse<String>.fromJson(response.data, (data) => data);
  }
}
