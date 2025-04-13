import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/AppColor.dart';
import '../utils/AppString.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const CustomSearchBar({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          prefixIcon: Icon(Icons.search, color: AppColor.pink1, size: 20),
          hintText: hintText ?? AppString.searchHint,
          hintStyle: TextStyle(fontSize: 14.sp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pink1),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pink1),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
