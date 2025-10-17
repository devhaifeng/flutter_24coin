import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgSelector extends StatefulWidget {
  final String normalSvg;
  final String pressedSvg;

  /// 点击事件
  final GestureTapCallback? onTap;

  const SvgSelector({super.key, required this.normalSvg, required this.pressedSvg, required this.onTap});

  @override
  _SvgSelectorState createState() => _SvgSelectorState();
}

class _SvgSelectorState extends State<SvgSelector> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => _isPressed = true),
      onTapUp: (details) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: SvgPicture.asset(_isPressed ? widget.pressedSvg : widget.normalSvg, width: 28, height: 28),
    );
  }
}
