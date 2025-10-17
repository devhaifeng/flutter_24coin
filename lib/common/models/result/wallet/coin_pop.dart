class CoinAllowData {
  final int? value;
  final String? appDisplay;
  String? assetsPath;
  bool? isSelected = false;

  CoinAllowData({
    this.value,
    this.appDisplay,
    this.assetsPath,
    this.isSelected,
  });
  factory CoinAllowData.fromJson(Map<String, dynamic> json) {
    return CoinAllowData(
      value: json['value'] as int?,
      appDisplay: json['appDisplay'] as String?,
      assetsPath: json['assetsPath'] as String?,
      isSelected: json['isSelected'] as bool?,
    );
  }
  Map<String, dynamic> toJson() => {
    'value': value,
    'appDisplay': appDisplay,
    'assetsPath': assetsPath,
    'isSelected': isSelected,
  };
}
