import 'package:enzet/app/data/contollers/auth_controller.dart';
import 'package:enzet/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    // Get.put(InvoiceController(), permanent: true);
  }
}
