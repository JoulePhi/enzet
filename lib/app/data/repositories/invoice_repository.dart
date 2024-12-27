import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enzet/app/data/models/invoice_model.dart';
import 'package:enzet/app/data/models/item_model.dart';

class InvoiceRepository {
  final int limit = 20;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Invoice>> getInvoices(String storeId) async {
    var query = _firestore
        .collection('stores')
        .doc(storeId)
        .collection('invoices')
        .orderBy('createdAt', descending: true);

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => Invoice.fromJson({
              ...doc.data(),
              'documentId': doc.id,
            }))
        .toList();
  }

  Future<void> addInvoice(String storeId, Invoice invoice) async {
    try {
      await _firestore
          .collection('stores')
          .doc(storeId)
          .collection('invoices')
          .add(invoice.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<int> countTotalItems(String storeId) async {
    final querySnapshot = await _firestore
        .collection('stores')
        .doc(storeId)
        .collection('invoices')
        .get();
    return querySnapshot.docs.length;
  }

  Future<List<ItemModel>> searchInvoice(String storeId, String query) async {
    query = query.toUpperCase();
    final querySnapshot = await _firestore
        .collection('stores')
        .doc(storeId)
        .collection('items')
        .where('code', isGreaterThanOrEqualTo: query)
        .where('code', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return querySnapshot.docs.map((doc) {
      return ItemModel.fromJson({
        ...doc.data(),
        'documentId': doc.id,
      });
    }).toList();
  }

  Future<ItemModel?> getInvoice(String itemId) async {
    final docSnapshot = await _firestore.collection('items').doc(itemId).get();
    if (docSnapshot.exists) {
      return ItemModel.fromJson(docSnapshot.data()!);
    }
    return null;
  }
}
