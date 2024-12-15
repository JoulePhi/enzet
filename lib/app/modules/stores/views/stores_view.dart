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
    List<StoreModel> stores = [
      StoreModel(id: 1, name: 'Enzet', code: 'en', isSelected: false),
      StoreModel(id: 2, name: 'Poppins', code: 'en', isSelected: false),
      StoreModel(id: -1, name: 'add', code: '-', isSelected: false),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Toko'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => StoreCard(
                      store: stores[index],
                      isSelected:
                          controller.selectedStore.value == stores[index].id,
                      onTap: () {
                        // setState(() {
                        //   languages[index].isSelected =
                        //       !languages[index].isSelected;
                        // });
                        if (stores[index].name == 'add' &&
                            stores[index].code == '-') {
                          _showAddLanguageDialog(context);
                        } else {
                          // controller.selectedStore.value = stores[index].id;
                          Get.toNamed(Routes.MAIN);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            // add continue button

            // ElevatedButton(
            //   onPressed: () {
            //     // Get.toNamed(Routes.HOME);
            //   },
            //   child: const Text('Continue'),
            // ),
          ],
        ),
      ),
    );
  }
}

void _showAddLanguageDialog(BuildContext context) {
  String newLanguageName = '';
  String newLanguageCode = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add New Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Language Name',
                hintText: 'Enter language name',
              ),
              onChanged: (value) {
                newLanguageName = value;
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Language Code',
                hintText: 'Enter language code (e.g., en, id)',
              ),
              onChanged: (value) {
                newLanguageCode = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newLanguageName.isNotEmpty && newLanguageCode.isNotEmpty) {
                // setState(() {
                //   languages.add(Language(
                //     name: newLanguageName,
                //     code: newLanguageCode,
                //     isSelected: false,
                //   ));
                // });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
