import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../widgets/customBottomNavBar.dart';
import '../../widgets/customFloatingActionButton.dart';
import '../../widgets/custom_app_bar.dart';
// import 'newArrivalsAllProductItems.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  final List<String> packOptions = [
    "120 Count (Pack of 1)",
    "240 Count (Pack of 2)",
    "360 Count (Pack of 3)"
  ];
  String selectedPack = "120 Count (Pack of 1)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showSearchBox: false),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Customfloatingactionbutton(isHome: false),
      bottomNavigationBar: Custombottomnavbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧃 Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.product.imageUrl,
                  height: 200,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🧾 Title & Brand
            Text(
              widget.product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text("Visit ",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text(
                  "SAN Pharma",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.pink1,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.star, size: 16, color: Colors.orange),
                const Text(" 4.8 (2.2k)",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            // 💰 Price
            Text(
              "Price: ৳${widget.product.regularPrice}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),

            // 📦 Pack dropdown + Quantity
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF1FD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: selectedPack,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: packOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedPack = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🛒 Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.pink1,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Add to cart logic
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, color: AppColor.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔄 Similar Supplement Section
            const Text(
              "Similar Supplement",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),


          ],
        ),
      ),
    );
  }
}