import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:enzet/app/modules/stores/widgets/store_card.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/stores_controller.dart';

class StoresView extends GetView<StoresController> {
  const StoresView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Toko'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          // Changed from Column to Stack
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Toko yang akan diakses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => controller.stores.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: controller.stores.length,
                            itemBuilder: (context, index) {
                              return Obx(() => StoreCard(
                                    store: controller.stores[index],
                                    isSelected:
                                        controller.selectedStore.value ==
                                            controller.stores[index].id,
                                    onTap: () {
                                      if (controller.stores[index].name ==
                                              'add' &&
                                          controller.stores[index].code ==
                                              '-') {
                                        showAddStoreDialog(context);
                                      } else {
                                        if (controller.selectedStore.value !=
                                            controller.stores[index].id) {
                                          controller.selectedStore.value =
                                              controller.stores[index].id;
                                        } else {
                                          controller.selectedStore.value = 0;
                                        }
                                      }
                                    },
                                  ));
                            },
                          ),
                  ),
                ),
              ],
            ),
            Obx(
              () => AnimatedPositioned(
                bottom: controller.selectedStore.value != 0 ? 0 : -100,
                left: 0,
                right: 0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.MAIN, arguments: {
                        'storeId': controller.selectedStore.value,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showAddStoreDialog(BuildContext context) {
  // Controller untuk form
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedImagePath;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Tambah Store'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Form field untuk nama
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Store',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama store tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Form field untuk kode
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Kode Store',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode store tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Upload image button
              ElevatedButton.icon(
                onPressed: () async {
                  // Implementasi pick image
                  // Contoh menggunakan image_picker
                  // final ImagePicker picker = ImagePicker();
                  // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  // if (image != null) {
                  //   selectedImagePath = image.path;
                  // }
                },
                icon: const Icon(Icons.image),
                label: const Text('Pilih Gambar'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Tombol batal
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),

        // Tombol simpan
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // Buat objek store baru
              final newStore = StoreModel(
                id: DateTime.now().millisecondsSinceEpoch, // Contoh generate ID
                name: nameController.text,
                code: codeController.text,
                isSelected: false,
                image: selectedImagePath,
              );
              Get.find<StoresController>().addStore(newStore);

              // Tutup dialog dan kirim data store baru
              Navigator.pop(context, newStore);
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    ),
  );
}
