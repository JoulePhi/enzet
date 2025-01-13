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
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = GetPlatform.isWeb || kIsWeb;

    return Scaffold(
      appBar: isWeb
          ? null
          : AppBar(
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
        padding: EdgeInsets.symmetric(
          horizontal: isWeb ? screenWidth * 0.1 : 16.0,
          vertical: 16.0,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isWeb
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: const Text(
                            'Pilih Toko yang akan diakses',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : const Text(
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
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _getCrossAxisCount(screenWidth),
                              crossAxisSpacing: isWeb ? 20 : 10,
                              mainAxisSpacing: isWeb ? 20 : 10,
                              childAspectRatio: isWeb ? 2 : 1.5,
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
                  child: Center(
                    child: SizedBox(
                      width: isWeb ? 400 : double.infinity,
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
                        MaterialStateProperty.all(AppStyle.tarawera),
                  ),
                  onPressed: () {
                    if (controller.selectedStore.value != null) {
                      showAddOrEditStoreDialog(
                          context, controller.selectedStore.value!);
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (kIsWeb) {
      if (width > 1200) return 4;
      if (width > 800) return 3;
      return 2;
    }
    return 2;
  }
}

Future<void> showAddOrEditStoreDialog(BuildContext context,
    [StoreModel? store]) {
  if (GetPlatform.isWeb || kIsWeb) {
    return showDialog(
      context: context,
      builder: (context) => AddOrEdit(store: store),
    );
  }
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => AddOrEdit(store: store),
  );
}
