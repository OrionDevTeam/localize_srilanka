import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/guide_pages/guide_model.dart'; // Import Firestore for username
// import '../payment.dart';
import 'package:localize_sl/payment.dart';

class BookingPage extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String packageName;
  final String imageURL;
  final bool isPaymentButton;
  final Guide guide;

  // Constructor
  const BookingPage({super.key, 
    required this.date,
    required this.time,
    required this.packageName,
    required this.imageURL,
    required this.isPaymentButton,
    required this.guide,
  });

  @override
  Widget build(BuildContext context) {
    // Fetching the currently logged-in user
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
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
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${userData['username'] ?? 'No Name'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Email: ${currentUser.email ?? 'No Email'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Text('Error fetching user data');
                },
              ),

            const SizedBox(height: 10),

            // Container for Image and Package Name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF2A966C).withOpacity(0.3), // Background color
                border: Border.all(
                  // Add the border
                  color: const Color(0xFF2A966C).withOpacity(0.1), // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
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
                      '$packageName with \n${guide.username}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // New Container with the guide's profile image, name, rating, and location
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF2A966C).withOpacity(0.3), width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Display guide's profile image
                  ClipOval(
                    child: Image.network(
                      guide.profileImageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Display guide's name, rating, and location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guide.username,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rating: ${guide.rating.toString()}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Location: ${guide.location}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container with Date and Time (icons one under the other)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Color(0xFF2A966C)),
                              const SizedBox(width: 8),
                              Text(
                                date.toLocal().toShortDateString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Color(0xFF2A966C)),
                              const SizedBox(width: 8),
                              Text(
                                time.format(context),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          date: date,
                          time: time,
                          packageName: packageName,
                          imageURL: imageURL,
                          guide: guide,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: const Color(0xFF2A966C),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Pay and Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
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
    return '$day/$month/$year';
  }
}
