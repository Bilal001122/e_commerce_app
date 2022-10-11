import 'package:e_commerce_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  // brew list from snapshot
  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map<Product>(
          (doc) => Product(
            name: doc.get('name'),
            images: doc.get('images'),
            description: doc.get('desc'),
            price: doc.get('price'),
            sizes: doc.get('sizes'),
            id: doc.id,
          ),
        )
        .toList();
  }

  // get brews stream
  Stream<List<Product>> get products {
    return productsCollection
        .snapshots()
        .map<List<Product>>(_productsListFromSnapshot);
  }
}
