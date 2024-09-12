import 'package:flutter/material.dart';

import '../visahome.dart';

class VisaBanner extends StatelessWidget {
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final String text;
  final String imagePath;

  const VisaBanner({
    super.key,
    required this.backgroundColor,
    required this.buttonColor,
    required this.textColor,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Visa Home screen on tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VisaHomePage()),
        );
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 30, // Set height
                      width: 100, // Set width
                      child: ElevatedButton(
                        onPressed: () {
                          // Add the logic for the button here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Set border radius
                          ),
                        ),
                        child: const Text(
                          'Apply Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              imagePath,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
