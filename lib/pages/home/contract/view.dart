import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class ContractPage extends GetView<ContractController> {
  const ContractPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("ContractPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractController>(
      init: ContractController(),
      id: "contract",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("contract")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
