import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final storeController = Get.find<StoresController>();
    final storeId = storeController.selectedStore;
    if (storeId.value == 0 || storeId.value == -1) {
      Get.offAllNamed(Routes.STORES);
    }
    return null;
  }
}
