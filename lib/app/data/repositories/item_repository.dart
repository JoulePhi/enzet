import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enzet/app/data/models/item_model.dart';

class ItemRepository {
  final int limit = 20;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ItemModel>> getItems(String storeId) async {
    var query = _firestore
        .collection('items')
        .where('storeId', isEqualTo: storeId)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    final snapshot = await query.get();
    if (snapshot.docs.length < limit) hasMore = false;
    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }

    return snapshot.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();
  }

  Future<void> addItem(String storeId, ItemModel item) async {
    await _firestore.collection('items').add(item.toJson());
  }
}
