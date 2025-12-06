import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  ///是否记住密码
  bool isRememberPassword = Storage().getBool(SPConstants.isRememberPwd);

  ///是否允许登录
  bool isLoginButtonEnabled = false;

  ///密码登录
  bool currentLoginByPassword = true;

  ///手机号
  TextEditingController mPhoneController = TextEditingController();

  ///密码
  TextEditingController mPasswordController = TextEditingController();

  ///当前国家手机号
  String? currentCountryCode = "+86";

  ///国家列表
  List<CountryCodeModel> countryCodes = [];

  ///短信倒计时
  bool isCounting = false;

  /// 是否正在倒计时
  int remainingSeconds = 60;

  /// 剩余秒数
  Timer? _timer;

  ///线路列表
  List<AppNetLineData> netLines = [];

  ///线路刷新旋转动画
  late AnimationController refreshNetController;

  LoginController();

  _initData() {
    requestCountryCode();
    mPhoneController.text = UserService.to.getPhoneNumber();
    mPasswordController.text = UserService.to.getPassword();
    isLoginButtonEnabled = mPhoneController.text.isNotEmpty && mPasswordController.text.isNotEmpty;
    update(["login"]);
  }

  void stopRefreshNetAnimation() {
    if (refreshNetController.isAnimating) {
      refreshNetController.stop();
    }
  }

  @override
  void onInit() {
    refreshNetController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    testNetLineDelay();
    super.onInit();
  }

  void onBack() {
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  /// 测试网络延迟
  void testNetLineDelay() async {
    refreshNetController.repeat();
    String lastNet = Storage().getString(SPConstants.storageNetLine);
    if (netLines.isEmpty) {
      /// 初始化线路列表
      for (int i = 0; i < Constants.netLineList.length; i++) {
        netLines.add(
          AppNetLineData(
            Constants.netLineList[i],
            show: "线路 ${i + 1}",
            delay: null,
            isChecked: lastNet.isEmpty ? i == 0 : Constants.netLineList[i] == lastNet,
            textColor: getDelayColor(0),
          ),
        );
      }
    } else {
      for (var line in netLines) {
        line.delay = null;
        line.textColor = getDelayColor(0);
      }
      update(["check_net_line"]);
    }

    // 并行检测所有BaseUrl
    await Future.wait(
      Constants.netLineList.map((url) async {
        try {
          int latency = await measureBaseUrlLatency(url: url);
          netLines.firstWhere((line) => line.url == url).delay = latency;
          netLines.firstWhere((line) => line.url == url).textColor = getDelayColor(latency);
        } catch (e) {
          netLines.firstWhere((line) => line.url == url).delay = -1;
          netLines.firstWhere((line) => line.url == url).textColor = getDelayColor(-1);
        }
      }),
    );
    stopRefreshNetAnimation();
    update(["check_net_line"]);
  }

  void setRememberPassword(bool value) {
    isRememberPassword = value;
    update(["login"]);
  }

  /// 切换登录方式
  void changeLoginWays() {
    currentLoginByPassword = !currentLoginByPassword;
    update(["login"]);
  }

  /// 登录
  Future<void> login() async {
    String phone = mPhoneController.text.trim();
    String password = mPasswordController.text.trim();
    BaseResponse<UserModel> model = await UserApi.login(phone, password);
    if (model.code == Constants.successCode) {
      /// 登录成功，保存用户信息
      /// 保存用户令牌
      await UserService.to.setToken(model.data?.token ?? '');
      Storage().setString(SPConstants.phoneNumber, phone);

      /// 保存用户信息
      if (isRememberPassword) {
        Storage().setString(SPConstants.storagePassword, password);
      } else {
        Storage().remove(SPConstants.storagePassword);
      }
      Storage().setBool(SPConstants.isRememberPwd, isRememberPassword);
      Get.toNamed(RouteNames.systemMain);
    } else if (model.code == 202) {
      ///限制登录
    } else {
      print("登录失败: ${model.msg}");
    }
  }

  ///前往注册
  void register() {
    Get.toNamed(RouteNames.systemRegister);
  }

  ///请求手机验证码
  void requestPhoneCode() {}

  Future<void> requestCountryCode() async {
    BaseListResponse<CountryCodeModel> model = await UserApi.getCountryCode();
    countryCodes = model.data ?? [];
  }

  ///选择国家国旗
  String selectCountryFlag(String countryCode) {
    String flagCountry = ""; // Default to China
    switch (countryCode) {
      case "86":
        flagCountry = AssetsImages.iconCountryChinaPng;
        break;
      case "852":
        flagCountry = AssetsImages.iconCountryHongkongPng;
        break;
      case "1":
        flagCountry = AssetsImages.iconCountryUsaPng;
        break;
      case "63":
        flagCountry = AssetsImages.iconCountryPhilippinesPng;
        break;
      case "971":
        flagCountry = AssetsImages.iconCountryUnitedArabEmiratesPng;
        break;
      case "62":
        flagCountry = AssetsImages.iconCountryIndonesiaPng;
        break;
      case "66":
        flagCountry = AssetsImages.iconCountryThailandPng;
        break;
      case "856":
        flagCountry = AssetsImages.iconCountryLaosPng;
        break;
      case "82":
        flagCountry = AssetsImages.iconCountryMacaoPng;
        break;
      case "60":
        flagCountry = AssetsImages.iconCountryMalaysiaPng;
        break;
      case "855":
        flagCountry = AssetsSvgs.iconCountryCambodiaSvg;
        break;
      case "65":
        flagCountry = AssetsSvgs.iconCountrySingaporeSvg;
        break;
      case "91":
        flagCountry = AssetsSvgs.iconCountryIndiaSvg;
        break;
      case "880":
        flagCountry = AssetsSvgs.iconCountryBengalSvg;
        break;
      case "92":
        flagCountry = AssetsSvgs.iconCountyPakistanSvg;
        break;
      case "886":
        flagCountry = AssetsSvgs.iconCountryTaiwanSvg;
        break;
      case "853":
        flagCountry = AssetsImages.iconCountryMacaoPng;
        break;
      case "81":
        flagCountry = AssetsSvgs.iconCountryJapanSvg;
        break;
      case "955":
        flagCountry = AssetsSvgs.iconCountryGeorgiaSvg;
        break;

      default:
        flagCountry = AssetsImages.iconCountryChinaPng;
    }
    return flagCountry;
  }

  // 开始倒计时
  void startCountdown() {
    // 如果已经在倒计时中，则返回
    if (mPhoneController.text.isEmpty) return;
    if (isCounting) return;
    isCounting = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 1) {
        // 倒计时结束
        _stopCountdown();
        return;
      }
      remainingSeconds--;
      update(["login"]); // 更新UI
    });
  }

  // 停止倒计时
  void _stopCountdown() {
    _timer?.cancel();
    remainingSeconds = 60;
    isCounting = false;
    update(["login"]); // 更新
  }

  // 选择国家代码
  Future<void> selectCountryCode() async {
    if (countryCodes.isNotEmpty) {
      final result = await Get.toNamed(RouteNames.systemCountryCode, arguments: {"countryCodes": countryCodes});
      currentCountryCode = result ?? "+86"; // 默认中国
      update(["login"]);
    }
  }

  void setCurrentNetLine(int index) {
    String selectedNet = netLines[index].url;
    Storage().setString(SPConstants.storageNetLine, selectedNet);
    for (int i = 0; i < netLines.length; i++) {
      netLines[i].isChecked = i == index;
      update(["check_net_line"]);
    }
  }

  /// 检测BaseUrl的延迟
  /// [url]: 要检测的BaseUrl（如：https://api.example.com/）
  /// [maxRetry]: 最大重试次数（默认3次）
  /// [timeout]: 超时时间（默认5秒）
  Future<int> measureBaseUrlLatency({
    required String url,
    int maxRetry = 3,
    Duration timeout = const Duration(seconds: 5),
  }) async {
    int retryCount = 0;
    final client = http.Client();
    final stopwatch = Stopwatch();
    List<int> latencies = [];

    try {
      // 确保URL以斜杠结尾，否则可能返回301
      if (!url.endsWith('/')) url += '/';

      while (retryCount < maxRetry) {
        try {
          // 创建超时保护
          await Future.delayed(Duration(milliseconds: 100 * retryCount)); // 退避策略
          stopwatch.start();

          final response = await client
              .head(Uri.parse(url))
              .timeout(timeout, onTimeout: () => throw TimeoutException('请求超时'));

          stopwatch.stop();
          if (response.statusCode < 400) {
            latencies.add(stopwatch.elapsedMilliseconds);
          } else {
            throw http.ClientException('HTTP ${response.statusCode} ${response.reasonPhrase}');
          }
        } on TimeoutException catch (_) {
          latencies.add(timeout.inMilliseconds); // 记录超时值
        } finally {
          stopwatch.reset();
          retryCount++;
        }
      }

      // 计算中位数减少异常值干扰
      latencies.sort();
      final medianLatency = latencies[latencies.length ~/ 2];
      return medianLatency;
    } finally {
      client.close();
    }
  }

  Color getDelayColor(int? delay) {
    if (delay == null) {
      return AppTheme.info; // 检测中
    } else if (delay == 0) {
      return AppTheme.info; // 不可用
    } else if (delay == -1) {
      return AppTheme.error; // 不可用
    } else {
      if (delay < 200) {
        return AppTheme.success; // 200ms以下
      } else if (delay > 200) {
        return AppTheme.warning; // 200ms以上
      }
    }
    return AppTheme.info; // 200ms以下
  }

  // 组件销毁时取消计时器
  @override
  void onClose() {
    mPhoneController.dispose();
    _timer?.cancel();
    refreshNetController.dispose();
    mPasswordController.dispose();
    super.onClose();
  }
}

///选择国家语言
class LanguageController extends GetxController {
  LanguageController();

  ///是否记住密码
  bool isChinese = ConfigService.to.locale.languageCode == 'zh';

  ///是否允许登录
  bool isEnglish = ConfigService.to.locale.languageCode == 'en';

  ///密码登录
  bool isVi = ConfigService.to.locale.languageCode == 'zh';

  ///是否显示国家选择对话框
  bool isShowCountryDialog = false;

  void setLanguarge(int index, BuildContext context) {
    switch (index) {
      case 0:
        isChinese = true;
        isEnglish = false;
        isVi = false;
        ConfigService.to.setLanguage(Locale('zh', 'CN'));
        break;
      case 1:
        isChinese = false;
        isEnglish = true;
        isVi = false;
        ConfigService.to.setLanguage(Locale('en', 'US'));
        break;
      case 2:
        isChinese = false;
        isEnglish = false;
        isVi = true;
        ConfigService.to.setLanguage(Locale('zh', 'CN'));
        break;
      default:
        isChinese = true;
        isEnglish = false;
        isVi = false;
    }
    Navigator.pop(context); // 关闭对话框
    update(["language_dialog"]);
  }

  ///显示国家选择对话框
  void showCountryDialog() {
    isShowCountryDialog = true;
    update(["language_dialog"]);
  }

  ///隐藏国家选择对话框
  void hideCountryDialog() {
    isShowCountryDialog = false;
    update(["language_dialog"]);
  }
}
