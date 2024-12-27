import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enzet/app/data/models/item_model.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class ItemRepository {
  final int limit = 20;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<ItemModel>> getItems(String storeId) async {
    var query = _firestore
        .collection('stores')
        .doc(storeId)
        .collection('items')
        .orderBy('createdAt', descending: true);

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => ItemModel.fromJson({
              ...doc.data(),
              'documentId': doc.id,
            }))
        .toList();
  }

  Future<void> addItem(
      String storeId, ItemModel item, List<File> images) async {
    try {
      final querySnapshot = await _firestore
          .collection('stores')
          .doc(storeId)
          .collection('items')
          .where('code', isEqualTo: item.code)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw Exception('Item with code ${item.code} already exists.');
      }

      final results = await uploadImages(images);
      item.imageUrls.addAll(results);
      await _firestore
          .collection('stores')
          .doc(storeId)
          .collection('items')
          .add(item.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(String itemId) async {
    await _firestore.collection('items').doc(itemId).delete();
  }

  Future<void> updateItem(
      String storeId, String itemId, ItemModel updatedItem) async {
    await _firestore
        .collection('stores')
        .doc(storeId)
        .collection('items')
        .doc(itemId)
        .update(updatedItem.toJson());
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    try {
      for (File imageFile in images) {
        String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${path.basename(imageFile.path)}';
        Reference ref = _storage.ref().child('products/$fileName');

        await ref.putFile(imageFile);
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      rethrow;
    }

    return imageUrls;
  }

  Future<int> countTotalItems(String storeId) async {
    final querySnapshot = await _firestore
        .collection('stores')
        .doc(storeId)
        .collection('items')
        .get();
    return querySnapshot.docs.length;
  }

  Future<List<ItemModel>> searchItems(String storeId, String query) async {
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

  Future<ItemModel?> getItem(String itemId) async {
    final docSnapshot = await _firestore.collection('items').doc(itemId).get();
    if (docSnapshot.exists) {
      return ItemModel.fromJson(docSnapshot.data()!);
    }
    return null;
  }

  Future<void> deleteImage(String fileName) async {
    try {
      await _storage.ref().child(fileName).delete();
    } catch (e) {
      rethrow;
    }
  }
}
