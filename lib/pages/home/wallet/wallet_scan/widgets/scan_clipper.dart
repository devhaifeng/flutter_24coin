import 'package:flutter/material.dart';

class ScannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 在中心创建一个矩形的孔洞
    final centerX = size.width / 2;
    final centerY = size.height / 2 - 100;
    const holeSize = 300.0;

    final holeRect = Rect.fromCenter(center: Offset(centerX, centerY), width: holeSize, height: holeSize);

    // 从完整矩形中减去中心矩形
    final holePath = Path()..addRRect(RRect.fromRectAndRadius(holeRect, const Radius.circular(0)));

    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
