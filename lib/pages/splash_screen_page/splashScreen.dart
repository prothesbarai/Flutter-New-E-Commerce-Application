import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data_api/get_items_info_api.dart';
import '../../utils/AppDataCache.dart';
import '../homePage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final AppDataCache cache = AppDataCache();

  @override
  void initState() {
    super.initState();
    _initializeAppData(); // fetch everything here
  }

  Future<void> _initializeAppData() async {
    try {
      // 1. Load all categories
      cache.categories = await ApiService.fetchCategories();

      // 2. Load products from each category and store
      for (var category in cache.categories) {
        final products = await ApiService.fetchProductsByCategory(category.tableName);
        cache.productsByCategory[category.tableName] = products;
      }

      // 3. After loading, go to HomePage
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => MyHomePage()),
      );
    } catch (e) {
      print("Error loading data: $e");
      // Optional: Show retry button or fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pink1,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PiFast",
                style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 44.sp,
                ),
              ),
              SizedBox(height: 15.h),
              CircularProgressIndicator(color: AppColor.white),
            ],
          ),
        ),
      ),
    );
  }
}
