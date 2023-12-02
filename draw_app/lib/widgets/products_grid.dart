// product_grid.dart

import 'dart:convert';

import 'package:draw_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:draw_app/models/product.dart'; // Import your Product model

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final String search;

  const ProductGrid({super.key, required this.products, required this.search});

  @override
  Widget build(BuildContext context) {
    var filteredProducts =
        products.where((product) => product.name.contains(search)).toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 250, // specify the height
          child: Card(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 112, // specify the height
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightColorScheme.onSurface
                            : darkColorScheme
                                .surface, // specify the background color
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ), // round the corners
                      ), // specify the background color
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 6, left: 8, right: 8),
                        child: Image.memory(
                          base64Decode(filteredProducts[index].image),
                          fit: BoxFit.cover,
                          height: 100, // specify the height
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    alignment: Alignment.centerLeft, // Add this line
                    child: Text(
                      filteredProducts[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    alignment: Alignment.centerLeft, // Add this line
                    child: Text(filteredProducts[index].categoryId),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    alignment: Alignment.centerLeft, // Add this line
                    child: Text(
                      '\$${filteredProducts[index].price.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
