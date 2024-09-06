import 'package:flutter/material.dart';

class VisaCard extends StatelessWidget {
  final String backgroundImagePath;
  final String foregroundImagePath;
  final String visaType;
  final String duration;
  final List<String> features;
  final VoidCallback onApply;
  final Color backgroundColor;
  final Color buttonColor;

  const VisaCard({
    Key? key,
    required this.backgroundImagePath,
    required this.foregroundImagePath,
    required this.visaType,
    required this.duration,
    required this.features,
    required this.onApply,
    this.backgroundColor = const Color(0xFF2A966C), // Default background color
    this.buttonColor = const Color(0xFF2A966C), // Default button color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      elevation: 5,
      child: Container(
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
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: features.map((feature) {
                      return Text(
                        "• $feature",
                        style: TextStyle(
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
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
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
