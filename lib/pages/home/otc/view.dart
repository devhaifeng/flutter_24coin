import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class OtcPage extends GetView<OtcController> {
  const OtcPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(child: Text("OtcPage"));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtcController>(
      init: OtcController(),
      id: "otc",
      builder: (_) {
        return Scaffold(
          backgroundColor: context.colors.scheme.surfaceContainerHighest,
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
