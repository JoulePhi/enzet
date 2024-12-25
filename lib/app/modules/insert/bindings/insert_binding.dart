import 'package:get/get.dart';

import '../controllers/insert_controller.dart';

class InsertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsertController>(
      () => InsertController(),
    );
  }
}
