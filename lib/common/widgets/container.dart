import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/style/index.dart';
import 'package:flutter_24coin/common/widgets/index.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

/// 按钮样式
enum ContainerWidgetVariant { input, text }

class CommonContainer extends StatelessWidget {
  final ContainerWidgetVariant variant;

  final int? radius;

  final int? horizontalPadding;

  final int? verticalPadding;

  final EdgeInsetsGeometry? margin;

  final double? width;

  final double? height;

  final String? text;

  final Widget? input;

  final IconWidget? rightIcon;

  final IconWidget? rightIcon2;

  final Widget? rightWidget;

  final TextWidget? rightText;

  final double? textSize;

  final GestureTapCallback? onTap;

  const CommonContainer({
    super.key,
    required this.variant,
    this.radius,
    this.horizontalPadding,
    this.verticalPadding,
    this.margin,
    this.width,
    this.height,
    this.text,
    this.input,
    this.rightIcon,
    this.rightIcon2,
    this.rightWidget,
    this.rightText,
    this.textSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: variant == ContainerWidgetVariant.text ? onTap : null,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        width: width ?? double.infinity,
        height: height ?? 50,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding?.toDouble() ?? 0,
          vertical: verticalPadding?.toDouble() ?? 0,
        ),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(
            radius?.toDouble() ?? height! / 2.toDouble(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (text != null)
              Text(
                text!,
                style: TextStyle(
                  fontSize: textSize ?? 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (input != null) input!,
            if (rightIcon != null) rightIcon!,
            if (rightIcon2 != null) rightIcon2!,
            if (rightWidget != null) rightWidget!,
            if (rightText != null) rightText!,
          ],
        ),
      ),
    );
  }
}
