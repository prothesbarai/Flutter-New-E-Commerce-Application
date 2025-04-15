import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomHomePageProductTitle extends StatelessWidget {
  final String title;
  final String allItemsName;
  final Widget pageRoute;
  const CustomHomePageProductTitle({
    super.key,
    required this.title,
    required this.allItemsName,
    required this.pageRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageRoute),
              );
            },
            child: Row(
              children: [
                Text(allItemsName, style: TextStyle(fontSize: 14.sp)),
                Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
