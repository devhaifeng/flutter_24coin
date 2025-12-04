import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  //   现在逐个颜色说明：
  // brightness: Brightness.light - 表示这是一个亮色主题。
  // primary: Color(0xff18A5F1) - 主品牌色。用于主要按钮、重要图标激活状态等。
  // surfaceTint: Color(0xff415f91) - 表面色调，用于组件的表面（如卡片）上覆盖的色调，以表明高程（阴影）的视觉变化。
  // onPrimary: Color(0xffffffff) - 用在主颜色上面的内容（如文字、图标），这里用白色确保可读性。
  // primaryContainer: Color(0xffd6e3ff) - 主色容器，比主色浅，用于一些需要突出主色但又不那么强烈的容器背景，比如导航栏、标签页等。
  // onPrimaryContainer: Color(0xff001b3e) - 用在主色容器上的内容（如文字），深蓝色，与主色容器形成对比。
  // secondary: Color(0xff565f71) - 副品牌色。用于次级按钮、未激活状态图标、副标题等。
  // onSecondary: Color(0xffffffff) - 副色上的内容，这里用白色。
  // secondaryContainer: Color(0xffdae2f9) - 副色容器，用于副色区域容器背景，比副色浅。
  // onSecondaryContainer: Color(0xff131c2b) - 副色容器上的内容，深灰色。
  // tertiary: Color(0xff705575) - 第三色，用于需要额外强调的地方，比如进度条、滑块、开关等。
  // onTertiary: Color(0xffffffff) - 第三色上的内容，白色。
  // tertiaryContainer: Color(0xfffad8fd) - 第三色容器，用于第三色区域的容器背景。
  // onTertiaryContainer: Color(0xff28132e) - 第三色容器上的内容，深紫色。
  // error: Color(0xffba1a1a) - 错误色，用于错误提示文字、图标、边框等。
  // onError: Color(0xffffffff) - 错误色上的内容，白色。
  // errorContainer: Color(0xffffdad6) - 错误容器，用于错误提示的背景（如Toast的背景）。
  // onErrorContainer: Color(0xff410002) - 错误容器上的内容，深红色。
  // surface: Color(0xfff9f9ff) - 表面色，即应用程序的基本背景颜色，如Scaffold的背景色。
  // onSurface: Color(0xff191c20) - 表面上的内容，如大部分文本。
  // onSurfaceVariant: Color(0xff44474e) - 表面上的次要内容，如图标、提示文本等。
  // outline: Color(0xff74777f) - 轮廓色，用于边框，如输入框的边框。
  // outlineVariant: Color(0xffc4c6d0) - 轮廓变体，用于需要较淡边框的地方，比如分割线（Divider）。
  // shadow: Color(0xff000000) - 阴影色，用于阴影效果。
  // scrim: Color(0xff000000) - 幕布色，用于模态窗后面的遮罩。
  // inverseSurface: Color(0xff2e3036) - 反转表面，用于一些需要与主表面反色的元素（比如SnackBar）。
  // inversePrimary: Color(0xffaac7ff) - 反转主色，用于暗色主题下的亮色主题元素（如按钮）在反转模式下的颜色。
  // primaryFixed: Color(0xffd6e3ff) - 固定主色（容器），用于需要固定不变的主色容器，比如系统导航栏。
  // onPrimaryFixed: Color(0xff001b3e) - 固定主色容器上的内容。
  // primaryFixedDim: Color(0xffaac7ff) - 固定主色（较暗），用于固定主色容器的按下状态等。
  // onPrimaryFixedVariant: Color(0xff284777) - 用于固定主色容器的变体上的内容（比如文本）。
  // secondaryFixed: Color(0xffdae2f9) - 固定副色容器。
  // onSecondaryFixed: Color(0xff131c2b) - 固定副色容器上的内容。
  // secondaryFixedDim: Color(0xffbec6dc) - 固定副色（较暗）。
  // onSecondaryFixedVariant: Color(0xff3e4759) - 固定副色容器的变体上的内容。
  // tertiaryFixed: Color(0xfffad8fd) - 固定第三色容器。
  // onTertiaryFixed: Color(0xff28132e) - 固定第三色容器上的内容。
  // tertiaryFixedDim: Color(0xffddbce0) - 固定第三色（较暗）。
  // onTertiaryFixedVariant: Color(0xff573e5c) - 固定第三色容器的变体上的内容。
  // surfaceDim: Color(0xffd9d9e0) - 暗化的表面，用于需要比主表面稍暗的背景（比如抽屉背景）。
  // surfaceBright: Color(0xfff9f9ff) - 明亮的表面，用于需要突出显示的区域。
  // surfaceContainerLowest: Color(0xffffffff) - 最浅的表面容器，比主表面更亮，比如对话框的背景。
  // surfaceContainerLow: Color(0xfff3f3fa) - 比主表面稍浅的容器。
  // surfaceContainer: Color(0xffededf4) - 中等程度的表面容器，介于低和高之间。
  // surfaceContainerHigh: Color(0xffe7e8ee) - 稍暗的表面容器，比如AppBar的背景。
  // surfaceContainerHighest: Color(0xffe2e2e9) - 最暗的表面容器。

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff18a5f1),
      surfaceTint: Color(0xff18a5f1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff18a5f1),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xfff5f5f5),
      onSecondary: Color(0xff333333),
      secondaryContainer: Color(0xfff5f5f5),
      onSecondaryContainer: Color(0xff333333),
      tertiary: Color(0xfff5f5f5),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff5f5f5),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xffffffff),
      onSurface: Color(0xff333333),
      onSurfaceVariant: Color(0xff333333),
      outline: Color(0xff6f7882),
      outlineVariant: Color(0xffbec7d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3136),
      inversePrimary: Color(0xff90cdff),
      primaryFixed: Color(0xffcbe6ff),
      onPrimaryFixed: Color(0xff001e30),
      primaryFixedDim: Color(0xff90cdff),
      onPrimaryFixedVariant: Color(0xff004b72),
      secondaryFixed: Color(0xFFFFFFFF),
      onSecondaryFixed: Color(0xff001e30),
      secondaryFixedDim: Color(0xffa5cbec),
      onSecondaryFixedVariant: Color(0xff244a66),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff310048),
      tertiaryFixedDim: Color(0xffe9b3ff),
      onTertiaryFixedVariant: Color(0xff692789),
      surfaceDim: Color(0xffffffff),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4fa),
      surfaceContainer: Color(0xFFFFFFFF),
      surfaceContainerHigh: Color(0xffffffff),
      surfaceContainerHighest: Color(0xfff5f5f5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff18A5F1),
      surfaceTint: Color(0xff18A5F1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff18A5F1),
      onPrimaryContainer: Color(0xFF28323E),
      secondary: Color(0xff19232C),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff19232C),
      onSecondaryContainer: Color(0xff8C99A5),
      tertiary: Color(0xff28323E),
      onTertiary: Color(0xff3f2844),
      tertiaryContainer: Color(0xff28323E),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff000000),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff415f91),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff284777),
      secondaryFixed: Color(0xFF232D39),
      onSecondaryFixed: Color(0xff131c2b),
      secondaryFixedDim: Color(0xffbec6dc),
      onSecondaryFixedVariant: Color(0xff3e4759),
      tertiaryFixed: Color(0xfffad8fd),
      onTertiaryFixed: Color(0xff28132e),
      tertiaryFixedDim: Color(0xffddbce0),
      onTertiaryFixedVariant: Color(0xff573e5c),
      surfaceDim: Color(0xff000000),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff19232C),
      surfaceContainerHigh: Color(0xff0F161D),
      surfaceContainerHighest: Color(0xff0F161D),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
