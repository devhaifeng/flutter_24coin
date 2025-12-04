import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

class AppTopBar extends StatelessWidget {
  final Widget? backIcon;
  final String? titleString;
  final Widget? rightWidget;
  final OnTap? onTap;
  final OnTap? onRightTap;

  const AppTopBar({super.key, this.backIcon, this.titleString, this.rightWidget, this.onTap, this.onRightTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 左侧按钮
          backIcon ??
              (Get.isDarkMode
                  ? SvgSelector(
                    normalSvg: AssetsSvgs.appbarCommonBackDarkSvg,
                    pressedSvg: AssetsSvgs.appbarCommonBackDarkPressSvg,
                    onTap: () {
                      if (onTap != null) {
                        onTap;
                      } else {
                        Get.back();
                      }
                    },
                  )
                  : SvgSelector(
                    normalSvg: AssetsSvgs.appbarCommonBackLightSvg,
                    pressedSvg: AssetsSvgs.appbarCommonBackLightPressSvg,
                    onTap: () {
                      if (onTap != null) {
                        onTap;
                      } else {
                        Get.back();
                      }
                    },
                  )),
          Center(
            child:
                titleString != null
                    ? TextWidget.h5(
                      titleString ?? '',
                      weight: FontWeight.w400,
                      color: context.theme.colorScheme.onSecondary,
                    )
                    : null,
          ),
          Container(alignment: Alignment.centerRight, child: rightWidget),
        ],
      ),
    );
  }
}
