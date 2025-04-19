import 'package:flutter/material.dart';
import '../utils/AppColor.dart';

void showConfirmationDialog(BuildContext context, double totalAmount) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Order Confirmed", style: TextStyle(color: AppColor.pink1, fontWeight: FontWeight.bold, fontSize: 18,),textAlign: TextAlign.center,),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.pink1.withOpacity(0.1), // Light pink background
              ),
              child: const Icon(Icons.check_circle, size: 28, color: AppColor.pink1,),
            ),
            const SizedBox(height: 24),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: "Your order of ", style: const TextStyle(color: Colors.grey),
                children: [
                  TextSpan(text: " ৳${totalAmount.toStringAsFixed(2)} ", style: const TextStyle(color: AppColor.pink1, fontWeight: FontWeight.w500,),),
                  const TextSpan(text: "has been placed successfully.", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500,),),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
              ).copyWith(backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF8e005e),),),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
