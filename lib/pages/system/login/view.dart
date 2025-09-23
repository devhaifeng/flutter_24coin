import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_24coin/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

bool _isPreess = false;
bool _isLangurgePreess = false;

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.surfaceContainerHigh,
      child:
          <Widget>[
            //顶部
            _buildAppBar(context),
            // 输入框
            _buildInput(Get.context!),
            // 填充
            Spacer(),
            // 登录按钮
            _buildButton(Get.context!),
            // 语言选择
            _buildBottomView(Get.context!),
          ].toColumn(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppTopBar(titleString: LocaleKeys.commonLogin.tr);
  }

  /// 构建输入框
  Widget _buildInput(BuildContext context) {
    return <Widget>[
      SizedBox(height: 15.h),
      <Widget>[
        // 手机号输入框
        CommonContainer(
          width: 90,
          margin: EdgeInsets.symmetric(horizontal: 16),
          variant: ContainerWidgetVariant.text,
          horizontalPadding: 16,
          height: 50,
          text: controller.currentCountryCode,
          rightIcon: IconWidget.svg(
            AssetsSvgs.appbarCommonDownwardtSvg,
            size: 12,
          ),
          onTap: () => controller.selectCountryCode(),
        ),
        Expanded(
          child: CommonContainer(
            width: double.infinity,
            margin: EdgeInsets.only(right: 16),
            variant: ContainerWidgetVariant.input,
            horizontalPadding: 20,
            height: 50,

            input: Expanded(
              child: InputWidget(
                keyboardType: TextInputType.phone,
                placeholder: LocaleKeys.loginPhoneHint.tr,
                controller: controller.mPhoneController,
                onChanged: (value) {
                  controller.isLoginButtonEnabled =
                      controller.mPhoneController.text.isNotEmpty &&
                      controller.mPasswordController.text.isNotEmpty;
                  controller.update(["login"]);
                },
              ),
            ),
          ),
        ),
      ].toRow(),
      SizedBox(height: 15.h),
      // 密码输入框
      CommonContainer(
        margin: EdgeInsets.symmetric(horizontal: 16),
        variant: ContainerWidgetVariant.input,
        horizontalPadding: 20,
        verticalPadding: 12,
        height: 50,
        input: Expanded(
          child:
              controller.currentLoginByPassword
                  ///密码登录
                  ? InputWidget(
                    placeholder: LocaleKeys.loginPassword.tr,
                    controller: controller.mPasswordController,
                    obscureText: true,
                    onChanged: (value) {
                      controller.isLoginButtonEnabled =
                          controller.mPhoneController.text.isNotEmpty &&
                          controller.mPasswordController.text.isNotEmpty;
                      controller.update(["login"]);
                    },
                  )
                  :
                  //手机验证码登录
                  <Widget>[
                    InputWidget(
                      keyboardType: TextInputType.number,
                      placeholder: "验证码",
                      controller: controller.mPasswordController,
                      cleanable: false,
                      onChanged: (value) {
                        controller.isLoginButtonEnabled =
                            controller.mPhoneController.text.isNotEmpty &&
                            controller.mPasswordController.text.isNotEmpty;
                        controller.update(["login"]);
                      },
                    ).alignCenter().marginOnly(right: 100),

                    /// 短信倒计时
                    TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                      ),
                      onPressed: () {
                        controller.startCountdown();
                        controller.requestPhoneCode();
                      },
                      child: Text(
                        controller.isCounting
                            ? '${controller.remainingSeconds}S'
                            : '获取验证码',
                      ),
                    ),
                  ].toStack(alignment: Alignment.centerRight),
        ),
      ),
      SizedBox(height: 15.h),
      // 记住密码和自动登录
      Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          CheckboxWidget(
            description: LocaleKeys.loginRememberPassword.tr,
            checked: controller.isRememberPassword,
            onChanged: (value) {
              controller.setRememberPassword(value ?? false);
            },
          ).marginSymmetric(horizontal: 36),

          InkWell(
            child: TextWidget.label(
              controller.currentLoginByPassword
                  ? LocaleKeys.loginForPhone.tr
                  : LocaleKeys.loginForPassword.tr,
              color: AppTheme.commonTextColorSecondery,
            ),
            onTap: () => controller.changeLoginWays(),
          ).alignRight().marginSymmetric(horizontal: 36),
        ],
      ),
    ].toColumn();
  }

  /// 构建登录按钮
  Widget _buildButton(BuildContext context) {
    return <Widget>[
      LoginButtonWidget.primary(
        textColor:
            Get.isDarkMode
                ? controller.isLoginButtonEnabled
                    ? Colors.white
                    : Color(0xFF5C6267)
                : Colors.white,
        enabled: controller.isLoginButtonEnabled,
        LocaleKeys.commonLogin.tr,
        height: 50,
        borderRadius: 35,
        onTap: () => controller.login(),
        width: double.infinity,
      ),
      LoginButtonWidget.outline(
        borderColor: Colors.transparent,
        textColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: context.theme.colorScheme.secondary,
        LocaleKeys.commonRegisger.tr,
        height: 50,
        borderRadius: 35,
        onTap: () => controller.register(),
        width: double.infinity,
      ),
    ].toColumnSpace(space: 10).marginOnly(left: 16, right: 16, bottom: 20);
  }

  /// 构建语言选择
  Widget _buildBottomView(BuildContext context) {
    return <Widget>[
      <Widget>[
        Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              alignment: Alignment.center,
              height: 36.w,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(18), // 统一圆角半径
              ),
              child: <Widget>[
                IconWidget.svg(AssetsSvgs.loginLanguageSvg),
                TextWidget.minbody(
                  LocaleKeys.commonLanguage.tr,
                  color: AppTheme.info,
                ),
                IconWidget.svg(AssetsSvgs.iconCommonArrowRightSvg),
              ].toRowSpace(
                space: 5,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
            .gestures(
              onTap: () => displayLanguageDialog(context),
              onTapCancel:
                  () => {
                    _isLangurgePreess = false,
                    controller.update(["login"]),
                  },
              onTapDown:
                  (details) => {
                    _isLangurgePreess = true,
                    controller.update(["login"]),
                  },
              onTapUp:
                  (details) => {
                    _isLangurgePreess = false,
                    controller.update(["login"]),
                  },
            )
            .opacity(_isLangurgePreess ? 0.7 : 1.0),
        GestureDetector(
          onTap: () => {displaySwitchNetLineDialog(context)},
          onTapCancel:
              () => {
                _isPreess = false,
                controller.update(["login"]),
              },
          onTapDown:
              (details) => {
                _isPreess = true,
                controller.update(["login"]),
              },
          onTapUp:
              (details) => {
                _isPreess = false,
                controller.update(["login"]),
              },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            height: 36.w,
            decoration: BoxDecoration(
              color:
                  _isPreess
                      ? context.theme.colorScheme.secondary.withOpacity(0.8)
                      : context.theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: <Widget>[
              IconWidget.svg(
                AssetsSvgs.loginNetLineSvg,
                color:
                    _isPreess ? AppTheme.info.withOpacity(0.7) : AppTheme.info,
              ),
              TextWidget.minbody(
                LocaleKeys.commonSwitchNetLine.tr,
                color:
                    _isPreess
                        ? AppTheme.commonTextColorSecondery.withOpacity(0.7)
                        : AppTheme.commonTextColorSecondery,
              ),
              IconWidget.svg(
                AssetsSvgs.iconCommonArrowRightSvg,
                color:
                    _isPreess ? AppTheme.info.withOpacity(0.5) : AppTheme.info,
              ),
            ].toRowSpace(
              space: 5,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ].toRowSpace(space: 15.w, mainAxisAlignment: MainAxisAlignment.center),
      SizedBox(height: 15.h),
      TextWidget.minbody(
        "版本 ｜ v1.0.0",
        color: AppTheme.commonTextColorSecondery,
      ),
    ].toColumn().marginOnly(bottom: 30.h);
  }

  ///显示切换语言对话框
  void displayLanguageDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // 点击背景是否关闭
      barrierLabel:
          MaterialLocalizations.of(context).modalBarrierDismissLabel, //点击关闭折罩
      barrierColor: Colors.black54, // 背景遮罩颜色
      transitionDuration: const Duration(milliseconds: 300), // 动画时长
      pageBuilder: (context, animation, secondaryAnimation) {
        return GetBuilder<LanguageController>(
          id: "language_dialog",
          init: LanguageController(),
          builder: (controll) {
            return Material(
              type: MaterialType.transparency,
              child: Align(
                alignment: Alignment.bottomCenter, // 底部对齐
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Color(0xFF28323E) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextWidget.h5(LocaleKeys.commonSwitchLanguage.tr),
                      SizedBox(height: 20.h),
                      CommonContainer(
                        width: double.infinity,
                        variant: ContainerWidgetVariant.text,
                        horizontalPadding: 16,
                        radius: 15,
                        height: 50,
                        text: "简体中文",
                        textSize: 15,
                        rightWidget: CheckboxWidget(
                          checked: controll.isChinese,
                        ),
                        onTap: () {
                          controll.setLanguarge(0, context);
                        },
                      ),
                      SizedBox(height: 10.h),
                      CommonContainer(
                        width: double.infinity,
                        variant: ContainerWidgetVariant.text,
                        horizontalPadding: 16,
                        radius: 15,
                        height: 50,
                        text: "Emglish",
                        textSize: 15,
                        rightWidget: CheckboxWidget(
                          checked: controll.isEnglish,
                        ),
                        onTap: () {
                          controll.setLanguarge(1, context);
                        },
                      ),
                      SizedBox(height: 10.h),
                      CommonContainer(
                        width: double.infinity,
                        variant: ContainerWidgetVariant.text,
                        horizontalPadding: 16,
                        radius: 15,
                        height: 50,
                        text: "Việt nam",
                        textSize: 15,
                        rightWidget: CheckboxWidget(checked: controll.isVi),
                        onTap: () {
                          controll.setLanguarge(2, context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // 添加动画效果
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // 从底部开始
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  ///显示切换线路对话框
  void displaySwitchNetLineDialog(BuildContext context) {
    bool isPress = false; // 是否按下
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // 点击背景是否关闭
      barrierLabel:
          MaterialLocalizations.of(context).modalBarrierDismissLabel, //点击关闭折罩
      barrierColor: Colors.black54, // 背景遮罩颜色
      transitionDuration: const Duration(milliseconds: 300), // 动画时长
      pageBuilder: (context, animation, secondaryAnimation) {
        return GetBuilder<LoginController>(
          id: "check_net_line",
          init: LoginController(),
          builder: (controller) {
            return Material(
              type: MaterialType.transparency,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Ink(
                  width: MediaQuery.of(context).size.width,
                  height: 388,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: <Widget>[
                    Stack(
                      children: [
                        TextWidget.h5(
                          LocaleKeys.commonSwitchNetLine.tr,
                        ).alignCenter(),

                        <Widget>[
                              RotationTransition(
                                turns: Tween(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(controller.refreshNetController),
                                child: IconWidget.svg(
                                  AssetsSvgs.iconNetLineRefreshSvg,
                                  size: 18,
                                  color:
                                      isPress
                                          ? AppTheme.commonPrimaryPressColor
                                          : context.colors.scheme.primary,
                                ),
                              ), // 从0到1表示一圈,)
                              TextWidget.minbody(
                                LocaleKeys.loginRefresh.tr,
                                color:
                                    isPress
                                        ? AppTheme.commonPrimaryPressColor
                                        : context.colors.scheme.primary,
                              ),
                            ]
                            .toRowSpace(
                              space: 8,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                            )
                            .gestures(
                              onTapDown: (details) {
                                isPress = true;
                                controller.update(["check_net_line"]);
                              },
                              onTapCancel: () {
                                isPress = false;
                                controller.update(["check_net_line"]);
                              },
                              onTapUp: (details) {
                                isPress = false;
                                controller.update(["check_net_line"]);
                              },
                              onTap: () {
                                controller.testNetLineDelay();
                              },
                            )
                            .marginOnly(top: 3)
                            .alignRight(),
                      ],
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 20, bottom: 0), // 顶
                      itemBuilder: (context, index) {
                        final netLine = controller.netLines[index];
                        return <Widget>[
                          Stack(
                            children: [
                              CommonContainer(
                                width: double.infinity,
                                variant: ContainerWidgetVariant.text,
                                horizontalPadding: 15,
                                radius: 15,
                                height: 50,
                                text: netLine.url,
                                textSize: 15,
                                rightWidget: CheckboxWidget(
                                  size: 18,
                                  checked: netLine.isChecked ?? false,
                                ),
                                onTap: () {
                                  controller.setCurrentNetLine(index);
                                  Get.back();
                                },
                              ),
                              TextWidget.label(
                                    netLine.delay != null
                                        ? "${netLine.delay}ms"
                                        : "检测中...",
                                    color: netLine.textColor,
                                  )
                                  .align(Alignment.centerRight)
                                  .height(50)
                                  .marginOnly(right: 46),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ].toColumn();
                      },
                      itemCount: controller.netLines.length,
                    ).expanded(),
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.center),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // 添加动画效果
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // 从底部开始
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemStyle();

    /// 暗色系统样式
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: "login",
      builder: (_) {
        // 关键设置：防止布局被键盘顶起
        return Scaffold(
          body: SafeArea(bottom: false, child: _buildView(context)),
          resizeToAvoidBottomInset: false,
        );
      },
    );
  }
}
