import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class WalletUsdtReceivePage extends GetView<WalletUsdtReceiveController> {
  const WalletUsdtReceivePage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("WalletUsdtReceivePage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletUsdtReceiveController>(
      init: WalletUsdtReceiveController(),
      id: "wallet_usdt_receive",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("wallet_usdt_receive")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
