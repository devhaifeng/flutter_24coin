import 'data.dart';

class CoinNewsResponse {
  Data? data;
  String? msg;
  int? code;

  CoinNewsResponse({this.data, this.msg, this.code});

  factory CoinNewsResponse.fromJson(Map<String, dynamic> json) {
    return CoinNewsResponse(
      data: json['data'] == null ? null : Data.fromJson(json['data'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'msg': msg, 'code': code};
}
