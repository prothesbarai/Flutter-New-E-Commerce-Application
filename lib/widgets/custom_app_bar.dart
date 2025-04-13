import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/CartPage.dart';
import '../utils/AppColor.dart';
import '../utils/AppString.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final Function(bool) onSearchToggle;

  const CustomAppBar({
    Key? key,
    required this.isSearching,
    required this.searchController,
    required this.onSearchToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
        controller: searchController,
        autofocus: true,
        cursorHeight: 16.h,
        cursorWidth: 1.5.w,
        decoration: InputDecoration(
          hintText: AppString.searchHint,
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.black),
        onChanged: (value) {},
      )
          : Image.asset('assets/images/logos.png', height: 30.h),
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.bodyColor, AppColor.bodyColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: AppColor.pink1),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            onSearchToggle(!isSearching);
            if (!isSearching) {
              searchController.clear();
            }
          },
          icon: Icon(
            isSearching ? Icons.close : Icons.search_rounded,
            color: AppColor.pink1,
          ),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart, color: AppColor.pink1),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage(latestProducts: [],)),
            );
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: AppColor.pink1),
          onSelected: (value) {
            if (value == 'settings') {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );*/
            } else if (value == 'logout') {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'settings',
                child: Text(AppString.setting),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text(AppString.logout),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
