import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigService extends GetxService {
  //单例
  static ConfigService get to => Get.find();

  //获取当前版本信息
  PackageInfo? _platform;
  String get version => _platform?.version ?? '-';

  // 主题
  AdaptiveThemeMode themeMode = AdaptiveThemeMode.light;

  // 获取当前语言
  // 多语言
  Locale locale = PlatformDispatcher.instance.locale;

  // 初始化
  Future<ConfigService> init() async {
    await getPlatform();
    await initTheme();
    initLocale();
    return this;
  }

  // 获取平台信息
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // 初始语言
  void initLocale() {
    var langCode = Storage().getString(SPConstants.storageLanguageCode);
    if (langCode.isEmpty) return;
    var index = Translation.supportedLocales.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = Translation.supportedLocales[index];
  }

  // 更改语言
  void setLanguage(Locale value) {
    locale = value;
    Get.updateLocale(value);
    Storage().setString(SPConstants.storageLanguageCode, value.languageCode);
  }

  // 初始 theme
  Future<void> initTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    themeMode = savedThemeMode ?? AdaptiveThemeMode.light;
  }

  // 切换 theme
  Future<void> setThemeMode(String themeKey) async {
    switch (themeKey) {
      case "light":
        AdaptiveTheme.of(Get.context!).setLight();
        break;
      case "dark":
        AdaptiveTheme.of(Get.context!).setDark();
        break;
      case "system":
        AdaptiveTheme.of(Get.context!).setSystem();
        break;
    }

    // 设置系统样式
    AppTheme.setSystemStyle();
  }

  // 切换主题
  void switchThemeMode() {
    // 品乓方式切换
    themeMode =
        themeMode == AdaptiveThemeMode.light
            ? AdaptiveThemeMode.dark
            : AdaptiveThemeMode.light;

    setThemeMode(themeMode.name);
  }

  // 标记已打开app
  void setAlreadyOpen() {
    Storage().setBool(SPConstants.storageAlreadyOpen, true);
  }
}
