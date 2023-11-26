import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_app/models/product.dart';

class Products {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createNewProduct(Product product) async {
    print('Database createNewProduct: try');
    try {
      await db.collection("products").doc(product.id).set({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "image": product.image,
        "colour": product.colour,
        "size": product.size,
        "type": product.type,
        "brand": product.brand,
        "categoryId": product.categoryId,
        "quantityOnHand": product.quantityOnHand,
      });
      return true;
    } catch (e) {
      print('Database createNewProduct: catch $e');
      return false;
    }
  }

  // Future<List<Product>> getAllProducts() async {
  //   print('Database getAllProducts: try');
  //   try {
  //     QuerySnapshot querySnapshot = await db.collection("products").get();
  //     return querySnapshot.docs
  //         .map((doc) {
  //           final data = doc.data();
  //           if (data != null) {
  //             return Product.fromJson(data as Map<String, dynamic>);
  //           }
  //         })
  //         .where((product) => product != null)
  //         .toList()
  //         .cast<Product>();
  //   } catch (e) {
  //     print('Database getAllProducts: catch $e');
  //     rethrow;
  //   }
  // }
  Future<List<Product>> getAllProducts() async {
    print('Database getAllProducts: try');
    try {
      QuerySnapshot querySnapshot = await db.collection("products").get();
      return querySnapshot.docs.map((doc) {
        return Product.fromDocumentSnapshot(documentSnapshot: doc);
      }).toList();
    } catch (e) {
      print('Database getAllProducts: catch $e');
      rethrow;
    }
  }
}
