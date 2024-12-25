import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/repositories/item_repository.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:enzet/app/data/utils/debouncer.dart';

class ProductsController extends GetxController {
  final _itemRepository = ItemRepository();
  final items = <ItemModel>[].obs;
  final isLoading = false.obs;
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      final storeId =
          Get.find<StoresController>().selectedStore.value!.documentId;
      items.value = await _itemRepository.getItems(storeId);
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchItems(String query) async {
    try {
      isLoading.value = true;
      final storeId =
          Get.find<StoresController>().selectedStore.value!.documentId;
      items.value = await _itemRepository.searchItems(storeId, query);
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      _debouncer.cancel();
      fetchItems();
      return;
    }

    _debouncer.run(() async {
      try {
        isLoading.value = true;
        final storeId =
            Get.find<StoresController>().selectedStore.value!.documentId;
        items.value = await _itemRepository.searchItems(storeId, query);
      } catch (e) {
        if (kDebugMode) print(e.toString());
        errorSnackbar(e.toString());
      } finally {
        isLoading.value = false;
      }
    });
  }
}
