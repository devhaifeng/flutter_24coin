import 'package:flutter/material.dart';

class ScanFramePainter extends CustomPainter {
  final Size frameSize = const Size.square(300); // 扫描框大小

  final double cornerLength = 20.0; // 边角长度

  final Paint framePaint =
      Paint()
        ..color = Colors.white
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.square; // 使边角为直角

  @override
  void paint(Canvas canvas, Size fullScreenSize) {
    // 1. 计算居中扫描框的左上角坐标和矩形区域
    final Offset leftTop = Offset(
      (fullScreenSize.width - frameSize.width) / 2,
      (fullScreenSize.height - frameSize.height) / 2,
    );
    //2.计算剧中扫描框的右上角坐标和矩形区域
    final Offset rightTop = Offset(
      (fullScreenSize.width + frameSize.width) / 2,
      (fullScreenSize.height - frameSize.height) / 2,
    );
    //3.计算居中扫描框的左下角坐标和矩形区域
    final Offset leftBottom = Offset(
      (fullScreenSize.width - frameSize.width) / 2,
      (fullScreenSize.height + frameSize.height) / 2,
    );
    //4.计算居中扫描框的右下角坐标和矩形区域
    final Offset rightBottom = Offset(
      (fullScreenSize.width + frameSize.width) / 2,
      (fullScreenSize.height + frameSize.height) / 2,
    );

    // 2. 绘制四个边角
    // 左上角
    canvas.drawLine(leftTop, leftTop + const Offset(20.0, 0), framePaint);
    canvas.drawLine(leftTop, leftTop + const Offset(0, 20.0), framePaint);
    // 右上角
    canvas.drawLine(rightTop, rightTop + const Offset(-20.0, 0), framePaint);
    canvas.drawLine(rightTop, rightTop + const Offset(0, 20.0), framePaint);
    // 左下角
    canvas.drawLine(leftBottom, leftBottom + const Offset(20.0, 0), framePaint);
    canvas.drawLine(leftBottom, leftBottom + const Offset(0, -20.0), framePaint);
    // 右下角
    canvas.drawLine(rightBottom, rightBottom + const Offset(-20.0, 0), framePaint);
    canvas.drawLine(rightBottom, rightBottom + const Offset(0, -20.0), framePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
