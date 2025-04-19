import 'package:flutter/material.dart';
import 'package:AppStore/utils/AppColor.dart';

class GenericPaymentPage extends StatelessWidget {
  final String method;
  final double amount;

  const GenericPaymentPage({super.key, required this.method, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$method Payment', style: const TextStyle(color: AppColor.pink1)),
        iconTheme: const IconThemeData(color: AppColor.pink1),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("📱 Pay using $method", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("Amount to pay: ৳${amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              labelText: '$method Account Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Transaction ID (after sending)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showSuccessDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.pink1,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Confirm Payment", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🎉 Payment Received"),
        content: Text("Your $method payment of ৳${amount.toStringAsFixed(2)} has been confirmed."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
