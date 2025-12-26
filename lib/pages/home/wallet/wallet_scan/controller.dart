import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class WalletScanController extends GetxController with GetSingleTickerProviderStateMixin {
  WalletScanController();

  Barcode? barcode;

  late MobileScannerController mobileScannerController;

  late AnimationController controller;
  late Animation<double> animation;
  final ValueNotifier<bool> torchEnabled = ValueNotifier(false);
  final ValueNotifier<CameraFacing> cameraFacing = ValueNotifier(CameraFacing.back);

  _initData() {
    update(["wallet_scan"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    mobileScannerController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
      formats: [BarcodeFormat.qrCode, BarcodeFormat.code128],
    );
    controller = AnimationController(
      duration: const Duration(seconds: 5), // 动画周期
      vsync: this,
    );
    // 定义网格从顶部移动到底部的动画
    animation = Tween<double>(begin: -1.0, end: 1.0).animate(controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat(); // 动画完成后重新开始
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward(); // 启动动画
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  /// 打开相册
  void openAlbum() {}

  @override
  void onClose() {
    super.onClose();
    torchEnabled.dispose();
    cameraFacing.dispose();
    mobileScannerController.dispose();
    controller.dispose();
  }
}
