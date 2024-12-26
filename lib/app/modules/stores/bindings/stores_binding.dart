import 'package:get/get.dart';

import '../controllers/stores_controller.dart';
import '../controllers/add_or_edit_controller.dart';

class StoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StoresController>(
      StoresController(),
      permanent: true,
    );
    Get.lazyPut(
      () => AddOrEditController(),
    );
  }
}
