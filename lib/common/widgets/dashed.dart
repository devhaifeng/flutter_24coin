import 'package:flutter/material.dart';

/// @ [size] 虚线尺寸
/// @ [dashedWidth] 虚线段宽度
/// @ [dashedHeight] 虚线段高度
/// @ [density] 虚线密度
/// @ [axis] 虚线方向 垂直 || 水平
/// @ [dashedColor] 虚线颜色
class DashedLine extends StatelessWidget {
  final double size;
  final double dashedWidth;
  final double dashedHeight;
  final int density;
  final Axis axis;
  final Color dashedColor;
  const DashedLine({
    super.key,
    this.size = double.infinity,
    this.dashedWidth = 10.0,
    this.dashedHeight = 1.0,
    this.density = 10,
    this.axis = Axis.horizontal,
    this.dashedColor = Colors.grey,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : dashedWidth,
      height: axis == Axis.vertical ? size : dashedHeight,
      child: Flex(
        direction: axis,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(density, (int index) {
          return DecoratedBox(
            decoration: BoxDecoration(color: dashedColor, borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: dashedWidth, height: dashedHeight),
          );
        }),
      ),
    );
  }
}
