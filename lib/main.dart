import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:flutter_24coin/config/env.dart';
import 'package:flutter_24coin/global.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemStyle();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // splitScreenMode: false, // 支持分屏尺寸
      // minTextAdapt: false, // 是否根据宽度/高度中的最小值适配文字);
      builder: (context, child) {
        return AdaptiveTheme(
          light: AppTheme.light, // 亮色主题
          dark: AppTheme.dark, // 暗色主题
          initial: ConfigService.to.themeMode,
          debugShowFloatingThemeButton: true, // 显示主题按钮
          builder: (ThemeData light, ThemeData dark) {
            return GetMaterialApp(
              builder: FlutterSmartDialog.init(),
              title: AppEnvironment.appName,
              theme: light,
              darkTheme: dark,
              // 多语言
              translations: Translation(), // 词典
              localizationsDelegates: Translation.localizationsDelegates, // 代理
              supportedLocales: Translation.supportedLocales, // 支持的语言种类
              locale: ConfigService.to.locale, // 当前语言种类
              fallbackLocale: Translation.fallbackLocale, // 默认语言种类
              initialRoute: RouteNames.systemSplash, // 初始路由
              getPages: RoutePages.list, // 路由列表
              debugShowCheckedModeBanner: AppEnvironment.debugMode, // 根据环境显示debug标志
            );
          },
        );
      },
    );
  }
}
