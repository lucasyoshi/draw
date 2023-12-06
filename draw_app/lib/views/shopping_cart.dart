import 'dart:convert';

import 'package:draw_app/models/product.dart';
import 'package:draw_app/models/shoppingCartItem.dart';
import 'package:draw_app/services/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  ShoppingCartState createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  Future<List<ShoppingCartItem>>? cartItems;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    cartItems = Products().getAllShoppingCartItems(
        user!.uid); // Replace 'userId' with the actual user ID
  }

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
      body: FutureBuilder<List<ShoppingCartItem>>(
        future: cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Change this to your desired background color
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary), // Change this to your desired border color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 120.0, // Set your desired height
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Image.memory(
                            base64Decode(snapshot.data![index].product.image),
                            fit: BoxFit.cover,
                            height: 100.0, // specify the height
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  snapshot.data![index].product.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '\$${snapshot.data![index].product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Quantity: ${snapshot.data![index].quantity}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              onPressed: () {
                                // Add your delete functionality here
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
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
