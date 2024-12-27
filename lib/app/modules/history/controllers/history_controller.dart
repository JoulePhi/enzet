import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/repositories/invoice_repository.dart';
import 'package:enzet/app/data/services/pdf_service.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final _invoiceRepository = InvoiceRepository();
  final items = <Invoice>[].obs;
  final isLoading = false.obs;
  final pdfService = PdfService();
  final isLoadding = false.obs;

  Future<void> fetchInvoices() async {
    try {
      isLoading.value = true;
      final storeId =
          Get.find<StoresController>().selectedStore.value!.documentId;
      items.value = await _invoiceRepository.getInvoices(storeId);
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchInvoices();
  }

  Future<void> generatePdf(Invoice invoice) async {
    try {
      isLoadding.value = true;
      pdfService
          .generatePurchaseOrder(invoice: invoice, callback: () async {})
          .then((e) async {
        if (e) {
          successSnackbar('PDF berhasil disimpan');
        }
      });
    } catch (e) {
      errorSnackbar(e.toString());
    } finally {
      isLoadding.value = false;
    }
  }
}
