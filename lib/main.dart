import 'package:enzet/app/data/bindings/auth_binding.dart';
import 'package:enzet/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Enzet",
      initialRoute: AppPages.INITIAL,
      initialBinding: AuthBinding(),
      theme: AppTheme.lightTheme,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
