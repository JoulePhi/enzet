import 'package:enzet/app/data/contollers/auth_controller.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    authController.checkLoginStatus().then((isLoggedIn) {
      if (isLoggedIn && route == Routes.LOGIN) {
        Get.offAllNamed(Routes.MAIN);
      }
    });
    return null;
  }
}
