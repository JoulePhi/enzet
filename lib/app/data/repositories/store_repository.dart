import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enzet/app/modules/stores/model/store_model.dart';

class StoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStore(StoreModel store) async {
    await _firestore.collection('stores').add(store.toJson());
  }

  Stream<List<StoreModel>> getStores() {
    return _firestore.collection('stores').orderBy('id').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => StoreModel.fromJson(doc.data()))
            .toList());
  }
}
