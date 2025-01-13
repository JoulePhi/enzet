import 'package:enzet/app/data/contollers/auth_controller.dart';
import 'package:enzet/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = GetPlatform.isWeb || kIsWeb;

    Widget loginForm() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
          ),
          const SizedBox(height: AppStyle.largePadding),
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
                  onPressed: () => controller.isPasswordVisible.toggle(),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppStyle.extraLargePadding),
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
                backgroundColor: AppStyle.robinsEggBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: authController.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      'Login',
                      style: AppStyle.textWhite.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: AppStyle.defaultPadding),
          // TextButton(
          //   onPressed: () {},
          //   child: const Text(
          //     'Forgot password?',
          //     style: TextStyle(color: Colors.amber),
          //   ),
          // ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: Get.height - AppStyle.extraLargePadding,
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? (screenWidth * 0.3) : AppStyle.defaultPadding,
            ),
            child: Center(
              child: isWeb
                  ? Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppStyle.extraLargePadding),
                        child: SizedBox(
                          width: 400,
                          height: 500,
                          child: loginForm(),
                        ),
                      ),
                    )
                  : loginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
