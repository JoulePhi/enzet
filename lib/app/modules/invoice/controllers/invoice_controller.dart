import 'dart:convert';

import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/models/item_model.dart';
import 'package:enzet/app/data/services/pdf_service.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final receiverController = TextEditingController();
  final senderController = TextEditingController();
  final noteController = TextEditingController();
  final messageController = TextEditingController();
  final qc1 = false.obs;
  final qc2 = false.obs;
  final qc3 = false.obs;
  final selectedStatus = InvoiceStatus.newOrder.obs;
  final fromDetail = false.obs;
  final pdfService = PdfService();
  var total = 0.0.obs;
  var items = <InvoiceItem>[].obs;
  final isLoadding = false.obs;

  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = jsonEncode(items.map((item) => item.toJson()).toList());
    final int storeId = Get.find<StoresController>().selectedStore.value!.id;
    await prefs.setString('invoice_items/$storeId', itemsJson);
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final int storeId = Get.find<StoresController>().selectedStore.value!.id;
    final itemsJson = prefs.getString('invoice_items/$storeId');
    if (itemsJson != null) {
      final List<dynamic> itemList = jsonDecode(itemsJson);
      items.value = itemList.map((item) => InvoiceItem.fromJson(item)).toList();
      calculateTotal();
    }
  }

  void addItem(InvoiceItem item) {
    final existingItemIndex =
        items.indexWhere((i) => i.item.id == item.item.id);
    if (existingItemIndex != -1) {
      increaseQuantity(existingItemIndex);
    } else {
      items.add(item);
      calculateTotal();
    }
    if (!fromDetail.value) {
      saveItems();
    }
  }

  void removeItem(InvoiceItem item) {
    items.remove(item);
    calculateTotal();
    if (!fromDetail.value) {
      saveItems();
    }
  }

  void increaseQuantity(int index) {
    final item = items[index];
    items[index] = item.copyWith(
      quantity: item.quantity + 1,
      subtotal: (item.quantity + 1) * item.item.price,
    );
    calculateTotal();
    if (!fromDetail.value) {
      saveItems();
    }
  }

  void decreaseQuantity(int index) {
    final item = items[index];
    if (item.quantity > 1) {
      items[index] = item.copyWith(
        quantity: item.quantity - 1,
        subtotal: (item.quantity - 1) * item.item.price,
      );
      calculateTotal();
    } else {
      // show confirmation dialog
      if (!fromDetail.value) {
        Get.defaultDialog(
          title: 'Konfirmasi',
          middleText: 'Apakah Anda yakin ingin menghapus item ini?',
          textConfirm: 'Ya',
          textCancel: 'Tidak',
          onConfirm: () {
            removeItem(item);
            Get.back();
          },
          onCancel: () {
            // Get.back();
          },
        );
      }
    }
    if (!fromDetail.value) {
      saveItems();
    }
  }

  void updateStatus(InvoiceStatus status) {
    selectedStatus.value = status;
  }

  void calculateTotal() {
    total.value = items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  @override
  void onInit() {
    initializeItems(itemArgument: Get.arguments as ItemModel?);
    super.onInit();
  }

  void initializeItems({ItemModel? itemArgument}) {
    if (itemArgument != null) {
      fromDetail.value = true;
      final item = Get.arguments as ItemModel;
      final invoiceItem = InvoiceItem(
        item: item,
        quantity: 1,
        subtotal: item.price,
      );
      items.clear();
      addItem(invoiceItem);
    } else {
      fromDetail.value = false;
      loadItems();
    }
  }

  @override
  void onClose() {
    // Dispose of controllers
    receiverController.dispose();
    senderController.dispose();
    noteController.dispose();
    messageController.dispose();
    qc1.value = false;
    qc2.value = false;
    qc3.value = false;
    super.onClose();
  }

  void clearForm() {
    receiverController.clear();
    senderController.clear();
    noteController.clear();
    messageController.clear();
    qc1.value = false;
    qc2.value = false;
    qc3.value = false;
    items.clear();
    total.value = 0;
  }

  Future<void> generatePdf(Invoice invoice) async {
    try {
      isLoadding.value = true;
      pdfService.generatePurchaseOrder(invoice: invoice);
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isLoadding.value = false;
    }
  }
}
