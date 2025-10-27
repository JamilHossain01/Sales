// custom_snackbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSuccess(String message,) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 1),
    );
  }

  static void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}
