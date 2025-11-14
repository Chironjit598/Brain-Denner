import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxBool showButton = false.obs;

  void onTextChanged(String value) {
    showButton.value = value.trim().isNotEmpty;
  }

  void submit() {
    focusNode.unfocus();
    final text = textController.text.trim();
    if (text.isEmpty) return;

    Get.snackbar(
      'Submitted',
      'You typed: $text',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}