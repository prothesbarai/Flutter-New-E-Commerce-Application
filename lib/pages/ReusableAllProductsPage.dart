import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_item.dart';

// Reusable All Products Page
class AllProductsPage extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const AllProductsPage({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.6,
            mainAxisExtent: 315
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductItem(
            product: product,
            onTap: () {
              // cart e add korar logic
            },
          );
        },
      ),
    );
  }
}
