class CoinBalanceData {
  int? balance;
  int? betBalance;
  int? usdt;

  CoinBalanceData({this.balance, this.betBalance, this.usdt});

  factory CoinBalanceData.fromJson(Map<String, dynamic> json) {
    return CoinBalanceData(
      balance: json['balance'] as int?,
      betBalance: json['betBalance'] as int?,
      usdt: json['usdt'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {'balance': balance, 'betBalance': betBalance, 'usdt': usdt};
}
