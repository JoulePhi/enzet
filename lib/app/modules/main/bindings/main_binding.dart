import 'package:enzet/app/data/contollers/navigation_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
    );
  }
}
