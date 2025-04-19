import 'package:AppStore/utils/AppString.dart';
import 'package:AppStore/widgets/ExitConfirmationWrapper.dart';
import 'package:AppStore/widgets/customBottomNavBar.dart';
import 'package:AppStore/widgets/customDrawerWidget.dart';
import 'package:AppStore/widgets/customFloatingActionButton.dart';
import 'package:AppStore/widgets/customHomePageProductDesign.dart';
import 'package:AppStore/widgets/customHomePageProductTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data_api/get_items_info_api.dart';
import '../models/catagory_models.dart';
import '../models/product_model.dart';
import '../utils/AppColor.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_body_search_bar.dart';
import 'other_page/product_page/ReusableAllProductsPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _customSearchController = TextEditingController();
  final ApiService apiService = ApiService();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  List<ProductModel> displayedProducts = [];

  @override
  void dispose() {
    _customSearchController.dispose();
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
          showSearchBox: true,
          onSearch: (value) {
            setState(() {
              displayedProducts = allProducts
                  .where((product) =>
                  product.title.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
        drawer: Customdrawerwidget(),
        body: SafeArea(
          child: FutureBuilder<List<CategoryModel>>(
            future: ApiService.fetchCategories(),
            builder: (context, categorySnapshot) {
              if (categorySnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: AppColor.pink1));
              } else if (categorySnapshot.hasError) {
                return Center(child: Text('Error loading categories'));
              } else if (!categorySnapshot.hasData || categorySnapshot.data!.isEmpty) {
                return Center(child: Text('No categories available'));
              }

              final categories = categorySnapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Search Bar
                    CustomSearchBar(
                      controller: _customSearchController,
                      onChanged: (value) {
                        // Check if search bar is cleared
                        if (value.trim().isEmpty) {
                          setState(() {
                            displayedProducts.clear(); // go back to normal view
                          });
                        }
                      },
                      onSubmitted: (value) async {
                        if (value.trim().isEmpty) return;

                        List<ProductModel> all = [];
                        for (var category in categories) {
                          final items = await ApiService.fetchProductsByCategory(category.tableName);
                          all.addAll(items);
                        }

                        final filtered = all
                            .where((product) => product.title.toLowerCase().contains(value.toLowerCase()))
                            .toList();

                        setState(() {
                          displayedProducts = filtered;
                        });
                      },
                    ),

                    // If search is active, show results only
                    if (displayedProducts.isNotEmpty)
                      Column(
                        children: [
                          CustomHomePageProductTitle(
                            title: "Search Results",
                            allItemsName: "All Products",
                            pageRoute: ReusableAllProductsPage(tableName: "products"), // fallback
                          ),
                          Customhomepageproductdesign(displayedProducts: displayedProducts.take(5).toList()),
                        ],
                      )
                    else if (_customSearchController.text.isEmpty)
                    // Show default category list
                      ...categories.map((category) {
                        return FutureBuilder<List<ProductModel>>(
                          future: ApiService.fetchProductsByCategory(category.tableName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: CircularProgressIndicator(color: AppColor.pink1),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error loading ${category.name}'));
                            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              final products = snapshot.data!.take(5).toList();
                              return Column(
                                children: [
                                  CustomHomePageProductTitle(
                                    title: category.name,
                                    allItemsName: "All Products",
                                    pageRoute: ReusableAllProductsPage(tableName: category.tableName),
                                  ),
                                  Customhomepageproductdesign(displayedProducts: products),
                                ],
                              );
                            } else {
                              return SizedBox(); // No products
                            }
                          },
                        );
                      }).toList(),

                    SizedBox(height: 50.h),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Custombottomnavbar(),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Customfloatingactionbutton(isHome: true),
      ),
    );
  }
}
