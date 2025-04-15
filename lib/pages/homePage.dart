import 'package:AppStore/utils/AppString.dart';
import 'package:AppStore/widgets/ExitConfirmationWrapper.dart';
import 'package:AppStore/widgets/customBottomNavBar.dart';
import 'package:AppStore/widgets/customDrawerWidget.dart';
import 'package:AppStore/widgets/customFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data_api/api_service.dart';
import '../models/product_model.dart';
import '../utils/AppColor.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import 'newArrivalsAllProductItems.dart';
import 'ReusableAllProductsPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSearching = false;
  final TextEditingController _customSearchController = TextEditingController();
  final TextEditingController _appBarsearchController = TextEditingController();
  final ApiService apiService = ApiService();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  List<ProductModel> displayedProducts = [];

  // Avoid Memory Lake
  @override
  void dispose() {
    _customSearchController.dispose();
    _appBarsearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExitConfirmationWrapper(
      title: AppString.exitTitle,
      message: AppString.exitMessage,
      confirmText: AppString.exitConfrimBtn,
      cancelText: AppString.exitCancelBtn,
      child: Scaffold(
        appBar: CustomAppBar(
          isSearching: _isSearching,
          searchController: _appBarsearchController,
          onSearchToggle: (value) {
            setState(() {
              _isSearching = value;
              if (!value) {
                _customSearchController.clear();
                filteredProducts = [];
                displayedProducts = allProducts.take(5).toList();
              }
            });
          },
        ),
        drawer: Customdrawerwidget(),
        body: SafeArea(
          child: FutureBuilder<List<ProductModel>>(
            future: ApiService.fetchProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: AppColor.pink1));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: \${snapshot.error}'));
              } else if (snapshot.hasData) {
                allProducts = snapshot.data!;
                if (displayedProducts.isEmpty) {
                  displayedProducts = allProducts.take(5).toList();
                }

                return Column(
                  children: [
                    CustomSearchBar(
                      controller: _customSearchController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            displayedProducts = allProducts.take(5).toList();
                          });
                        }
                      },
                      onSubmitted: (value) {
                        setState(() {
                          filteredProducts = allProducts
                              .where((product) => product.title.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                          if (filteredProducts.isEmpty) {
                            displayedProducts = allProducts.take(5).toList();
                          } else {
                            displayedProducts = filteredProducts;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "New Arrivals",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllProductsPage()),
                              );
                            },
                            child: Row(
                              children: [
                                Text("All Products", style: TextStyle(fontSize: 14.sp)),
                                Icon(Icons.arrow_forward_ios, size: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
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
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No products available'));
              }
            },
          ),
        ),
        bottomNavigationBar: Custombottomnavbar(),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Customfloatingactionbutton(isHome: true,),
      ),
    );
  }

}