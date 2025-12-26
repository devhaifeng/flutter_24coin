import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'index.dart';

class WalletScanPage extends GetView<WalletScanController> {
  const WalletScanPage({super.key});
  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      AppTopBar(
        titleString: LocaleKeys.walletScanTitle.tr,
        rightWidget: TextWidget.body(
          LocaleKeys.walletScanAlbum.tr,
          color: AppTheme.primary,
          size: 18,
        ).paddingAll(12).onTap(() {
          controller.openAlbum();
        }),
      ),

      Stack(
        children: [
          MobileScanner(
            controller: controller.mobileScannerController,
            scanWindow: Rect.fromCenter(
              center: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2 - 100),
              width: 300,
              height: 300,
            ),
            onDetect: (barcode) {
              controller.barcode = barcode.barcodes.firstOrNull;
            },
          ),
          // 2. 半透明遮罩层（中心镂空）
          Positioned.fill(child: ClipPath(clipper: ScannerClipper(), child: Container(color: Color(0x80000000)))),
          // 3. 扫描框装饰
          _buildScanFrame(context),
          // 4. 扫描网格动画
          _buildScanGrid(context),
        ],
      ).expanded(),
    ].toColumn();
  }

  Widget _buildScanFrame(BuildContext context) {
    final frameSize = 300.0; // 扫描框大小
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -100), // 与遮罩层偏移一致
        child: Container(
          width: frameSize,
          height: frameSize,
          // 这是新添加的、用于白色边框的Container
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            // 如果希望边框和扫描框孔洞之间有间隙，可以在这里设置padding
            borderRadius: BorderRadius.circular(0),
          ),
          child: SizedBox(width: frameSize, height: frameSize, child: CustomPaint(painter: ScanFramePainter())),
        ),
      ),
    );
  }

  Widget _buildScanGrid(BuildContext context) {
    final frameSize = 300.0; // 扫描框大小
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -100), // 与遮罩层偏移一致
        child: SizedBox(
          width: frameSize,
          height: frameSize,
          child: AnimatedBuilder(
            animation: controller.animation,
            builder: (context, child) {
              // 计算偏移量，使网格缓慢向下移动
              final cellHeight = 50;
              final offset = controller.animation.value * cellHeight;
              return CustomPaint(
                painter: GridScanPainter(
                  lineColor: Colors.white,
                  lineWidth: 0.8,
                  gridSize: 30,
                  animationOffset: offset,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletScanController>(
      init: WalletScanController(),
      id: "wallet_scan",
      builder: (_) {
        return Scaffold(body: SafeArea(child: _buildView(context)));
      },
    );
  }
}
