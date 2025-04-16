import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/CartPage.dart';
import '../utils/AppColor.dart';
import '../utils/AppString.dart';
import 'cardBadgesIconWidget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showSearchBox;
  final Function(String)? onSearch;

  const CustomAppBar({
    Key? key,
    required this.showSearchBox,
    this.onSearch,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late TextEditingController _searchController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: AppColor.pink1,
      ),
      title: (widget.showSearchBox && _isSearching)
          ? TextField(
        controller: _searchController,
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
        onChanged: widget.onSearch,
      )
          : SizedBox(
        height: 30.h,
        child: Image.asset('assets/images/logos.png'),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.bodyColor, AppColor.bodyColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      actions: [
        if (widget.showSearchBox)
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  if (widget.onSearch != null) {
                    widget.onSearch!("");  // Clear the search input
                  }
                }
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search_rounded,
              color: AppColor.pink1,
            ),
          ),
        CartIconWithBadge(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartPage(latestProducts: []),
              ),
            );
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: AppColor.pink1),
          onSelected: (value) {
            if (value == 'settings') {
              // Navigate to settings
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
}
