import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String id;
  late String name;
  late String colour;
  late String size;
  late String type;
  late String brand;
  late String categoryId;
  late String quantityOnHand;
  late String description;
  late double price;
  late String image;

  Product({
    required this.id,
    required this.name,
    required this.colour,
    required this.size,
    required this.type,
    required this.brand,
    required this.categoryId,
    required this.quantityOnHand,
    required this.description,
    required this.price,
    required this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    colour = json['colour'];
    size = json['size'];
    type = json['type'];
    brand = json['brand'];
    categoryId = json['categoryId'];
    quantityOnHand = json['quantityOnHand'];
  }
    factory Product.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Product(
      id: documentSnapshot.id,
      name: data['name'],
      description: data['description'],
      price: data['price'],
      image: data['image'],
      colour: data['colour'],
      size: data['size'],
      type: data['type'],
      brand: data['brand'],
      categoryId: data['categoryId'],
      quantityOnHand: data['quantityOnHand'],
    );
  }
}
