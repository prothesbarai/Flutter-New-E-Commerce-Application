import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity;
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
    widget.product.quantity = quantity;
    widget.onTap();
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 0) quantity--;
    });
    widget.product.quantity = quantity;
    widget.onTap();
  }

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
                  widget.product.imageUrl,
                  height: 135,
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
                    '${widget.product.discount}% Off',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),

          // Add/Remove Button Section
          Container(
            padding: const EdgeInsets.only(bottom: 8,left: 4,right: 4,top: 8),
            child: quantity == 0
                ? InkWell(
              onTap: increaseQuantity,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            )
                : Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.purple, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: decreaseQuantity,
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.purple),
                    iconSize: 20,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: increaseQuantity,
                    icon: const Icon(Icons.add_circle_outline, color: Colors.purple),
                    iconSize: 20,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
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
                  widget.product.title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Regular : ৳${widget.product.regularPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Member : ৳${widget.product.memberPrice.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.purple, size: 14),
                    Icon(Icons.star, color: Colors.purple, size: 14),
                    Icon(Icons.star, color: Colors.purple, size: 14),
                    Icon(Icons.star, color: Colors.purple, size: 14),
                    Icon(Icons.star, color: Colors.purple, size: 14),
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
