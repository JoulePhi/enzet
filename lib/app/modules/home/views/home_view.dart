import 'package:enzet/app/modules/home/views/widgets/home_card.dart';
import 'package:enzet/app/data/widgets/product_card.dart';
import 'package:enzet/theme/styles.dart';
import 'package:enzet/theme/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monday',
                      style: AppStyle.textDarkGrey.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '25 October',
                      style: AppStyle.textBlack.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppStyle.lightGrey,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.search_rounded,
                      size: 20, color: AppStyle.lightBlack),
                )
              ],
            ),
            verticalSpace(AppStyle.largePadding),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeCard(
                    colors: const [
                      Color(0xffA9FFEA),
                      Color(0xff00B288),
                    ],
                    title: 'Total Products',
                    value: controller.totalItem.value.toString(),
                  ),
                   HomeCard(
                    colors: const [
                      Color(0xffFFA0BC),
                      Color(0xffFF1B5E),
                    ],
                    title: 'Invoice Generated',
                    value: controller.totalInvoice.value.toString(),
                  ),
                ],
              ),
            ),
            verticalSpace(AppStyle.largePadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Top Products',
                  style: AppStyle.textBlack.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  size: 14,
                  Icons.arrow_forward_ios_rounded,
                  color: AppStyle.black,
                ),
              ],
            ),
            verticalSpace(AppStyle.defaultPadding),
            // const ProductCard(
            //     image: 'assets/images/product1.webp',
            //     title: 'Dompet Kulit',
            //     total: '20',
            //     code: 'NKC644'),
            // const ProductCard(
            //     image: 'assets/images/product1.webp',
            //     title: 'Dompet Kulit',
            //     total: '20',
            //     code: 'NKC644'),
            // const ProductCard(
            //     image: 'assets/images/product1.webp',
            //     title: 'Dompet Kulit',
            //     total: '20',
            //     code: 'NKC644'),
          ],
        ),
      ),
    );
  }
}
