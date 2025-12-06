import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class WalletScanPage extends GetView<WalletScanController> {
  const WalletScanPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("WalletScanPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletScanController>(
      init: WalletScanController(),
      id: "wallet_scan",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("wallet_scan")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
