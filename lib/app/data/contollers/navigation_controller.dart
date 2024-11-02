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
    if (selectedIndex == index) {
      navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    }
    selectedIndex = index;
  }
}
