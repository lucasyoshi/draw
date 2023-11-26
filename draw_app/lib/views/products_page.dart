import 'package:flutter/material.dart';
import 'package:draw_app/models/product.dart';
import 'package:draw_app/services/products.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];
  String search = '';
  Future<List<Product>>? loadProductsFuture;
  @override
  void initState() {
    super.initState();
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
    Product newProduct = Product(
      id: '1',
      name: 'newName',
      description: 'newDescription',
      price: 100.0,
      image: 'newImage',
      colour: 'white',
      size: 'M',
      type: 'newType',
      brand: 'newBrand',
      categoryId: 'newCategoryId',
      quantityOnHand: '100',
    );
    await Products().createNewProduct(newProduct);
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(hintText: 'Search...'),
              cursorColor: Theme.of(context).colorScheme.secondary,
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
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      if (products[index].name.contains(search)) {
                        print(products[index].name);
                        return ListTile(
                          title: Text(
                            products[index].name,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(products[index].description),
                          // Add more product details here
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
