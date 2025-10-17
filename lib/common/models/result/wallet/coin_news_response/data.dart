import 'datum.dart';

class Data {
  int? total;
  List<Datum>? data;

  Data({this.total, this.data});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json['total'] as int?,
    data:
        (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

/// 提供给前端展示的新闻数据
class CoinNewsData {
  String? date;
  List<Datum>? data;

  CoinNewsData({this.date, this.data});

  factory CoinNewsData.fromJson(Map<String, dynamic> json) => CoinNewsData(
    date: json['date'] as String?,
    data:
        (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
