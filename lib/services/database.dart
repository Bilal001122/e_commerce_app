import 'package:e_commerce_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

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

  Future addToCart(String productId) {
    return usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('cart')
        .doc(productId)
        .set({'size': 1});
  }

  List<int> _productsCartListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map<int>(
          (doc) => doc.get('size'),
        )
        .toList();
  }

  Stream<List<int>> get productsCart {
    return usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('cart')
        .snapshots()
        .map<List<int>>(
      (snapshot) {
        return _productsCartListFromSnapshot(snapshot);
      },
    );
  }
}
