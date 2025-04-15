import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/AppColor.dart';

class CartIconWithBadge extends StatelessWidget {
  final VoidCallback onTap;
  const CartIconWithBadge({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Box cartBox = Hive.box('localStorage');

    return ValueListenableBuilder(
      valueListenable: cartBox.listenable(),
      builder: (context, box, _) {
        int totalQuantity = 0;

        for (var item in box.values) {
          totalQuantity += item['quantity'] as int;
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart,color: AppColor.pink1,),
              onPressed: onTap,
            ),
            if (totalQuantity > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$totalQuantity',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
