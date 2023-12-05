import 'dart:convert';

import 'package:draw_app/models/product.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  ShoppingCartState createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  List<Product> cartProducts = []; // Replace with your list of cart products

  void submitOrder() {
    // Add your submit order functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Shopping Cart',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.memory(
              base64Decode(cartProducts[index].image),
              fit: BoxFit.cover,
              height: 50, // specify the height
            ),
            title: Text(cartProducts[index].name),
            subtitle: Text('\$${cartProducts[index].price.toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: submitOrder,
          child: const Text('Submit Order'),
        ),
      ),
    );
  }
}
