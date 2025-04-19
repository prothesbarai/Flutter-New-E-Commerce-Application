import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageRoute),
              );
            },
            child: Text(
              allItemsName,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
