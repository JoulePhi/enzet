import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationController extends GetxController {
  final _selectedIndex = 0.obs;
  final _isSidebarCollapsed = false.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(value) => _selectedIndex.value = value;
  bool get isSidebarCollapsed => _isSidebarCollapsed.value;

  // final List<GlobalKey<NavigatorState>> navigatorKeys = [
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  //   GlobalKey<NavigatorState>(),
  // ];

  @override
  void onInit() {
    super.onInit();
    // navigatorKeys.clear();
    // navigatorKeys
    //     .addAll(List.generate(4, (index) => GlobalKey<NavigatorState>()));
  }

  void changePage(int index) {
    switch (index) {
      case 0:
        Get.offNamed('/home', id: 1);
        break;
      case 1:
        Get.offNamed('/products', id: 1);
        break;
      case 2:
        Get.offNamed('/insert', id: 1);
        break;
      case 3:
        Get.offNamed('/profile', id: 1);
        break;
      default:
        Get.offNamed('/home', id: 1);
    }
    selectedIndex = index;
  }

  void toggleSidebar() {
    _isSidebarCollapsed.value = !_isSidebarCollapsed.value;
  }
}
