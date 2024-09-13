import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore for username

class BookingPage extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String packageName;
  final String imageURL;
  final bool isPaymentButton;

  // Constructor
  BookingPage({
    required this.date,
    required this.time,
    required this.packageName,
    required this.imageURL,
    required this.isPaymentButton,
  });

  @override
  Widget build(BuildContext context) {
    // Fetching the currently logged-in user
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display User Information
            if (currentUser != null)
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    var userData = snapshot.data!.data() as Map<String, dynamic>;
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${userData['username'] ?? 'No Name'}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Email: ${currentUser.email ?? 'No Email'}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text('Error fetching user data');
                },
              ),

            const SizedBox(height: 16),

            // Container for Image and Package Name
            Container(
              color: Colors.green.withOpacity(0.3),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Display the image
                  Image.asset(
                    imageURL,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  // Display the package name
                  Expanded(
                    child: Text(
                      packageName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Container with Date and Time
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today),
                      const SizedBox(width: 8),
                      Text(
                        'Date: ${date.toLocal().toShortDateString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text(
                        'Time: ${time.format(context)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Conditional Pay and Confirm Button
            if (isPaymentButton)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic for payment or confirmation action
                    print("Pay and Confirm");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.green,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: const Text('Pay and Confirm'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Extension for formatting the Date
extension DateTimeExtensions on DateTime {
  String toShortDateString() {
    return '${this.day}-${this.month}-${this.year}';
  }
}