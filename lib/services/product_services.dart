import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_devices/constants/strings.dart';
import 'package:market_devices/models/product_model.dart';

class StoreService {
  CollectionReference products =
      FirebaseFirestore.instance.collection(kProductsCollection);

  Future<void> addProduct({required ProductModel product}) {
    return products.add({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDescription: product.description,
      kProductCategory: product.category,
      kProductQuantity: product.quantity,
      kProductImage: product.image,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return products.snapshots();
  }

  Future<void> deleteProduct({required String id}) async {
    return await products.doc(id).delete();
  }

  Future<void> updateProduct({required ProductModel product}) async {
    return await products.doc(product.id).update({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDescription: product.description,
      kProductCategory: product.category,
      kProductQuantity: product.quantity,
      kProductImage: product.image,
    });
  }

}
