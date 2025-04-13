import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/product_model.dart'; //Product model import

class CartPage extends StatelessWidget {
  final Box cartBox = Hive.box('localStorage');

  CartPage({super.key});

  // Add this method to sync price with latest products (from database if you want)
  void syncCartPricesWithProductList(List<ProductModel> latestProducts) {
    for (var key in cartBox.keys) {
      var item = cartBox.get(key);
      var matchedProduct = latestProducts.firstWhere(
            (p) => p.id == key,
        orElse: () => ProductModel(id: -1, title: '', imageUrl: '', regularPrice: 0, memberPrice: 0, discount: 0, quantity: 0, total_quantity: 0),
      );

      if (matchedProduct.id != -1 && item['price'] != matchedProduct.memberPrice) {
        item['price'] = matchedProduct.memberPrice;
        cartBox.put(key, item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          double total = 0;
          for (var item in box.values) {
            total += (item['price'] * item['quantity']);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var key = box.keyAt(index);
                    var item = box.get(key);

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: Image.network(item['image'], width: 50, height: 50),
                        title: Text(item['name']),
                        subtitle: Text("৳${item['price']} x ${item['quantity']}"),
                        trailing: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                item['quantity'] += 1;
                                box.put(key, item);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (item['quantity'] > 1) {
                                  item['quantity'] -= 1;
                                  box.put(key, item);
                                } else {
                                  box.delete(key);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('৳${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Proceeding to checkout...')),
                          );
                        },
                        child: const Text('Checkout'),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
