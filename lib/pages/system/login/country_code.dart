import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:flutter_24coin/pages/system/login/controller.dart';
import 'package:get/get.dart';

///选择国家代手机号
class CountryCodePage extends GetView<LoginController> {
  final List<CountryCodeModel> countryCodes = Get.arguments["countryCodes"];
  final List<String> pngFlag = [
    "86",
    "852",
    "1",
    "73",
    "971",
    "62",
    "63",
    "66",
    "856",
    "82",
    "60",
  ];

  CountryCodePage({super.key});

  Widget _buildAppBar(BuildContext context) {
    return AppTopBar(
      backIcon: Text(""),
      titleString: LocaleKeys.commonSelectCountry.tr,
      rightWidget: SvgSelector(
        normalSvg:
            Get.isDarkMode
                ? AssetsSvgs.iconCommonCloseDarkSvg
                : AssetsSvgs.iconCommonCloseLightSvg,
        pressedSvg:
            Get.isDarkMode
                ? AssetsSvgs.iconCommonCloseDarkSvg
                : AssetsSvgs.iconCommonCloseLightPressSvg,

        onTap: () => Get.back(),
      ),
    ).backgroundColor(context.theme.colorScheme.surfaceContainerHigh);
  }

  ///构建国家手机号列表
  Widget _buildCountryCodeList(BuildContext context) {
    return Expanded(
      child: Container(
        color: Get.isDarkMode ? Color(0xff0F161D) : Color(0xffF5F5F5),
        child: Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Color(0xff19232C) : Color(0xffffffff),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            itemCount: countryCodes.length,
            itemBuilder: (context, index) {
              final code = countryCodes[index];
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius:
                      index == 0
                          ? BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )
                          : index == countryCodes.length - 1
                          ? BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )
                          : BorderRadius.zero,
                  onTap: () {
                    Get.back(result: "+${code.code}");
                  },
                  splashColor: Colors.transparent, // 点击水波纹颜色
                  highlightColor:
                      Get.isDarkMode
                          ? Color(0x800F161D)
                          : Color(0xFFEEEEEE), // 长按高亮色
                  child: ListTile(
                    leading:
                        pngFlag.contains(code.code!)
                            ? ImageWidget.img(
                              controller.selectCountryFlag(code.code!),
                              width: 30,
                              height: 20,
                              radius: 0,
                              fit: BoxFit.cover,
                            )
                            : ImageWidget.svg(
                              controller.selectCountryFlag(code.code!),
                              width: 30,
                              height: 20,
                              radius: 0,
                              fit: BoxFit.cover,
                            ),

                    title: Text(
                      ConfigService.to.locale == Locale('en', 'US')
                          ? code.nameEn!
                          : code.nameCn!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder:
                (BuildContext context, int index) => Divider(
                  // 自定义分割线
                  height: 1,
                  thickness: 0.5,
                  color: Get.isDarkMode ? Color(0xFF2B3843) : Color(0xFFF5F5F5),
                ).marginSymmetric(horizontal: 16.w),
          ),
        ).marginSymmetric(horizontal: 15.w, vertical: 15.h),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemStyle();
    final controller = Get.put(LoginController());
    return GetBuilder<LoginController>(
      id: "country_code",
      init: controller,
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child:
                <Widget>[
                  _buildAppBar(context),
                  _buildCountryCodeList(context),
                ].toColumn(),
          ),
        );
      },
    );
  }
}
