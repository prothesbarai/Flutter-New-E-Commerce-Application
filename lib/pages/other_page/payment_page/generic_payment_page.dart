import 'package:flutter/material.dart';
import 'package:AppStore/utils/AppColor.dart';

import '../../../dialogs/showConfirmationDialog.dart';

class GenericPaymentPage extends StatefulWidget {
  final String method;
  final double amount;

  const GenericPaymentPage({super.key, required this.method, required this.amount});

  @override
  State<GenericPaymentPage> createState() => _GenericPaymentPageState();
}

class _GenericPaymentPageState extends State<GenericPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _txnIdController = TextEditingController();

  bool _isAccountValid = false;
  bool _isTxnIdValid = false;

  @override
  void dispose() {
    _accountController.dispose();
    _txnIdController.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: color));
  }

  InputDecoration _inputDecoration({
    required String label,
    required bool isValid,
  }) {
    return InputDecoration(
      labelText: label,
      border: _border(Colors.grey),
      enabledBorder: _border(isValid ? Colors.green : Colors.grey),
      focusedBorder: _border(isValid ? Colors.green : AppColor.pink1),
      errorBorder: _border(Colors.red),
      focusedErrorBorder: _border(Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.method} Payment', style: const TextStyle(color: AppColor.pink1)),
        iconTheme: const IconThemeData(color: AppColor.pink1),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📱 Pay using ${widget.method}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Amount to pay: ৳${widget.amount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(
                  label: '${widget.method} Account Number',
                  isValid: _isAccountValid,
                ),
                onChanged: (value) {
                  setState(() {
                    _isAccountValid = value.isNotEmpty;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _isAccountValid = false;
                    return 'Please enter your ${widget.method} account number';
                  }
                  _isAccountValid = true;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _txnIdController,
                decoration: _inputDecoration(
                  label: 'Transaction ID (after sending)',
                  isValid: _isTxnIdValid,
                ),
                onChanged: (value) {
                  setState(() {
                    _isTxnIdValid = value.isNotEmpty;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _isTxnIdValid = false;
                    return 'Please enter the transaction ID';
                  }
                  _isTxnIdValid = true;
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showConfirmationDialog(context, "Payment Received", "Your ${widget.method} payment of ", " ৳${widget.amount.toStringAsFixed(2)}", " has been confirmed.");
                    }
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
        ),
      ),
    );
  }
}