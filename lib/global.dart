import 'package:flutter/widgets.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:flutter_24coin/common/services/wp_http.dart';
import 'package:get/instance_manager.dart';

class Global {
  static Future<void> init() async {
    // Initialize global variables or services here
    WidgetsFlutterBinding.ensureInitialized();
    // 工具类
    await Storage().init();
    Get.put<ConfigService>(ConfigService()); // 配置
    Get.put<WPHttpService>(WPHttpService()); // 网络
    Get.put<CoinHttpService>(CoinHttpService()); // 网络
    Get.put<UserService>(UserService()); // 网络
    // 初始化配置
    await ConfigService.to.init();
  }
}
