import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';

class CheckboxWidget extends StatelessWidget {
  final bool? checked;
  final String? title;
  final String? description;
  final double? size;

  final Function(bool?)? onChanged;

  const CheckboxWidget({
    super.key,
    this.checked,
    this.title,
    this.description,
    this.onChanged,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return <Widget>[
          // 图标按钮
          checked == true
              ? IconWidget.svg(
                AssetsSvgs.iconCommonCheckedSvg,
                size: size ?? 20,
              )
              : IconWidget.svg(
                AssetsSvgs.iconCommonUncheckSvg,
                size: size ?? 20,
              ),

          // 标题、说明
          if (title != null || description != null)
            <Widget>[
                  if (title != null) TextWidget.label(title!),
                  if (description != null)
                    TextWidget.label(
                      description!,
                      maxLines: 3,
                      color: AppTheme.commonTextColorSecondery,
                    ),
                ]
                .toColumnSpace(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                )
                .expanded(),
        ]
        .toRowSpace(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        )
        .gestures(
          onTap: () {
            onChanged?.call(!(checked ?? false));
          },
        );
  }
}
