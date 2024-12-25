import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/repositories/item_repository.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/utils/utils.dart';

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
  ItemModel? item;

  final ImagePicker _picker = ImagePicker();
  final RxList<File> selectedImages = <File>[].obs;
  final RxBool isUploading = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ItemModel) {
      item = Get.arguments;
      if (item != null) {
        nameController.text = item!.name;
        codeController.text = item!.code;
        supplierController.text = item!.supplier;
        typeController.text = item!.type;
        materialController.text = item!.material;
        colorController.text = item!.color;
        priceController.text = item!.price.toString();
        printingController.text = item!.printing ?? '';
        articleController.text = item!.article ?? '';
        if (item!.imageUrls.isNotEmpty) {
          imageUrls.addAll(item!.imageUrls);
        }
      }
    }
  }

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

  void resetForm() {
    nameController.text = '';
    codeController.text = '';
    supplierController.text = '';
    typeController.text = '';
    materialController.text = '';
    colorController.text = '';
    priceController.text = '';
    printingController.text = '';
    articleController.text = '';
    selectedImages.clear();
  }

  void submitForm() async {
    try {
      isLoading.value = true;

      if (formKey.currentState!.validate()) {
        final storeId =
            Get.find<StoresController>().selectedStore.value!.documentId;

        ItemModel itemToSave = ItemModel(
          id: item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          documentId: item?.documentId ?? '',
          storeId: storeId,
          supplier: supplierController.text,
          type: typeController.text,
          name: nameController.text,
          code: codeController.text,
          material: materialController.text,
          color: colorController.text,
          price: double.parse(priceController.text),
          imageUrls: [],
          printing: printingController.text,
          article: articleController.text,
          createdAt: item?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
          isActive: isActive.value,
        );
        if (selectedImages.isNotEmpty) {
          // if (item != null) {
          //   // await deleteOldImages(item!.imageUrls);
          // }
          // final newImageUrls =
          //     await _itemRepository.uploadImages(selectedImages);
          // itemToSave.imageUrls.addAll(newImageUrls);
        } else if (item != null) {
          itemToSave = itemToSave.copyWith(imageUrls: item!.imageUrls);
        }
        if (item != null) {
          await _itemRepository.updateItem(
              storeId, item!.documentId, itemToSave);
          Get.back(result: itemToSave);
        } else {
          // print('itemToSave: ${itemToSave.toJson()}');
          await _itemRepository.addItem(storeId, itemToSave, selectedImages);
          resetForm();
          successSnackbar('Item berhasil ditambahkan');
        }
      }
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteOldImages(List<String> oldImageUrls) async {
    try {
      for (String url in oldImageUrls) {
        String fileName = getFileNameFromUrl(url);
        await _itemRepository.deleteImage(fileName);
      }
    } catch (e) {
      errorSnackbar("Gagal menghapus gambar");
    }
  }

  Future<void> deleteOldImage(String url) async {
    try {
      String fileName = getFileNameFromUrl(url);
      await _itemRepository.deleteImage(fileName);
      imageUrls.remove(url);
    } catch (e) {
      errorSnackbar("Gagal menghapus gambar");
    }
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 70,
      );

      if (images.isNotEmpty) {
        selectedImages.addAll(images.map((image) => File(image.path)));
      }
    } catch (e) {
      errorSnackbar("Gagal memilih gambar");
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }
}
