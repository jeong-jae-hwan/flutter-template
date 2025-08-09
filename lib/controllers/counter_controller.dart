import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  final count = 0.obs;
  final name = "사용자".obs;
  final isVisible = true.obs;

  late TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    Get.log('🚀 CounterController 초기화 완료');
  }

  @override
  void onClose() {
    nameController.dispose();
    Get.log('🗑️ CounterController 정리 완료');
    super.onClose();
  }

  void increment() => count.value++;

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  void reset() => count.value = 0;

  void changeName() {
    final newName = nameController.text.trim();

    if (newName.isEmpty) {
      _showSnackbar('오류', '이름을 입력해주세요.', false);
      return;
    }

    if (newName.length > 20) {
      _showSnackbar('오류', '이름은 20자 이하로 입력해주세요.', false);
      return;
    }

    name.value = newName;
    nameController.clear();

    _showSnackbar('성공', '이름이 변경되었습니다!', true);
  }

  void toggleVisibility() => isVisible.value = !isVisible.value;

  void _showSnackbar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: isSuccess ? 2 : 3),
    );
  }

  bool get canDecrement => count.value > 0;
  bool get canReset => count.value != 0;
  bool get hasValidName => name.value.isNotEmpty && name.value != "사용자";
}
