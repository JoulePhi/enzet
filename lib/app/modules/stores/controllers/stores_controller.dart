import 'package:enzet/app/data/repositories/store_repository.dart';
import 'package:enzet/app/data/utils/utils.dart';
import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:get/get.dart';

class StoresController extends GetxController {
  final Rx<StoreModel?> selectedStore = Rx<StoreModel?>(null);
  final addStoreLoading = false.obs;

  final StoreRepository _repository = StoreRepository();
  final RxList<StoreModel> stores = <StoreModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenToStores();
  }

  void _listenToStores() {
    _repository.getStores().listen((stores) {
      this.stores.value = stores;

      stores.add(StoreModel(id: 0, name: 'add', code: '-', isSelected: false));
    });
  }
}
