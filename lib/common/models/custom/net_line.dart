//检测app线路
import 'dart:ui';

class AppNetLineData {
  String url;
  String? show;
  int? delay;
  bool? isChecked = false;
  Color? textColor;

  AppNetLineData(
    this.url, {
    this.show,
    this.delay,
    this.isChecked,
    this.textColor,
  });
}
