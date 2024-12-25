import 'dart:convert';

import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailController extends GetxController {
  final product = Rx<ItemModel?>(null);
  final currentImageIndex = 0.obs;
  final isAddingToCart = false.obs;

  @override
  void onInit() {
    super.onInit();
    ItemModel? productData = Get.arguments;
    if (productData != null) {
      product.value = productData;
    } else {
      Get.back();
    }
  }

  void setProduct(ItemModel productData) {
    product.value = productData;
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  void addItem(InvoiceItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString('invoice_items');
    if (itemsJson != null) {
      final List<dynamic> itemList = jsonDecode(itemsJson);
      final items = itemList.map((item) => InvoiceItem.fromJson(item)).toList();
      final existingItemIndex =
          items.indexWhere((i) => i.item.id == item.item.id);
      if (existingItemIndex != -1) {
        items[existingItemIndex] = items[existingItemIndex]
            .copyWith(quantity: items[existingItemIndex].quantity + 1);
      } else {
        items.add(item);
      }
      await prefs.setString('invoice_items',
          jsonEncode(items.map((item) => item.toJson()).toList()));
    }
  }

  Future<void> addToList() async {
    try {
      isAddingToCart.value = true;
      if (product.value != null) {
        final invoiceItem = InvoiceItem(
          item: product.value!,
          quantity: 1,
          subtotal: product.value!.price,
        );
        addItem(invoiceItem);
        successSnackbar('Produk ditambahkan ke daftar');
      } else {
        errorSnackbar('Produk tidak ditemukan');
      }
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isAddingToCart.value = false;
    }
  }

  void buyNow() {
    // final invoiceController = Get.find<InvoiceController>();
    // invoiceController.initializeItems(itemArgument: product.value);
    Get.toNamed(Routes.INVOICE, arguments: product.value);
  }
}
