import 'dart:convert';
import 'package:draw_app/models/product.dart';
import 'package:draw_app/services/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({required Key key, required this.product})
      : super(key: key);
  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text(widget.product.name,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context)
                .colorScheme
                .onSecondary, // replace with your desired color
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Image.memory(
                base64Decode(widget.product.image),
                fit: BoxFit.cover,
                height: 250, // specify the height
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top -
                290,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary), // Change the color as needed
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.product.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Text('Size: ${widget.product.size}'),
                        Text('Colour: ${widget.product.colour}'),
                        Text('Type: ${widget.product.type}'),
                        Text('Brand: ${widget.product.brand}'),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  right: 0,
                  child: Row(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          iconSize: 20.0,
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                // Decrease the quantity here
                                quantity--;
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                        child: Text(quantity.toString()),
                      ), // Replace this with your quantity variable
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          iconSize: 20.0,
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            setState(() {
                              // Increase the quantity here
                              quantity++;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16.0), // Add right padding
                          child: ElevatedButton(
                            onPressed: () async {
                              User? user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                bool success = await Products().addToCart(
                                    user.uid, widget.product, quantity);
                                if (success) {
                                  // Show a success message
                                  final scaffoldMessenger =
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context);
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: <Widget>[
                                          const Icon(Icons.check,
                                              color: Colors.green),
                                          const SizedBox(width: 20.0),
                                          const Expanded(
                                            child: Text(
                                                'Added to cart successfully!'),
                                          ),
                                          const SizedBox(width: 20.0),
                                          GestureDetector(
                                            onTap: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                            child: Icon(Icons.close,
                                                // ignore: use_build_context_synchronously
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  // Show an error message
                                  final scaffoldMessenger =
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context);
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: <Widget>[
                                          const Icon(Icons.error,
                                              color: Colors.red),
                                          const SizedBox(width: 20.0),
                                          const Expanded(
                                            child:
                                                Text('Failed to add to cart!'),
                                          ),
                                          const SizedBox(width: 20.0),
                                          GestureDetector(
                                            onTap: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                            child: Icon(Icons.close,
                                                // ignore: use_build_context_synchronously
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
