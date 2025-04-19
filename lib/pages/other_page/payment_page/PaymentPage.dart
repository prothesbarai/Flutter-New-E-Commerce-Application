import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:AppStore/utils/AppColor.dart';
import '../../../providers/user_profile_data_provider.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  final List latestProducts;

  const PaymentPage({super.key, required this.total, required this.latestProducts});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'instant'; // 'instant' or 'cod'
  String selectedInstantMethod = 'bKash';
  String selectedCODArea = 'dhaka'; // 'dhaka' or 'outside'

  double get deliveryCharge {
    if (selectedPaymentMethod == 'cod') {
      return selectedCODArea == 'dhaka' ? 60.0 : 110.0;
    }
    return 0.0;
  }

  double get totalAmount => widget.total + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProfileProvider>(context);

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Info', style: TextStyle(color: AppColor.pink1)),
          iconTheme: const IconThemeData(color: AppColor.pink1),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("👤 Customer Info"),
              _buildInfoRow("Name", userProvider.name ?? 'Not found'),
              _buildInfoRow("Email", userProvider.email ?? 'Not found'),
              const SizedBox(height: 16),

              _buildSectionTitle("💳 Select Payment Method"),
              _buildPaymentMethodSelector(),

              if (selectedPaymentMethod == 'instant') ...[
                _buildSectionTitle("⚡ Choose Instant Method"),
                _buildInstantOptions(),
              ],

              if (selectedPaymentMethod == 'cod') ...[
                _buildSectionTitle("📦 Delivery Area"),
                _buildCODAreaSelector(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    selectedCODArea == 'dhaka'
                        ? "Inside Dhaka delivery charge: ৳60"
                        : "Outside Dhaka delivery charge: ৳110",
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],

              const Divider(height: 30),

              _buildSectionTitle("💰 Payment Summary"),
              _buildInfoRow("🛍️ Product Price", "৳${widget.total.toStringAsFixed(2)}"),
              _buildInfoRow("🚚 Delivery Charge", "৳${deliveryCharge.toStringAsFixed(2)}"),
              const SizedBox(height: 8),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Total: ৳${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _confirmOrder();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.pink1,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle_outline,color: AppColor.white,),
                  label: const Text('Order Now', style: TextStyle(fontSize: 16,color:AppColor.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text("Instant Payment"),
          value: 'instant',
          groupValue: selectedPaymentMethod,
          onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        ),
        RadioListTile<String>(
          title: const Text("Cash on Delivery"),
          value: 'cod',
          groupValue: selectedPaymentMethod,
          onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        ),
      ],
    );
  }

  Widget _buildInstantOptions() {
    final methods = ['bKash', 'Nagad', 'Rocket', 'DBBL', 'MasterCard'];

    return Wrap(
      spacing: 10,
      children: methods.map((method) {
        final isSelected = selectedInstantMethod == method;
        return ChoiceChip(
          label: Text(method),
          selected: isSelected,
          checkmarkColor: AppColor.white,
          onSelected: (_) => setState(() => selectedInstantMethod = method),
          selectedColor: AppColor.pink1.withOpacity(0.8),
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        );
      }).toList(),
    );
  }

  Widget _buildCODAreaSelector() {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text("Inside Dhaka (৳60)"),
          value: 'dhaka',
          groupValue: selectedCODArea,
          onChanged: (value) => setState(() => selectedCODArea = value!),
        ),
        RadioListTile<String>(
          title: const Text("Outside Dhaka (৳110)"),
          value: 'outside',
          groupValue: selectedCODArea,
          onChanged: (value) => setState(() => selectedCODArea = value!),
        ),
      ],
    );
  }

  void _confirmOrder() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("✅ Order Confirmed"),
        content: Text("Your order of ৳${totalAmount.toStringAsFixed(2)} has been placed successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              Navigator.of(context).pop(); // back to cart or home
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
