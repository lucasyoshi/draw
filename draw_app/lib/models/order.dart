import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  late String id;
  late DateTime date;
  late List<OrderItem> items;

  UserOrder({
    required this.id,
    required this.date,
    required this.items,
  });

  factory UserOrder.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return UserOrder(
      id: documentSnapshot.id,
      date: (data['date'] as Timestamp).toDate(),
      items: (data['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  late String id;
  late String name;
  late double price;
  late String description;
  late String image;
  late String colour;
  late String size;
  late String type;
  late String brand;
  late String categoryId;
  late int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.colour,
    required this.size,
    required this.type,
    required this.brand,
    required this.categoryId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      colour: json['colour'] ?? '',
      size: json['size'] ?? '',
      type: json['type'] ?? '',
      brand: json['brand'] ?? '',
      categoryId: json['categoryId'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}
