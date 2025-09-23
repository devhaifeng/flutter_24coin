import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RegisterController();

  ///手机号
  TextEditingController mPhoneController = TextEditingController();

  ///手机号
  TextEditingController mPhoneCodeController = TextEditingController();

  ///密码
  TextEditingController mPasswordController = TextEditingController();

  ///密码
  TextEditingController mPasswordAgainController = TextEditingController();

  ///邀请码注册
  TextEditingController mInviteCodeController = TextEditingController();

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

  bool isRegisterButtonEnabled = false;

  @override
  void onInit() {
    refreshNetController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    testNetLineDelay();
    super.onInit();
  }

  void onBack() {
    Get.back();
  }

  _initData() {
    requestCountryCode();
    update(["login"]);
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
            isChecked:
                lastNet.isEmpty ? i == 0 : Constants.netLineList[i] == lastNet,
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
          netLines
              .firstWhere((line) => line.url == url)
              .textColor = getDelayColor(latency);
        } catch (e) {
          netLines.firstWhere((line) => line.url == url).delay = -1;
          netLines
              .firstWhere((line) => line.url == url)
              .textColor = getDelayColor(-1);
        }
      }),
    );
    stopRefreshNetAnimation();
    update(["check_net_line"]);
  }

  void stopRefreshNetAnimation() {
    if (refreshNetController.isAnimating) {
      refreshNetController.stop();
    }
  }

  // 选择国家代码
  Future<void> selectCountryCode() async {
    if (countryCodes.isNotEmpty) {
      final resylt = await Get.toNamed(
        RouteNames.systemCountryCode,
        arguments: {"countryCodes": countryCodes},
      );
      currentCountryCode = resylt ?? "+86";
      update(["register"]);
    } else {
      requestCountryCode();
    }
  }

  Future<void> requestCountryCode() async {
    BaseListResponse<CountryCodeModel> model = await UserApi.getCountryCode();
    countryCodes = model.data ?? [];
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
      update(["register"]); // 更新UI
    });
  }

  // 停止倒计时
  void _stopCountdown() {
    _timer?.cancel();
    remainingSeconds = 60;
    isCounting = false;
    update(["register"]); // 更新
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
          await Future.delayed(
            Duration(milliseconds: 100 * retryCount),
          ); // 退避策略
          stopwatch.start();

          final response = await client
              .head(Uri.parse(url))
              .timeout(
                timeout,
                onTimeout: () => throw TimeoutException('请求超时'),
              );

          stopwatch.stop();
          if (response.statusCode < 400) {
            latencies.add(stopwatch.elapsedMilliseconds);
          } else {
            throw http.ClientException(
              'HTTP ${response.statusCode} ${response.reasonPhrase}',
            );
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
    _timer?.cancel();
    mPhoneController.dispose();
    _timer?.cancel();
    refreshNetController.dispose();
    mPasswordController.dispose();
    super.onClose();
  }

  void register() {}

  void requestPhoneCode() {}

  void goLoginPage(BuildContext context) {
    if (Get.previousRoute == RouteNames.systemLogin) {
      Get.back();
    } else {
      Get.toNamed(RouteNames.systemLogin);
    }
  }

  /// 检查注册按钮是否可用
  void checkRegisterButtonEnabled() {
    isRegisterButtonEnabled =
        mPhoneController.text.isNotEmpty &&
        mPasswordController.text.isNotEmpty &&
        mPhoneCodeController.text.isNotEmpty &&
        mPasswordAgainController.text.isNotEmpty &&
        mInviteCodeController.text.isNotEmpty;
    update(["register"]);
  }
}
