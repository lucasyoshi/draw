import 'dart:convert';

import 'package:draw_app/services/auth.dart';
import 'package:draw_app/theme/theme_switch.dart';
import 'package:draw_app/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:draw_app/models/product.dart';
import 'package:draw_app/services/products.dart';
import 'package:flutter/services.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];
  String search = '';
  String filter = '';
  String? currentUserName;
  Future<List<Product>>? loadProductsFuture;
  final Auth auth = Auth();
  @override
  void initState() {
    super.initState();
    currentUserName = (auth.authInst.currentUser == null
        ? ''
        : auth.authInst.currentUser!.displayName);
    loadProductsFuture = loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    products = await Products().getAllProducts();
    products.forEach((product) {
      print('Product: ${product.name}, ID: ${product.id}');
    });
    setState(() {});
    return products;
  }

  void addProduct() async {
    ByteData bytes = await rootBundle.load('assets/img/lamySafary.jpg');
    var buffer = bytes.buffer;
    Uint8List imageBytes =
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    // Convert the Uint8List to a base64 string
    String imageBase64 = base64Encode(imageBytes);

    Product newProduct = Product(
      id: '5',
      name: 'Lamy Safari',
      description: 'newDescription',
      price: 99.99,
      image: imageBase64,
      colour: 'white',
      size: 'M',
      type: 'newType',
      brand: 'newBrand',
      categoryId: 'Fountain Pen',
      quantityOnHand: 100,
    );
    await Products().createNewProduct(newProduct);
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Hi, $currentUserName',
            style: Theme.of(context).textTheme.headlineSmall),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ThemeSwitch(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
            child: Material(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Add this line
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ).applyDefaults(Theme.of(context).inputDecorationTheme),
                cursorColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = '1';
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return filter == '1'
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context)
                                .colorScheme
                                .secondary; // Use the appropriate color for active state
                      },
                    ),
                  ),
                  child: const Text('Pen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = '2';
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return filter == '2'
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context)
                                .colorScheme
                                .secondary; // Use the appropriate color for active state
                      },
                    ),
                  ),
                  child: const Text('Pencil'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = '3';
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return filter == '3'
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context)
                                .colorScheme
                                .secondary; // Use the appropriate color for active state
                      },
                    ),
                  ),
                  child: const Text('Notebook'),
                ),
                FloatingActionButton(
                  mini: true, // Set to true for a smaller button
                  onPressed: () {
                    setState(() {
                      filter = '';
                    });
                  },
                  shape: CircleBorder(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.0)), // Add this line
                  child: const Icon(Icons.close),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: loadProductsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20), // Add this line
                    child: ProductGrid(
                        products: products, search: search, filter: filter),
                  );
                }
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: ElevatedButton(
      //   onPressed: addProduct,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
