import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/widgets/index.dart';
import 'package:get/get.dart';

/// 币种列表项
class CoinItemWidget extends StatelessWidget {
  final String? coinName;
  final String? logoUrl;
  final String? newPrice;
  final String? rightText;
  final Color? rightColor;

  const CoinItemWidget({super.key, this.coinName, this.logoUrl, this.newPrice, this.rightText, this.rightColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            logoUrl ?? '',
            width: 30,
            height: 30,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return CircleAvatar(
                backgroundColor: context.colors.scheme.secondary,
                radius: 15, // 半径
              );
            },
          ),
          SizedBox(width: 15),
          TextWidget.body(coinName ?? '', color: Get.isDarkMode ? Colors.white : Colors.black),
          Spacer(),
          TextWidget.body(newPrice ?? '', color: Get.isDarkMode ? Colors.white : Colors.black),
          SizedBox(width: 45),
          TextWidget.body(rightText ?? '', color: rightColor),
        ],
      ),
    );
  }
}
