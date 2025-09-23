class CoinAllowData {
  final int? value;
  final String? appDisplay;
  bool? isSelected;

  CoinAllowData({this.value, this.appDisplay, this.isSelected = false});

  factory CoinAllowData.fromJson(Map<String, dynamic> json) {
    return CoinAllowData(
      value: json['value'] as int?,
      appDisplay: json['appDisplay'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'appDisplay': appDisplay, 'isSelected': isSelected};
  }
}
