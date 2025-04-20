import 'package:AppStore/utils/AppString.dart';
import 'package:AppStore/dialogs/ExitConfirmationWrapper.dart';
import 'package:AppStore/widgets/customBottomNavBar.dart';
import 'package:AppStore/widgets/customDrawerWidget.dart';
import 'package:AppStore/widgets/customFloatingActionButton.dart';
import 'package:AppStore/widgets/customHomePageProductDesign.dart';
import 'package:AppStore/widgets/customHomePageProductTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_body_search_bar.dart';
import 'other_page/product_page/ReusableAllProductsPage.dart';
import '../utils/AppDataCache.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _customSearchController = TextEditingController();
  final AppDataCache cache = AppDataCache();

  List<ProductModel> displayedProducts = [];
  String appBarSearchQuery = ""; // ====================  ✅ track appbar search ====================================

  @override
  void dispose() {
    _customSearchController.dispose();
    super.dispose();
  }

  // ================================ ✅ Shared method for both search bars ========================================
  void _filterProducts(String query) {
    final all = cache.productsByCategory.values.expand((e) => e).toList();
    setState(() {
      appBarSearchQuery = query;
      if (query.trim().isEmpty) {
        displayedProducts.clear();
      } else {
        displayedProducts = all
            .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = cache.categories;

    return ExitConfirmationWrapper(
      title: AppString.exitTitle,
      message: AppString.exitMessage,
      confirmText: AppString.exitConfrimBtn,
      cancelText: AppString.exitCancelBtn,
      child: Scaffold(
        appBar: CustomAppBar(
          showSearchBox: true,
          onSearch: _filterProducts, // =================== ✅ Realtime search ==========================
        ),
        drawer: Customdrawerwidget(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ====================== ✅ Body search bar (optional but no conflict) ================================
                CustomSearchBar(
                  controller: _customSearchController,
                  onChanged: (value) {
                    if (value.trim().isEmpty) {
                      _filterProducts(""); // clear results
                    }
                  },
                  onSubmitted: (value) {
                    if (value.trim().isEmpty) return;
                    _filterProducts(value); // manual filter
                  },
                ),

                // ========================================== ✅ Show search results ========================================
                if (displayedProducts.isNotEmpty)
                  Column(
                    children: [
                      CustomHomePageProductTitle(
                        title: "Search Results",
                        allItemsName: "All Products",
                        pageRoute: ReusableAllProductsPage(tableName: "products"),
                      ),
                      Customhomepageproductdesign(
                          displayedProducts: displayedProducts.take(5).toList()),
                    ],
                  )

                // =========================================== ✅ Show categories only if appbar search is empty ===============================================
                else if (appBarSearchQuery.isEmpty)
                  ...categories.map((category) {
                    final products = cache.productsByCategory[category.tableName] ?? [];
                    if (products.isEmpty) return SizedBox();

                    return Column(
                      children: [
                        CustomHomePageProductTitle(
                          title: category.name,
                          allItemsName: "All Products",
                          pageRoute: ReusableAllProductsPage(
                              tableName: category.tableName),
                        ),
                        Customhomepageproductdesign(displayedProducts: products.take(5).toList()),
                      ],
                    );
                  }).toList(),

                SizedBox(height: 50.h),
              ],
            ),
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