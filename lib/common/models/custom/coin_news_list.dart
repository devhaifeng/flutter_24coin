import 'package:flutter_24coin/common/index.dart';

class CoinNewsFormat {
  final Datum? datum;

  final int? timestamp;

  // 将时间戳转换为 DateTime 对象，并提取日期（年-月-日）
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp!);
  CoinNewsFormat({this.datum, this.timestamp});

  Map<String, dynamic> toJson() => {'datum': datum?.toJson(), 'timestamp': timestamp};

  factory CoinNewsFormat.fromJson(Map<String, dynamic> json) {
    return CoinNewsFormat(
      datum: json['datum'] == null ? null : Datum.fromJson(json['datum'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );
  }
}

class CoinNewsListData {
  String? date;
  List<Datum>? data;

  CoinNewsListData({this.date, this.data});

  Map<String, dynamic> toJson() => {'date': date, 'data': data?.map((e) => e.toJson()).toList()};

  factory CoinNewsListData.fromJson(Map<String, dynamic> json) {
    return CoinNewsListData(
      date: json['date'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => Datum.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
