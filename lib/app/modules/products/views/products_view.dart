import 'package:enzet/app/data/widgets/product_card.dart';
import 'package:enzet/theme/styles.dart';
import 'package:enzet/theme/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyle.defaultPadding,
          vertical: AppStyle.mediumPadding,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchItems();
          },
          child: ListView(
            // physics: const BouncingScrollPhysics(),
            children: [
              TextField(
                style: AppStyle.textBlack.copyWith(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Search product',
                  hintStyle: AppStyle.textGrey.copyWith(
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: AppStyle.lightGrey,
                    ),
                  ),
                ),
                onChanged: controller.onSearchChanged,
              ),
              verticalSpace(AppStyle.largePadding),
              Text(
                'List Products',
                style: AppStyle.textBlack.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(AppStyle.largePadding),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : (controller.items.isEmpty
                        ? const Center(child: Text('No data'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              final item = controller.items[index];
                              return ProductCard(item: item);
                            },
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
