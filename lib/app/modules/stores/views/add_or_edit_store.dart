import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:enzet/app/modules/stores/controllers/add_or_edit_controller.dart';
import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:enzet/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddOrEdit extends GetView<AddOrEditController> {
  final StoreModel? store;
  const AddOrEdit({super.key, this.store});

  @override
  Widget build(BuildContext context) {
    if (store != null) {
      controller.store.value = store;
      controller.nameController.text = store!.name;
      controller.codeController.text = store!.code;
      controller.selectedImagePath.value = store!.image!;
      controller.isEdit.value = true;
    }
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.store.value != null ? 'Edit Toko' : 'Tambah Toko',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Toko',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama toko tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.codeController,
                      decoration: const InputDecoration(
                        labelText: 'Kode Toko',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kode toko tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.selectedImagePath.value.isEmpty
                          ? ElevatedButton(
                              onPressed: () async {
                                final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  controller.selectedImagePath.value =
                                      image.path;
                                }
                              },
                              child: const Text('Pilih Gambar'),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: !controller.isEdit.value
                                          ? Image.file(
                                              File(controller
                                                  .selectedImagePath.value),
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: controller
                                                  .selectedImagePath.value,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    top: 4,
                                    child: InkWell(
                                      onTap: () async {
                                        final image =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (image != null) {
                                          controller.isEdit.value = false;
                                          if (store != null) {
                                            controller
                                                .removeImage(store!.image!);
                                          }
                                          controller.selectedImagePath.value =
                                              image.path;
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: AppStyle.tarawera,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Batal',
                      style: AppStyle.textTarawera,
                    ),
                  ),
                  Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.robinsEggBlue,
                      ),
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          if (store != null) {
                            final updateStore = store!.copyWith(
                              name: controller.nameController.text,
                              code: controller.codeController.text,
                              image: controller.selectedImagePath.value,
                            );
                            await controller.updateStore(updateStore);
                          } else {
                            final newStore = StoreModel(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: controller.nameController.text,
                              code: controller.codeController.text,
                              isSelected: false,
                              image: controller.selectedImagePath.value,
                            );
                            await controller.addStore(newStore);
                          }
                          Get.back();
                        }
                      },
                      child: controller.addStoreLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : const Text(
                              'Simpan',
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
