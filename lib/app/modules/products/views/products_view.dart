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
        child: ListView(
          physics: const BouncingScrollPhysics(),
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
            const ProductCard(
                image: 'assets/images/product1.webp',
                title: 'Dompet Kulit',
                total: '20',
                code: 'NKC644'),
            const ProductCard(
                image: 'assets/images/product1.webp',
                title: 'Dompet Kulit',
                total: '20',
                code: 'NKC644'),
            const ProductCard(
                image: 'assets/images/product1.webp',
                title: 'Dompet Kulit',
                total: '20',
                code: 'NKC644'),
          ],
        ),
      ),
    );
  }
}
