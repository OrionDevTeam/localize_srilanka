import 'package:flutter/material.dart';
import 'package:localize_sl/guide_pages/guide_model.dart';
import 'package:localize_sl/payment/payment.dart';
import 'package:localize_sl/screens/users/user_main.dart';

class PaymentPage extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String packageName;
  final String imageURL;
  final Guide guide;

  const PaymentPage({
    super.key,
    required this.date,
    required this.time,
    required this.packageName,
    required this.imageURL,
    required this.guide,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Custom form widget
          CardFormPage(), // Reuse the card form page
      
          const SizedBox(height: 20),
      
          ElevatedButton(
            onPressed: () {
              // Handle submit action and navigate to UserMainPage
              print('Payment Submitted');
      
              // Navigate to UserMainPage after clicking submit
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserPage(), // Replace with actual page
                ),
                (Route<dynamic> route) => false, // Removes all previous routes
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              backgroundColor: const Color(0xFF2A966C),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}