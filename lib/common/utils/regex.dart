class Reguix {
  // 验证手机号
  static bool isPhone(String input) {
    final phoneReg = RegExp(r'^(?:[+0]9)?[0-9]{10,12}$');
    return phoneReg.hasMatch(input);
  }

  // 验证邮箱
  static bool isEmail(String input) {
    final emailReg = RegExp(
      r'^[a-zA-Z0-9]+([._\\-]*[a-zA-Z0-9])*@([a-zA-Z0-9]+[-a-zA-Z0-9]*[a-zA-Z0-9]+\.){1,63}[a-zA-Z0-9]+$',
    );
    return emailReg.hasMatch(input);
  }

  // 验证是否为正数（包括整数和浮点数）
  static bool isPositiveNumber(String input) {
    // 先尝试判断是否为整数（正整数）
    if (RegExp(r'^[1-9]\d*$').hasMatch(input)) {
      return true;
    }
    // 判断是否为浮点数（正浮点数）
    if (RegExp(r'^[1-9]\d*\.\d+$').hasMatch(input) || RegExp(r'^0\.\d*[1-9]\d*$').hasMatch(input)) {
      return true;
    }
    return false;
  }

  static String formatNumberWithUnit(double value, {bool isChinese = true}) {
    // 亿/亿单位 (100,000,000)
    if (value >= 100000000) {
      final formattedValue = (value / 100000000).toStringAsFixed(2);
      final unit = isChinese ? "亿" : "B"; // Billion
      return '$formattedValue$unit';
    }

    // 万/万单位 (10,000)
    if (value >= 10000) {
      final formattedValue = (value / 10000).toStringAsFixed(2);
      final unit = isChinese ? "万" : "W";
      return '$formattedValue$unit';
    }

    // 千/千单位 (1,000)
    if (value >= 1000) {
      final formattedValue = (value / 1000).toStringAsFixed(2);
      final unit = isChinese ? "千" : "K";
      return '$formattedValue$unit';
    }

    // 默认情况：保留两位小数
    return value.toStringAsFixed(2);
  }
}

String formatNumber(num number) {
  // 首先固定为两位小数，它会进行四舍五入[4](@ref)
  String result = number.toStringAsFixed(2);
  // 检查小数部分是否为 ".00"
  if (result.endsWith('.00')) {
    return result.split('.')[0]; // 返回整数部分
  } else if (result.endsWith('0')) {
    // 如果只有一位小数且是0，例如 "9.50" 变为 "9.5"
    return result.substring(0, result.length - 1);
  }
  return result;
}
