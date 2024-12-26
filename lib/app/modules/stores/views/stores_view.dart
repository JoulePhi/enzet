import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:enzet/app/modules/stores/views/add_or_edit_store.dart';
import 'package:enzet/app/modules/stores/widgets/store_card.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:enzet/theme/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/stores_controller.dart';

class StoresView extends GetView<StoresController> {
  const StoresView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Toko',
          style: AppStyle.textWhite.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: AppStyle.robinsEggBlue,
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
                              return Obx(
                                () => StoreCard(
                                  store: controller.stores[index],
                                  isSelected: controller.selectedStore.value !=
                                          null
                                      ? (controller.selectedStore.value!.id ==
                                          controller.stores[index].id)
                                      : false,
                                  onTap: () {
                                    if (controller.stores[index].name ==
                                            'add' &&
                                        controller.stores[index].code == '-') {
                                      controller.selectedStore.value = null;
                                      showAddOrEditStoreDialog(context, null);
                                    } else {
                                      if (controller.selectedStore.value ==
                                          null) {
                                        controller.selectedStore.value =
                                            controller.stores[index];
                                        // print(
                                        //     'Store : ${controller.selectedStore}');
                                      } else {
                                        if (controller
                                                .selectedStore.value!.id !=
                                            controller.stores[index].id) {
                                          controller.selectedStore.value =
                                              controller.stores[index];
                                        } else {
                                          controller.selectedStore.value = null;
                                        }
                                      }
                                    }
                                  },
                                  onLongPress: () {
                                    if (kDebugMode) {
                                      print('Long press');
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
            Obx(
              () => AnimatedPositioned(
                bottom: controller.selectedStore.value != null ? 0 : -100,
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
                      backgroundColor: AppStyle.robinsEggBlue,
                    ),
                    child: Text(
                      'Continue',
                      style: AppStyle.textWhite.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                bottom: 80,
                right: controller.selectedStore.value != null ? 20 : -100,
                duration: const Duration(milliseconds: 100),
                child: IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppStyle.tarawera),
                    ),
                    onPressed: () {
                      if (controller.selectedStore.value != null) {
                        showAddOrEditStoreDialog(
                            context, controller.selectedStore.value!);
                      }
                    },
                    icon: const Icon(Icons.edit)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showAddOrEditStoreDialog(BuildContext context,
    [StoreModel? store]) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => AddOrEdit(store: store),
  );
}
