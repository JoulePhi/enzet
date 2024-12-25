import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationController extends GetxController {
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(value) => _selectedIndex.value = value;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

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
      default:
        Get.offNamed('/home', id: 1);
    }
    selectedIndex = index;
  }
}
