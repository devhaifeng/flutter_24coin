import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DeviceInfo {
  /// 获取设备信息
  Future<String> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.model; // 例如 "Pixel 3a"
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.utsname.machine; // 例如 "iPhone13,4"
        // 可选：将机器码转换为用户友好名称（如 "iPhone 12 Pro"）
      } else if (Platform.isWindows) {
        return (await deviceInfo.windowsInfo).deviceId;
      } else {
        return "Unsupported Platform";
      }
    } catch (e) {
      return "Unknown Device";
    }
  }

  ///获取IP
  Future<String> getIpAddress() async {
    final NetworkInfo info = NetworkInfo();
    try {
      // 获取 WiFi IP (Android/iOS通用)
      String? ip = await info.getWifiIP();
      // 备用方案：获取所有IP (方法取决于平台)
      ip ??= await (Platform.isAndroid ? info.getWifiIP() : info.getWifiIP());
      return ip ?? 'Unknown IP';
    } catch (e) {
      return 'Failed to get IP';
    }
  }
}
