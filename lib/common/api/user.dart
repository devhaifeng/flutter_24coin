import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:uuid/uuid.dart';

class UserApi {
  /// 获取国家代码列表
  static Future<BaseListResponse<CountryCodeModel>> getCountryCode() async {
    final response = await WPHttpService.to.post('/tools/sms/intl');
    return BaseListResponse<CountryCodeModel>.fromJson(
      response.data,
      (data) => CountryCodeModel.fromJson(data),
    );
  }

  ///登录
  static Future<BaseResponse<UserModel>> login(
    String phone,
    String password,
  ) async {
    String deviceId = '';
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? Uuid().v4();
    }
    UserLoginReq? req = UserLoginReq(
      phoneNo: phone,
      password: password,
      ip: await DeviceInfo().getIpAddress(),
      deviceInfo: await DeviceInfo().getDeviceModel(),
      uuid: deviceId,
    );
    final response = await WPHttpService.to.post(
      '/user/loginPassword',
      data: req,
    );
    return BaseResponse<UserModel>.fromJson(
      response.data,
      (data) => UserModel.fromJson(data),
    );
  }
}
