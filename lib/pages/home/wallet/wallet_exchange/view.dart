import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class WalletExchangePage extends GetView<WalletExchangeController> {
  const WalletExchangePage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("WalletExchangePage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletExchangeController>(
      init: WalletExchangeController(),
      id: "wallet_exchange",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("wallet_exchange")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
