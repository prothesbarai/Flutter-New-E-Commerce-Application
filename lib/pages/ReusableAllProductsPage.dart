import 'package:AppStore/widgets/customBottomNavBar.dart';
import 'package:AppStore/widgets/customFloatingActionButton.dart';
import 'package:flutter/material.dart';
import '../data_api/api_service.dart';
import '../models/product_model.dart';
import '../widgets/custom_app_bar.dart';
import 'newArrivalsAllProductItems.dart';

class AllProductsPage extends StatefulWidget {

  const AllProductsPage({
    super.key,
  });

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showSearchBox: false),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Customfloatingactionbutton(isHome: false),
      bottomNavigationBar: Custombottomnavbar(),
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 60, left: 16, right: 16,), // New Arrivals All Product Page er Jonno
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.6,
                mainAxisExtent: 272,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  onTap: () {

                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
