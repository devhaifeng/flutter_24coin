import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

// 排版类型
enum TextWidgetType { h1, h2, h3, h4, h5, minbody, body, label, muted }

bool isPress = false;

class TextWidget extends StatefulWidget {
  const TextWidget(
    String s, {
    super.key,
    required this.text,
    this.type,
    this.size,
    this.scale,
    this.textStyle,
    this.color,
    this.weight,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.fontStyle,
    this.onTap,
  });

  /// 文字
  final String text;

  /// 排版类型
  final TextWidgetType? type;

  /// 缩放 large medium small
  final WidgetScale? scale;

  /// 组件样式
  final TextStyle? textStyle;

  /// 字体样式
  final FontStyle? fontStyle;

  /// 颜色
  final Color? color;

  /// 大小
  final double? size;

  /// 重量
  final FontWeight? weight;

  /// 行数
  final int? maxLines;

  /// 自动换行
  final bool? softWrap;

  /// 溢出
  final TextOverflow? overflow;

  /// 对齐方式
  final TextAlign? textAlign;

  final Function()? onTap;

  /// h1
  const TextWidget.h1(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.w800,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.h1;

  /// h2
  const TextWidget.h2(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.w600,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.h2;

  /// h3
  const TextWidget.h3(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.w600,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.h3;

  /// h4
  const TextWidget.h4(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.w600,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.h4;

  /// h5
  const TextWidget.h5(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.normal,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.h5;

  /// body
  const TextWidget.body(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.normal,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.body;

  /// body
  const TextWidget.minbody(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.normal,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.minbody;

  /// label
  const TextWidget.label(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.w400,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.label;

  /// muted
  const TextWidget.muted(
    this.text, {
    super.key,
    this.scale,
    this.size,
    this.color,
    this.weight = FontWeight.w400,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textAlign,
    this.textStyle,
    this.fontStyle,
    this.onTap,
  }) : type = TextWidgetType.muted;

  /// 文字尺寸
  double _fontSize() {
    // 计算字体
    // https://tailwindcss.com/docs/font-size
    double fontSize = size ?? 0;
    if (fontSize == 0) {
      switch (type) {
        case TextWidgetType.h1:
          fontSize = 36;
        case TextWidgetType.h2:
          fontSize = 30;
        case TextWidgetType.h3:
          fontSize = 24;
        case TextWidgetType.h4:
          fontSize = 20;
        case TextWidgetType.h5:
          fontSize = 18;
        case TextWidgetType.body:
          fontSize = 16;
        case TextWidgetType.minbody:
          fontSize = 15;
        case TextWidgetType.label:
          fontSize = 14;
        case TextWidgetType.muted:
          fontSize = 12;
        default:
          fontSize = 14;
      }
    }

    // 计算缩放
    // https://m3.material.io/styles/typography/type-scale-tokens
    switch (scale) {
      case WidgetScale.large:
        return fontSize * 1.3;
      case WidgetScale.medium:
        return fontSize;
      case WidgetScale.small:
        return fontSize * 0.8;
      default:
        return fontSize;
    }
  }

  Color _color(BuildContext context) {
    if (color != null) {
      return color!;
    }

    switch (type) {
      case TextWidgetType.h1:
      case TextWidgetType.h2:
      case TextWidgetType.h3:
      case TextWidgetType.h4:
      case TextWidgetType.h5:
      case TextWidgetType.body:
      case TextWidgetType.minbody:
      case TextWidgetType.label:
        return context.colors.scheme.onSurface;
      case TextWidgetType.muted:
        return context.colors.scheme.onSurface.withOpacity(0.8);
      default:
        return context.colors.scheme.onSurface;
    }
  }

  @override
  State<StatefulWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.onTap == null
        ? Text(
          widget.text,
          style: TextStyle(
            color: widget._color(context),
            fontSize: widget._fontSize(),
            fontWeight: widget.weight,
            fontStyle: widget.fontStyle,
          ),
          maxLines: widget.maxLines,
          softWrap: widget.softWrap,
          overflow: widget.overflow,
          textAlign: widget.textAlign,
        )
        : GestureDetector(
          onTap: widget.onTap,
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget._color(context),
              fontSize: widget._fontSize(),
              fontWeight: widget.weight,
              fontStyle: widget.fontStyle,
            ),
            maxLines: widget.maxLines,
            softWrap: widget.softWrap,
            overflow: widget.overflow,
            textAlign: widget.textAlign,
          ).opacity(isPress ? 0.7 : 1.0),
          onTapUp:
              (details) => {
                setState(() {
                  isPress = false;
                }),
              },
          onTapCancel:
              () => {
                setState(() {
                  isPress = false;
                }),
              },
          onTapDown:
              (details) => {
                setState(() {
                  isPress = true;
                }),
              },
        );
  }
}
