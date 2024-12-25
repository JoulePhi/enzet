import 'package:cached_network_image/cached_network_image.dart';
import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/utils/formatter.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final product = controller.product.value;
        if (product == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              foregroundColor: Colors.blue,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final newItem =
                        await Get.toNamed('/insert', arguments: product);
                    if (newItem != null && newItem is ItemModel) {
                      successSnackbar('Item berhasil diperbarui');
                      controller.product.value = newItem;
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          controller.changeImage(index);
                        },
                      ),
                      items: product.imageUrls.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            // return Image.network(
                            //   image,
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            // );
                            return CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    // Image indicator
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            product.imageUrls.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentImageIndex.value ==
                                      entry.key
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Formatter.formatToRupiah(product.price),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection('Kode', product.code),
                    _buildInfoSection('Material', product.material),
                    _buildInfoSection('Warna', product.color),
                    _buildInfoSection('Supplier', product.supplier),
                    _buildInfoSection('Printing', product.printing),
                    _buildInfoSection('Artikel', product.article),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => controller.addToList(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.buyNow(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Cetak Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

Widget _buildInfoSection(String title, String? content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          content ?? '-',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}
