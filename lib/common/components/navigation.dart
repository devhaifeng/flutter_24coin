import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

/// 导航栏数据模型
class NavigationItemModel {
  final String label;
  final String icon;
  final int count;

  NavigationItemModel({
    required this.label,
    required this.icon,
    this.count = 0,
  });
}

/// 导航栏
class BuildNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavigationItemModel> items;
  final Function(int) onTap;

  const BuildNavigation({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var ws = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      var color =
          (i == currentIndex)
              ? context.colors.scheme.primary
              : context.colors.scheme.outline;
      var item = items[i];
      ws.add(
        <Widget>[
              // 图标
              IconWidget.svg(
                item.icon,
                size: 24,
                badgeString: item.count > 0 ? item.count.toString() : null,
              ).paddingBottom(2),
              // 文字
              TextWidget.label(item.label.tr, color: color, size: 10),
            ]
            .toColumn(
              mainAxisAlignment: MainAxisAlignment.end, // 居中
              mainAxisSize: MainAxisSize.max, // 最大
            )
            .onTap(() => onTap(i))
            .alignBottom()
            .expanded(),
      );
    }
    return BottomAppBar(
      height: 50,
      color: context.colors.scheme.surfaceContainerHighest,
      elevation: 0,
      padding: EdgeInsets.zero,
      child: ws.toRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
