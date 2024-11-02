import 'package:get/get.dart';

import '../controllers/lists_controller.dart';

class ListsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListsController>(
      () => ListsController(),
    );
  }
}
