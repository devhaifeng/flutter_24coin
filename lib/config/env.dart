/// 环境配置
class AppEnvironment {
  static const String development = 'development';
  static const String testing = 'testing';
  static const String production = 'production';

  // 当前环境
  static String get currentEnvironment {
    const String env = String.fromEnvironment('FLUTTER_ENV', defaultValue: development);
    return env;
  }

  // 是否是开发环境
  static bool get isDevelopment => currentEnvironment == development;

  // 是否是测试环境
  static bool get isTesting => currentEnvironment == testing;

  // 是否是生产环境
  static bool get isProduction => currentEnvironment == production;

  // API 基础地址
  static String get apiBaseUrl {
    switch (currentEnvironment) {
      case development:
        return 'https://dev-api.24coin.com';
      case testing:
        return 'https://test-api.24coin.com';
      case production:
        return 'https://api.24coin.com';
      default:
        return 'https://dev-api.24coin.com';
    }
  }

  // WebSocket 地址
  static String get wsUrl {
    switch (currentEnvironment) {
      case development:
        return 'wss://dev-ws.24coin.com';
      case testing:
        return 'wss://test-ws.24coin.com';
      case production:
        return 'wss://ws.24coin.com';
      default:
        return 'wss://dev-ws.24coin.com';
    }
  }

  // 调试模式
  static bool get debugMode {
    return isDevelopment || isTesting;
  }

  // 应用名称
  static String get appName {
    switch (currentEnvironment) {
      case development:
        return '24Coin Dev';
      case testing:
        return '24Coin Test';
      case production:
        return '24Coin';
      default:
        return '24Coin Dev';
    }
  }
}
