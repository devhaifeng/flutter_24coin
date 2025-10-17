class CoinWalletIndexData {
  int? balance;
  int? rateCny;
  String? address;
  int? type;
  int? change;

  CoinWalletIndexData({this.balance, this.rateCny, this.address, this.type, this.change});

  factory CoinWalletIndexData.fromJson(Map<String, dynamic> json) {
    return CoinWalletIndexData(
      balance: json['balance'] as int?,
      rateCny: json['rateCny'] as int?,
      address: json['address'] as String?,
      type: json['type'] as int?,
      change: json['change'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'balance': balance,
    'rateCny': rateCny,
    'address': address,
    'type': type,
    'change': change,
  };
}
