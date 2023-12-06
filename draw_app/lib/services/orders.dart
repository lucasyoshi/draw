import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_app/models/order.dart';
import 'package:draw_app/models/product.dart';
import 'package:draw_app/models/shoppingCartItem.dart';

class Cart {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createNewOrder(
      List<ShoppingCartItem> cart, String userId) async {
    print('Database createNewOrder: try');
    try {
      DocumentReference orderRef =
          await db.collection("users").doc(userId).collection("orders").add({
        "date": DateTime.now(),
        // Add other order details here.
      });
      // Access the unique ID of the order.
      String orderId = orderRef.id;

      // You can now use orderId to update the order document.
      await orderRef.update({"orderId": orderId});
      for (ShoppingCartItem item in cart) {
        await orderRef.collection("items").doc(item.product.id).set({
          "name": item.product.name,
          "price": item.product.price,
          "description": item.product.description,
          "image": item.product.image,
          "colour": item.product.colour,
          "size": item.product.size,
          "type": item.product.type,
          "brand": item.product.brand,
          "categoryId": item.product.categoryId,
          "quantity": item.quantity,
        });
        // Get the document of the product in the "products" collection.
        DocumentSnapshot productDoc =
            await db.collection("products").doc(item.product.id).get();

        // Get the current quantityOnHand of the product.
        int currentQuantity = productDoc.get('quantityOnHand') as int;

        // Subtract the quantity ordered from the current quantityOnHand.
        int newQuantity = currentQuantity - item.quantity;

        // Update the quantityOnHand field of the product document with the new quantity.
        await db
            .collection("products")
            .doc(item.product.id)
            .update({'quantityOnHand': newQuantity});
      }
      // Clear the shopping cart in the database after the order is successfully created
      QuerySnapshot querySnapshot = await db
          .collection("users")
          .doc(userId)
          .collection("shopping_cart")
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      return true;
    } catch (e) {
      print('Database createNewOrder: catch $e');
      return false;
    }
  }

  Future<List<UserOrder>> getAllUserOrders(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await db.collection("users").doc(userId).collection("orders").get();

      List<UserOrder> orders = [];
      for (var doc in querySnapshot.docs) {
        // Get the items subcollection for each order.
        QuerySnapshot itemSnapshot =
            await doc.reference.collection("items").get();

        // Create a list of OrderItem objects from the item documents.
        List<OrderItem> items = itemSnapshot.docs.map((itemDoc) {
          return OrderItem.fromJson(itemDoc.data() as Map<String, dynamic>);
        }).toList();

        // Create an Order object from the order document and the list of OrderItem objects.
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        UserOrder order = UserOrder(
          id: doc.id,
          date: (data['date'] as Timestamp).toDate(),
          items: items,
        );

        orders.add(order);
      }

      return orders;
    } catch (e) {
      print('Database getAllOrders: catch $e');
      rethrow;
    }
  }
}
