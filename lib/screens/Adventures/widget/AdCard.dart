import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';

// Reusable Homestay Card Widget
class AdCard extends StatelessWidget {
  // Add parameters for dynamic content
  final String imageUrl;
  final String title;
  final String location;
  final String rating;
  // ignore: non_constant_identifier_names
  final VoidCallback OnTap;

  // Constructor for the widget
  const AdCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    // ignore: non_constant_identifier_names
    required this.OnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3, // Shadow effect
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imageUrl, // Dynamic image URL
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16), // Space between image and text
              // Text Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title, // Dynamic title
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Location
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.grey[600],
                    //       size: 16,
                    //     ),
                    //     const SizedBox(width: 4),
                    //     Text(
                    //       location, // Dynamic location
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.grey[600],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 4),
                    // Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: const Column(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          rating.toString(), // Dynamic rating
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 40),
                        GestureDetector(
                          onTap: OnTap, // Your onTap handler
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    16), // Adjust padding for button-like appearance
                            decoration: BoxDecoration(
                              color: ColorPalette.green.withOpacity(
                                  0.1), // Similar background color as before
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: const Text(
                              'View More',
                              style: TextStyle(
                                color: ColorPalette
                                    .green, // Same text color as before
                                fontSize: 16, // Adjust font size if needed
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Button for View More
            ],
          ),
        ),
      ),
    );
  }
}
