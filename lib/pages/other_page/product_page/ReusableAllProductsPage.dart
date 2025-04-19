import 'package:flutter/material.dart';
import '../../../data_api/get_items_info_api.dart';
import '../../../models/product_model.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/customBottomNavBar.dart';
import '../../../widgets/customFloatingActionButton.dart';
import 'newArrivalsAllProductItems.dart';

class ReusableAllProductsPage extends StatefulWidget {
  final String tableName;

  const ReusableAllProductsPage({super.key, required this.tableName});

  @override
  State<ReusableAllProductsPage> createState() => _ReusableAllProductsPageState();
}

class _ReusableAllProductsPageState extends State<ReusableAllProductsPage> {
  late Future<List<ProductModel>> futureProducts;
  List<ProductModel> allProducts = [];
  List<ProductModel> displayedProducts = [];

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.fetchProductsByCategory(widget.tableName);
    futureProducts.then((products) {
      setState(() {
        allProducts = products;
        displayedProducts = products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showSearchBox: true,
        onSearch: (value) {
          setState(() {
            displayedProducts = allProducts
                .where((product) => product.title.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
        },
      ),
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

            return GridView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 60, left: 16, right: 16),
              itemCount: displayedProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.6,
                mainAxisExtent: 272,
              ),
              itemBuilder: (context, index) {
                final product = displayedProducts[index];
                return ProductItem(product: product, onTap: () {});
              },
            );
          },
        ),
      ),
    );
  }
}
