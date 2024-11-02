import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lists_controller.dart';

class ListsView extends GetView<ListsController> {
  const ListsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ListsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
