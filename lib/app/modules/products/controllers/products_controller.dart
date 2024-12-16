import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/repositories/item_repository.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final _itemRepository = ItemRepository();
  final items = <ItemModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() async {
    isLoading.value = true;
    final storeId = Get.find<StoresController>().selectedStore.value;

    _itemRepository.getItems(storeId.toString()).then((value) {
      items.addAll(value);
      isLoading.value = false;
    });
  }
}
