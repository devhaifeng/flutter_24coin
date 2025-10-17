import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class WalletUsdtSendPage extends GetView<WalletUsdtSendController> {
  const WalletUsdtSendPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("WalletUsdtSendPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletUsdtSendController>(
      init: WalletUsdtSendController(),
      id: "wallet_usdt_send",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("wallet_usdt_send")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
