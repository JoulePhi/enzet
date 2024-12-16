import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/repositories/item_repository.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final supplierController = TextEditingController();
  final typeController = TextEditingController();
  final materialController = TextEditingController();
  final colorController = TextEditingController();
  final priceController = TextEditingController();
  final printingController = TextEditingController();
  final articleController = TextEditingController();

  final _itemRepository = ItemRepository();

  RxList<String> imageUrls = <String>[].obs;
  RxBool isActive = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    codeController.dispose();
    supplierController.dispose();
    typeController.dispose();
    materialController.dispose();
    colorController.dispose();
    priceController.dispose();
    printingController.dispose();
    articleController.dispose();
    super.onClose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final storeId = Get.find<StoresController>().selectedStore.value;
      final item = ItemModel(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // Atau gunakan UUID
        storeId: storeId.toString(), // Sesuaikan dengan kebutuhan
        supplier: supplierController.text,
        type: typeController.text,
        name: nameController.text,
        code: codeController.text,
        material: materialController.text,
        color: colorController.text,
        price: double.parse(priceController.text),
        imageUrls: imageUrls,
        printing: printingController.text,
        article: articleController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: isActive.value,
      );
      _itemRepository.addItem(storeId.toString(), item);

      Get.back(); // Kembali ke halaman sebelumnya
      Get.snackbar('Sukses', 'Item berhasil ditambahkan');
    }
  }
}
