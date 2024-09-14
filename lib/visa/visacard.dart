import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisaCard extends StatelessWidget {
  final String backgroundImagePath;
  final String foregroundImagePath;
  final String visaType;
  final String duration;
  final VoidCallback onApply;
  final List<String> features;
  final Color backgroundColor;
  final Color buttonColor;

  const VisaCard({
    super.key,
    required this.backgroundImagePath,
    required this.foregroundImagePath,
    required this.visaType,
    required this.duration,
    required this.features,
    required this.onApply,
    this.backgroundColor = const Color(0xFF2A966C), // Default background color
    this.buttonColor = const Color(0xFF2A966C), // Default button color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      elevation: 5,
      child: SizedBox(
        width: 250, // Set your desired card width
        height: 300, // Set your desired card height
        child: Stack(
          children: [
            // Background image with custom color blending
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  backgroundImagePath, // Path to your background image
                  fit: BoxFit.cover,
                  color: backgroundColor
                      .withOpacity(0.8), // Custom background color blend
                  colorBlendMode:
                      BlendMode.softLight, // Set blend mode to softLight
                ),
              ),
            ),
            // Foreground image (Person)
            Positioned(
              bottom: 0,
              right: 1,
              child: Image.asset(
                foregroundImagePath, // Path to your foreground image
                height: 200,
              ),
            ),
            // Text and button content
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visaType,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: features.map((feature) {
                      return Text(
                        "• $feature",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // Apply Now button with custom button color
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      buttonColor.withOpacity(0.8), // Custom button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Apply Now",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to be passed to VisaCard
Future<void> _applyForVisa(BuildContext context) async {
  try {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle user not logged in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    // Create a new visa document
    DocumentReference visaRef =
        await FirebaseFirestore.instance.collection('visas').add({
      'type': "normal",
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Create a new visa application document
    await FirebaseFirestore.instance.collection('visa applications').add({
      'ongoing': true,
      'status': 'Ongoing',
      'userRef': FirebaseFirestore.instance.collection('users').doc(user.uid),
      'visa': visaRef,
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Visa application initiated successfully')),
    );

    // Optionally, navigate to another page or reset state
    Navigator.pop(context);
  } catch (e) {
    // Handle errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}
