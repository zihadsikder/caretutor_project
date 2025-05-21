import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {

  static void showSuccess(String message, {String title = 'Success'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      borderRadius: 10.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      duration: const Duration(seconds: 3),
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 30,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static showCustomErrorSnackBar({required String title, required String message,Color? color,Duration? duration})
  {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
      colorText: Colors.white,
      backgroundColor: color ?? Colors.redAccent,
      icon: const Icon(Icons.error, color: Colors.white,),
    );
  }

  static void showError(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
      borderRadius: 10.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      duration: const Duration(seconds: 3),
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 30,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}