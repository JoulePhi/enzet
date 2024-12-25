import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/utils/formatter.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Invoice')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Invoice Items List
                const Text(
                  'Daftar Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() {
                    if (controller.items.isEmpty) {
                      return const Center(child: Text('Item tidak ditemukan'));
                    }
                    return ListView.builder(
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        return _buildInvoiceItem(context, item, index);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),

                // Invoice Details Form
                TextFormField(
                  controller: controller.receiverController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Penerima',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama penerima harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: controller.senderController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Pengirim',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama pengirim harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: controller.noteController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: controller.messageController,
                  decoration: const InputDecoration(
                    labelText: 'Pesan',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // QC Fields
                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('QC 1'),
                            Checkbox(
                              value: controller.qc1.value,
                              onChanged: (value) {
                                controller.qc1.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('QC 2'),
                            Checkbox(
                              value: controller.qc2.value,
                              onChanged: (value) {
                                controller.qc2.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('QC 3'),
                            Checkbox(
                              value: controller.qc3.value,
                              onChanged: (value) {
                                controller.qc3.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return DropdownButton<InvoiceStatus>(
                    value: controller.selectedStatus.value,
                    isExpanded: true,
                    onChanged: (InvoiceStatus? newValue) {
                      if (newValue != null) {
                        controller.updateStatus(newValue);
                      }
                    },
                    items: InvoiceStatus.values.map((InvoiceStatus status) {
                      return DropdownMenuItem<InvoiceStatus>(
                        value: status,
                        child: Text(Formatter.convertCamelCaseToTitleCase(
                            status.toString().split('.').last)),
                      );
                    }).toList(),
                  );
                }),
                // Total
                const SizedBox(height: 20),
                Obx(() => Text(
                    'Total: ${Formatter.formatToRupiah(controller.total.value)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.items.isEmpty) {
                        errorSnackbar("Item tidak boleh kosong");
                        return;
                      }
                      if (controller.formKey.currentState!.validate()) {
                        final storeId = Get.find<StoresController>()
                            .selectedStore
                            .value!
                            .documentId;
                        final invoice = Invoice(
                          id: 'INV${DateTime.now().millisecondsSinceEpoch}',
                          storeId: storeId.toString(),
                          items: controller.items.toList(),
                          total: controller.total.value,
                          code: 'CODE${DateTime.now().millisecondsSinceEpoch}',
                          note: controller.noteController.text,
                          receiver: controller.receiverController.text,
                          sender: controller.senderController.text,
                          qc1: controller.qc1.value,
                          qc2: controller.qc2.value,
                          qc3: controller.qc3.value,
                          message: controller.messageController.text,
                          status: controller.selectedStatus.value,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        controller.generatePdf(invoice);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: controller.isLoadding.value
                          ? const CircularProgressIndicator()
                          : const Text('Buat Invoice'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceItem(BuildContext context, InvoiceItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.item.name} (${item.item.code})",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(Formatter.formatToRupiah(item.subtotal)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => controller.decreaseQuantity(index),
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => controller.increaseQuantity(index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
