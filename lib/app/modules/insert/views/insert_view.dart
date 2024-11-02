import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/insert_controller.dart';

class InsertView extends GetView<InsertController> {
  const InsertView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InsertView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InsertView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
