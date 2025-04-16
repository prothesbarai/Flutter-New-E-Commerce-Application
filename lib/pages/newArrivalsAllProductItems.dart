import 'package:AppStore/pages/product_details_page.dart';
import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product_model.dart';
import 'CartPage.dart';
import '../utils/cart_helper.dart';

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
    quantity = 0; // Initialize quantity to 0
    _syncQuantityFromCart();
    super.initState();
  }

  void _syncQuantityFromCart() {
    final box = Hive.box('localStorage');
    final item = box.get(widget.product.id);
    if (item != null && item['quantity'] != quantity) {
      setState(() {
        quantity = item['quantity'];
      });
    }
  }

  void increaseQuantity() {
    if (quantity < widget.product.total_quantity) {
      setState(() {
        quantity++;
      });
      widget.product.quantity = quantity;
      widget.onTap(); // Refresh UI after quantity update
      CartHelper.addOrUpdateCartItem( // Update the cart immediately
        id: widget.product.id,
        name: widget.product.title,
        image: widget.product.imageUrl,
        price: widget.product.memberPrice,
        quantity: quantity,
      );
    }
  }

  void decreaseQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
      widget.product.quantity = quantity;
      widget.onTap(); // Refresh UI after quantity update
      CartHelper.addOrUpdateCartItem( // Update the cart immediately
        id: widget.product.id,
        name: widget.product.title,
        image: widget.product.imageUrl,
        price: widget.product.memberPrice,
        quantity: quantity,
      );
    }
  }

  void navigateToCartPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(latestProducts: [ ]),
      ),
    );

    if (result == true) {
      setState(() {
        _syncQuantityFromCart();
      });
    }
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
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product: widget.product),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    widget.product.imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
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
          Container(
            // padding: const EdgeInsets.all(8), // Button Padding
            child: quantity == 0
                ? InkWell(
              onTap: increaseQuantity,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppColor.pink1,
                  // borderRadius: BorderRadius.circular(12), // Button Border Circular
                ),
                child: const Center(
                  child: Icon(Icons.add_circle_outline, color: Colors.yellowAccent),
                ),
              ),
            )
                : Container(
              height: 36,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.pink1,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: IconButton(
                        onPressed: decreaseQuantity,
                        icon: const Icon(Icons.remove_circle_outline, color: AppColor.yellowAccent),
                        iconSize: 20,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.pink1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: quantity >= widget.product.total_quantity
                            ? Colors.grey.shade300
                            : AppColor.pink1,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: IconButton(
                        onPressed: quantity >= widget.product.total_quantity ? null : increaseQuantity,
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: quantity >= widget.product.total_quantity
                              ? Colors.grey.shade500
                              : AppColor.yellowAccent,
                        ),
                        iconSize: 20,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: widget.product),
                ),
              );
            },
            child: Container(
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
                    style: const TextStyle(color: AppColor.pink1, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.star, color: AppColor.pink1, size: 14),
                      Icon(Icons.star, color: AppColor.pink1, size: 14),
                      Icon(Icons.star, color: AppColor.pink1, size: 14),
                      Icon(Icons.star, color: AppColor.pink1, size: 14),
                      Icon(Icons.star, color: AppColor.pink1, size: 14),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
