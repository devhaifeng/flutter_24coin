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
    print('获取允许的币种列表响应: ${response.data}');
    return BaseListResponse<CoinAllowData>.fromJson(response.data, (data) => CoinAllowData.fromJson(data));
  }
}
