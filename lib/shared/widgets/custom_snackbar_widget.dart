import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app_controller.dart';

void showDarkSnackbar(String title, String message) {
  Get.snackbar(
    title, // Snackbar title
    message, // Snackbar message
    //backgroundColor: Colors.black, // Background color
    colorText: Get.find<AppController>().isDarkModeOn.value
        ? Colors.white
        : Colors.black, // Text color
    snackPosition: SnackPosition.TOP, // Position of the snackbar
    borderRadius: 10, // Rounded corners
    margin: const EdgeInsets.all(10), // Margin around the snackbar
    duration: const Duration(
        seconds: 3), // Duration for which the snackbar is visible
    //icon:const Icon(Icons.dark_mode, color: Colors.white), // Optional icon
  );
}
