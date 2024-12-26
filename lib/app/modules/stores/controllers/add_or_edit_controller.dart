import 'package:enzet/app/data/repositories/store_repository.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrEditController extends GetxController {
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final selectedImagePath = ''.obs;

  final Rx<StoreModel?> store = Rx<StoreModel?>(null);
  final addStoreLoading = false.obs;
  final isEdit = false.obs;

  final StoreRepository _repository = StoreRepository();

  Future<void> addStore(StoreModel store) async {
    try {
      if (selectedImagePath.value.isEmpty) {
        errorSnackbar('Please select an image');
        return;
      }
      store = store.copyWith(image: selectedImagePath.value);
      addStoreLoading.value = true;
      await _repository.addStore(store);
      resetForm();
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      addStoreLoading.value = false;
    }
  }

  Future<void> updateStore(StoreModel store) async {
    try {
      if (selectedImagePath.value.isEmpty) {
        errorSnackbar('Please select an image');
        return;
      }
      store = store.copyWith(image: selectedImagePath.value);
      addStoreLoading.value = true;
      await _repository.updateStore(store);
      resetForm();
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      addStoreLoading.value = false;
    }
  }

  void removeImage([String path = '']) {
    if (path.isNotEmpty) {
      _repository.deleteImage(store.value!.image!);
    } else {
      selectedImagePath.value = '';
    }
  }

  void resetForm() {
    nameController.clear();
    codeController.clear();
    selectedImagePath.value = '';
    store.value = null;
  }
}
