import 'package:flutter/material.dart';
import 'package:get/get.dart';

successSnackbar(String message) {
  Get.snackbar(
    'Sukses',
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}

errorSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

String getFileNameFromUrl(String url) {
  List<String> parts = url.split('/');
  String filePathWithQuery = parts.last;
  String filePath = Uri.decodeFull(filePathWithQuery.split('?').first);
  return filePath;
}
