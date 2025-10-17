class CoinWalletShow {
  final int? value;
  final String? desc;

  CoinWalletShow({this.value, this.desc});

  factory CoinWalletShow.fromJson(Map<String, dynamic> json) {
    return CoinWalletShow(value: json['value'] as int?, desc: json['desc'] as String?);
  }

  Map<String, dynamic> toJson() => {'value': value, 'desc': desc};
}
