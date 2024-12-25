import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Email and password cannot be empty';
      }
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offAllNamed(AppPages.AUTHENTICATED);
    } catch (e) {
      if (kDebugMode) print(e);
      errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
