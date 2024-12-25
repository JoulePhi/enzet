import 'package:enzet/app/data/contollers/auth_controller.dart';
import 'package:enzet/theme/styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppStyle.defaultPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: Get.height - AppStyle.extraLargePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logoipsum.png',
                    height: 80,
                  ),
                  const SizedBox(height: AppStyle.largePadding),
                  // Welcome Text
                  Text(
                    'Selamat Datang Kembali',
                    style: AppStyle.textBlack.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppStyle.defaultPadding),
                  Text(
                    'Silahkan login untuk melanjutkan',
                    style: AppStyle.textLightBlack.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: AppStyle.extraLargePadding),

                  // Email TextField
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppStyle.defaultPadding),
                  Obx(
                    () => TextField(
                      obscureText: !controller.isPasswordVisible.value,
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            controller.isPasswordVisible.toggle();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppStyle.extraLargePadding),

                  // Login Button
                  Obx(
                    () => ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : () {
                              authController.login(
                                controller.emailController.text,
                                controller.passwordController.text,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: authController.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: AppStyle.defaultPadding),

                  // Forgot Password
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
