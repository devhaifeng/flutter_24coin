import 'package:flutter_24coin/common/index.dart';
import 'package:flutter_24coin/pages/index.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RoutePages {
  static List<String> history = [];

  static List<GetPage> list = [
    GetPage(name: RouteNames.systemLogin, page: () => const LoginPage()),
    GetPage(name: RouteNames.systemSplash, page: () => const SplashPage()),
    GetPage(name: RouteNames.systemWelcome, page: () => const WelcomePage()),
    GetPage(name: RouteNames.systemCountryCode, page: () => CountryCodePage()),
    GetPage(
      name: RouteNames.systemMain,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(name: RouteNames.systemRegister, page: () => const RegisterPage()),
  ];
}
