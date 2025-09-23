import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

/// 主题
class AppTheme {
  /////////////////////////////////////////////////
  /// 自定义颜色
  /////////////////////////////////////////////////

  static const primary = Color(0XFF18A5F1); // 主色
  static const secondary = Color(0xFFF5F5F5); // 辅助色
  static const success = Color(0xff13BD57); // 成功色
  static const warning = Color(0xFFFFBF00); // 警告色
  static const error = Color(0xffF25644); // 错误色
  static const info = Color(0xFF8C99A5); // 信息色

  static const background = Color(0xFFF5F5F5); // 背景色

  static var commonTextColor =
      Get.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF333333); // 主色上的文字颜色

  static var commonTextColorSecondery = Color(0xFF8C99A5); // 通用次要文字颜色
  var commonDividerColor =
      Get.isDarkMode ? Color(0xFF28343F) : Color(0xFFEEEEEE);

  /// 主色按下颜色
  static var commonPrimaryPressColor = Color(0XB318A5F1);
  static var commonSufaceColor =
      Get.isDarkMode ? Color(0xff19232C) : Color(0xFFFFFFFF);

  /////////////////////////////////////////////////
  /// 系统样式
  /////////////////////////////////////////////////

  /// 系统样式
  static SystemUiOverlayStyle get systemStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 状态栏颜色
    statusBarBrightness: Brightness.light, // 状态栏亮度
    statusBarIconBrightness: Brightness.dark, // 状态栏图标亮度
    systemNavigationBarDividerColor: Colors.transparent, // 系统导航栏分隔线颜色
    systemNavigationBarColor: Colors.white, // 系统导航栏颜色
    systemNavigationBarIconBrightness: Brightness.dark, // 系统导航栏图标亮度
  );

  /// 亮色系统样式
  static SystemUiOverlayStyle get systemStyleLight => systemStyle.copyWith(
    statusBarColor: Colors.transparent, // 状态栏颜色
    statusBarBrightness: Brightness.light, // 状态栏亮度
    statusBarIconBrightness: Brightness.dark, // 状态栏图标亮度
    systemNavigationBarIconBrightness: Brightness.dark, // 系统导航栏图标亮度
  );

  /// 暗色系统样式
  static SystemUiOverlayStyle get systemStyleDark => systemStyle.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark, // 状态栏亮度
    statusBarIconBrightness: Brightness.light, // 状态栏图标亮度
    systemNavigationBarIconBrightness: Brightness.light, // 系统导航栏图标亮度
  );

  static void setSystemStyle() {
    // 获取系统亮度
    Brightness platformBrightness =
        Get.context?.theme.brightness ?? Brightness.light;

    // 获取当前模式
    ThemeMode mode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

    switch (mode) {
      case ThemeMode.system:
        if (platformBrightness == Brightness.dark) {
          // 暗色模式
          SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
        } else {
          // 亮色模式
          SystemChrome.setSystemUIOverlayStyle(systemStyleLight);
        }
        break;
      case ThemeMode.light:
        // 亮色模式
        SystemChrome.setSystemUIOverlayStyle(systemStyleLight);
        break;
      case ThemeMode.dark:
        // 暗色模式
        SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
        break;
    }
  }

  /////////////////////////////////////////////////
  /// 主题
  /////////////////////////////////////////////////

  /// 亮色主题
  static ThemeData get light {
    ColorScheme scheme = MaterialTheme.lightScheme().copyWith(primary: primary);
    return _getTheme(scheme);
  }

  /// 暗色主题
  static ThemeData get dark {
    ColorScheme scheme = MaterialTheme.darkScheme().copyWith(primary: primary);
    return _getTheme(scheme);
  }

  /// 获取主题
  static ThemeData _getTheme(ColorScheme scheme) {
    return ThemeData(
      splashColor: Colors.transparent, // 加一点透明度通常更好看
      highlightColor:
          scheme.brightness == Brightness.light
              ? Color(0xFFE1DFDF)
              : Color(0xFF28343F),
      hoverColor:
          scheme.brightness == Brightness.light
              ? Color(0xFFE1DFDF)
              : Color(0xFF28343F),
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: "Montserrat", // 字体
      // 导航栏
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surfaceDim, // 背景色
        scrolledUnderElevation: 0, // 滚动阴影
        elevation: 0, // 阴影
        centerTitle: true, // 标题居中
        toolbarHeight: 56.w, // 高度
        iconTheme: IconThemeData(
          color: scheme.onSurface, // 图标颜色
          size: 22.w, // 图标大小
        ),
        titleTextStyle: TextStyle(
          color: scheme.onSurface, // 字体颜色
          fontSize: 24.w, // 字体大小
          fontWeight: FontWeight.w600, // 字体粗细
          height: 1.2, // 行高
        ),
        toolbarTextStyle: TextStyle(
          color: scheme.onSurface, // 字体颜色
          fontSize: 22.w, // 字体大小
          fontWeight: FontWeight.w600, // 字体粗细
          height: 1.2, // 行高
        ),
      ),
    );
  }
}
