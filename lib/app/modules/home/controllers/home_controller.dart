import 'package:enzet/app/data/repositories/item_repository.dart';
import 'package:enzet/app/modules/stores/controllers/stores_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final totalItem = 0.obs;
  final totalInvoice = 0.obs;
  final _itemRepository = ItemRepository();
  final _storeController = Get.find<StoresController>();
  @override
  void onInit() {
    super.onInit();
    _itemRepository
        .countTotalItems(
            _storeController.selectedStore.value!.documentId.toString())
        .then((value) {
      totalItem.value = value;
    });
  }
}
