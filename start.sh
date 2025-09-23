#!/bin/bash

# Flutter 24Coin 快速启动脚本
echo "🚀 Flutter 24Coin 启动脚本"
echo "=========================="

# 检查Flutter是否安装
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter 未安装，请先安装 Flutter SDK"
    exit 1
fi

# 显示菜单
echo "请选择启动模式："
echo "1. 🔧 开发环境 (Development)"
echo "2. 🧪 测试环境 (Testing)" 
echo "3. 🏭 生产环境 (Production)"
echo "4. 📱 iOS 模拟器"
echo "5. 🤖 Android 模拟器"
echo "6. 🌐 Web 浏览器"
echo "7. ⚡ 性能模式"
echo "8. 🧹 清理并重新构建"

read -p "输入选择 (1-8): " choice

case $choice in
    1)
        echo "🔧 启动开发环境..."
        flutter run --dart-define=FLUTTER_ENV=development
        ;;
    2)
        echo "🧪 启动测试环境..."
        flutter run --dart-define=FLUTTER_ENV=testing
        ;;
    3)
        echo "🏭 启动生产环境..."
        flutter run --dart-define=FLUTTER_ENV=production
        ;;
    4)
        echo "📱 启动 iOS 模拟器..."
        flutter run -d ios
        ;;
    5)
        echo "🤖 启动 Android 模拟器..."
        flutter run -d android
        ;;
    6)
        echo "🌐 启动 Web 浏览器..."
        flutter run -d web-server --web-renderer html
        ;;
    7)
        echo "⚡ 启动性能模式..."
        flutter run --profile
        ;;
    8)
        echo "🧹 清理并重新构建..."
        flutter clean
        flutter pub get
        echo "✅ 清理完成，现在启动开发环境..."
        flutter run --dart-define=FLUTTER_ENV=development
        ;;
    *)
        echo "❌ 无效选择，退出"
        exit 1
        ;;
esac
