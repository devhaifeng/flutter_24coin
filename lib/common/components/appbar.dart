import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../index.dart';

/// 主导航栏
AppBar mainAppBarWidget({
  Key? key,
  Function()? onTap, // 点击事件
  Widget? leading, // 左侧按钮
  String? titleString, // 标题
  double? titleSpace, // 标题间距
  SystemUiOverlayStyle? systemOverlayStyle, // 系统状态栏样式
}) {
  return AppBar(
    // 高度
    toolbarHeight: 50,
    systemOverlayStyle: systemOverlayStyle,
    // 最左侧按钮
    leading:
        leading != null
            ? SizedBox(
              width: 28, // 限制宽度
              height: 28, // 限制高度
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ), // 覆盖高亮和水波纹颜色
                ),
                hoverColor: Colors.transparent,
                iconSize: 28,
                padding: EdgeInsets.zero, // 关键：移除内边距
                icon: leading,
                onPressed: onTap ?? () => Get.back(),
              ),
            )
            : null,
    // 按钮和标题组件间距
    titleSpacing: titleSpace ?? AppSpace.listItem,
    // 标题组件
    title: Text(
      titleString ?? "",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    // 右侧按钮组
    actions: [],
  );
}
