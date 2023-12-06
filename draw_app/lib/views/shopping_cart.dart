import 'dart:convert';

import 'package:draw_app/models/product.dart';
import 'package:draw_app/models/shoppingCartItem.dart';
import 'package:draw_app/services/orders.dart';
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
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    cartItems = Products().getAllShoppingCartItems(
        user!.uid); // Replace 'userId' with the actual user ID
  }

  double calculateSubtotal(List<ShoppingCartItem> cart) {
    double subtotal = 0.0;
    for (ShoppingCartItem item in cart) {
      subtotal += item.product.price * item.quantity;
    }
    return subtotal;
  }

  Future<void> submitOrder() async {
    // Add your submit order functionality here
    // Call the createNewOrder method
    List<ShoppingCartItem>? items = await cartItems;
    if (items == null) {
      // ignore: use_build_context_synchronously
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Row(
          children: <Widget>[
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 20.0),
            const Expanded(
              child: Text('Shopping Cart is empty'),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () {
                scaffoldMessenger.hideCurrentSnackBar();
              },
              child: Icon(Icons.close,
                  // ignore: use_build_context_synchronously
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          ],
        ),
      ));
      return;
    }
    bool success = await Cart().createNewOrder(items, user!.uid);

    if (success) {
      // ignore: use_build_context_synchronously
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              const Icon(Icons.check, color: Colors.green),
              const SizedBox(width: 20.0),
              const Expanded(
                child: Text('Order created successfully!'),
              ),
              const SizedBox(width: 20.0),
              GestureDetector(
                onTap: () {
                  scaffoldMessenger.hideCurrentSnackBar();
                },
                child: Icon(Icons.close,
                    // ignore: use_build_context_synchronously
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            ],
          ),
        ),
      );
      // Update the state
      setState(() {
        cartItems = Products().getAllShoppingCartItems(user!.uid); // fetchCartItems is your method to fetch the cart items
      });
    } else {
      // ignore: use_build_context_synchronously
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 20.0),
              const Expanded(
                child: Text('Failed to create order'),
              ),
              const SizedBox(width: 20.0),
              GestureDetector(
                onTap: () {
                  scaffoldMessenger.hideCurrentSnackBar();
                },
                child: Icon(Icons.close,
                    // ignore: use_build_context_synchronously
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            ],
          ),
        ),
      );
    }
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
            return Stack(children: <Widget>[
              ListView.builder(
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
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  Text(
                                    '\$${snapshot.data![index].product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
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
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                                onPressed: () async {
                                  print(snapshot.data![index].product);
                                  if (snapshot
                                      .data![index].product.id.isNotEmpty) {
                                    bool success = await Products()
                                        .removeFromCart(user!.uid,
                                            snapshot.data![index].product.id);
                                    if (success) {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Product removed from cart')),
                                      );
                                      setState(() {
                                        cartItems = Products()
                                            .getAllShoppingCartItems(user!.uid);
                                      });
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Failed to remove product from cart')),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary, // Change the background color here),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary), // Change the border color here
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Subtotal:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '\$${calculateSubtotal(snapshot.data!).toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: submitOrder,
                            child: const Text('Submit Order'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}
