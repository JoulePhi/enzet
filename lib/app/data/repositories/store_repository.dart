import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addStore(StoreModel store) async {
    String? imageUrl;
    if (store.image != null) {
      imageUrl = await _uploadImage(store.image!);
    }
    await _firestore
        .collection('stores')
        .add(store.copyWith(image: imageUrl).toJson());
  }

  Future<void> updateStore(StoreModel store) async {
    if (store.documentId.isNotEmpty) {
      String? imageUrl = store.image;
      if (store.image != null && !store.image!.startsWith('http')) {
        imageUrl = await _uploadImage(store.image!);
      }

      await _firestore.collection('stores').doc(store.documentId).update(
            store.copyWith(image: imageUrl).toJson(),
          );
    } else {
      throw Exception('Document ID is null. Cannot update store.');
    }
  }

  Stream<List<StoreModel>> getStores() {
    return _firestore
        .collection('stores')
        .orderBy('id')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return StoreModel.fromJson({
                ...data,
                'documentId': doc.id,
              });
            }).toList());
  }

  Future<String> _uploadImage(String filePath) async {
    final fileName = filePath.split('/').last;
    final ref = _storage.ref().child('stores/$fileName');
    await ref.putFile(File(filePath));
    return await ref.getDownloadURL();
  }
}
