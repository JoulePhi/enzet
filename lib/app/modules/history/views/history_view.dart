import 'package:enzet/app/modules/history/widgets/invoice_card.dart';
import 'package:enzet/theme/styles.dart';
import 'package:enzet/theme/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: AppStyle.textBlack.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyle.defaultPadding,
          vertical: AppStyle.mediumPadding,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            // controller.fetchItems();
          },
          child: ListView(
            // physics: const BouncingScrollPhysics(),
            children: [
              // TextField(
              //   style: AppStyle.textBlack.copyWith(
              //     fontSize: 14,
              //   ),
              //   decoration: InputDecoration(
              //     hintText: 'Search product',
              //     hintStyle: AppStyle.textGrey.copyWith(
              //       fontSize: 14,
              //     ),
              //     prefixIcon: const Icon(Icons.search_rounded, size: 20),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       borderSide: const BorderSide(
              //         color: AppStyle.lightGrey,
              //       ),
              //     ),
              //   ),
              //   onChanged:,
              // ),
              // verticalSpace(AppStyle.largePadding),
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
                              return InvoiceCard(invoice: item);
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
