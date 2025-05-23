import 'package:AppStore/utils/AppColor.dart';
import 'package:AppStore/widgets/customBottomNavBar.dart';
import 'package:AppStore/widgets/customFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../models/product_model.dart';
import '../payment_page/PaymentPage.dart';

class CartPage extends StatefulWidget {
  final List<ProductModel> latestProducts;

  const CartPage({super.key, required this.latestProducts});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Box cartBox = Hive.box('localStorage');

  @override
  void initState() {
    super.initState();
    syncCartPricesWithProductList(widget.latestProducts);
  }

  // Price Update
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

  // Goto Payment page and Show Progressbar
  void _showProcessingAndNavigate(double total) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.black87,
          content: const Text(
            'Process Checkout.....',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          latestProducts: widget.latestProducts,
          total: total, // total এখন প্যারামিটার থেকে আসছে
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('🛒 My Cart',style: TextStyle(color: AppColor.pink1),),
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: AppColor.pink1,),
          onPressed: () {
            Navigator.pop(context, true); // Back result
          },
        ),


      ),
      bottomNavigationBar: Custombottomnavbar(),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Customfloatingactionbutton(isHome: false,),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: cartBox.listenable(),
          builder: (context, box, _) {
            if (box.isEmpty) {
              return const Center(
                child: Text('Cart is Empty 🛍️', style: TextStyle(fontSize: 18,color: AppColor.pink1)),
              );
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
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      var key = box.keyAt(index);
                      var item = box.get(key);

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item['image'],
                                  width: 60.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "৳${item['price']} × ${item['quantity']}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      item['quantity'] += 1;
                                      box.put(key, item);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Bar
                Container(
                  padding: const EdgeInsets.only(left: 16,right:16,top: 20,bottom: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: const Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price : ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('৳${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: AppColor.pink1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            _showProcessingAndNavigate(total);
                          },
                          child: Text('Checkout', style: TextStyle(fontSize: 16.sp, color: AppColor.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
