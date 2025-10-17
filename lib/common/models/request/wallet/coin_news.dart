import 'package:flutter_24coin/common/index.dart';

class CoinNewsRequest {
  int start;
  int end;
  String token;

  CoinNewsRequest({this.start = -50, this.end = -1, this.token = Constants.wsToken});

  Map<String, dynamic> toJson() => {'start': start, 'end': end, 'token': token};
}

class CoinWalletIndexRequest {
  int type;
  CoinWalletIndexRequest({required this.type});
  Map<String, dynamic> toJson() => {'type': type};
}
