import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<StoresController>()) {
      Get.offAllNamed(Routes.STORES);
    }

    final storeController = Get.find<StoresController>();
    final store = storeController.selectedStore;
    print('StoreMiddleware: ${store.value}');
    if (store.value == null) {
      Get.offAllNamed(Routes.STORES);
    }
    return null;
  }
}
