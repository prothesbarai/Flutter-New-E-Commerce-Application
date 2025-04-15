import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model.dart';
import '../pages/newArrivalsAllProductItems.dart';

class Customhomepageproductdesign extends StatelessWidget {
  List<ProductModel> displayedProducts;
  Customhomepageproductdesign({
    super.key,
    required this.displayedProducts
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 243.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: displayedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 140,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final product = displayedProducts[index];
          return ProductItem(
            product: product,
            onTap: () {},
          );
        },
      ),
    );
  }
}
