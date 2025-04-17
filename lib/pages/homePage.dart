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
import '../models/product_model.dart';
import '../utils/AppColor.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_body_search_bar.dart';
import 'ReusableAllProductsPage.dart';

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

  // Avoid Memory Lake
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

                return SingleChildScrollView(
                  child: Column(
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

                      CustomHomePageProductTitle(title: "New Arrivals", allItemsName: "All Products", pageRoute: AllProductsPage()),
                      Customhomepageproductdesign(displayedProducts: displayedProducts),
                      CustomHomePageProductTitle(title: "Indian Product", allItemsName: "All Products", pageRoute: AllProductsPage()),
                      Customhomepageproductdesign(displayedProducts: displayedProducts),
                      CustomHomePageProductTitle(title: "America Product", allItemsName: "All Products", pageRoute: AllProductsPage()),
                      Customhomepageproductdesign(displayedProducts: displayedProducts),
                      CustomHomePageProductTitle(title: "Canada Product", allItemsName: "All Products", pageRoute: AllProductsPage()),
                      Customhomepageproductdesign(displayedProducts: displayedProducts),

                      // Check For Check Load Items......


                      SizedBox(height: 50.h,),

                      /*GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 50,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 2,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: Text('Items No :  ${index + 1}')),
                            ),
                          );
                        },
                      ),*/
                    ],
                  ),
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