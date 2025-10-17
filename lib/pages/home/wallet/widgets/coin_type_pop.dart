//下拉菜单
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/models/index.dart';
import 'package:flutter_24coin/common/widgets/index.dart';

class CoinTypePopView extends StatelessWidget {
  /// 点击菜单
  final Function(CoinAllowData? value)? onChanged;

  /// 数据源
  final List<CoinAllowData>? items;

  /// 选中数据值
  final CoinAllowData? selectedValue;

  /// 提示文字
  final String? hintText;

  /// 图标颜色
  final Color? iconColor;

  /// 按钮 padding
  final EdgeInsetsGeometry? buttonPadding;

  const CoinTypePopView({
    super.key,
    this.items,
    this.selectedValue,
    this.hintText,
    this.onChanged,
    this.buttonPadding,
    this.iconColor,
  });

  Widget _buildView() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<CoinAllowData>(
        // 按钮样式
        buttonStyleData: ButtonStyleData(),
        // 扩展
        isExpanded: true,
        // 提示组件
        hint: Row(
          children: [
            Expanded(child: TextWidget.label(hintText ?? 'Select Item')),
          ],
        ),
        // 下拉项列表
        items:
            items
                ?.map(
                  (item) => DropdownMenuItem<CoinAllowData>(
                    value: item,
                    child: TextWidget.label(item.appDisplay ?? ""),
                  ),
                )
                .toList(),
        // 选中项
        value: selectedValue,
        // 改变事件
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
