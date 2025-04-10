import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image + Discount Tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '${product.discount}% Off',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          // Add Button
          Container(
            color: Colors.purple,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.yellow, size: 30),
                onPressed: onTap,
              ),
            ),
          ),

          // Product Info
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blueGrey.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text('Regular : ৳${product.regularPrice.toStringAsFixed(0)}'),
                Text(
                  'Member : ৳${product.memberPrice.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.purple, size: 16),
                    Icon(Icons.star, color: Colors.purple, size: 16),
                    Icon(Icons.star, color: Colors.purple, size: 16),
                    Icon(Icons.star, color: Colors.purple, size: 16),
                    Icon(Icons.star, color: Colors.purple, size: 16),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
