import 'package:flutter/material.dart';

class GridScanPainter extends CustomPainter {
  final Color lineColor;
  final double lineWidth;
  final int gridSize; // 网格大小（单元格数量）
  final double animationOffset; // 动画偏移量（用于动态效果）

  GridScanPainter({
    this.lineColor = Colors.white,
    this.lineWidth = 1.0,
    this.gridSize = 20,
    this.animationOffset = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = lineColor.withOpacity(0.5) // 半透明效果
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

    // 计算单元格的实际宽度和高度
    final cellWidth = size.width / gridSize;
    final cellHeight = size.height / gridSize;

    // 绘制横向网格线
    for (int i = 0; i <= gridSize; i++) {
      final y = i * cellHeight;
      // 添加动画偏移
      final animatedY = (y + animationOffset) % size.height;

      canvas.drawLine(Offset(0, animatedY), Offset(size.width, animatedY), paint);
    }

    // 绘制纵向网格线
    for (int i = 0; i <= gridSize; i++) {
      final x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridScanPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.gridSize != gridSize ||
        oldDelegate.animationOffset != animationOffset;
  }
}
