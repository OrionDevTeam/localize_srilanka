import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ImageOverlayCard extends StatelessWidget {
  final String imagePath; // Path for the asset image
  final Color overlayColor; // Color of the transparent overlay
  final double borderRadius; // Border radius for the image and overlay
  final VoidCallback? onTap;
  final String title;
  final String distance;
  final String duration;
  final String crowd;

  const ImageOverlayCard({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.title,
    required this.distance,
    required this.duration,
    required this.crowd,
    this.overlayColor =
        const Color.fromRGBO(0, 0, 0, 0.5), // Default is black with 50% opacity
    this.borderRadius = 16.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(borderRadius), // Apply border radius
        child: Stack(
          children: [
            // Image at the bottom
            Image.asset(
              height: 250,
              width: 345,
              imagePath,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 15,
              left: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: overlayColor,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 10.0),
                    child: Text(
                      crowd,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  color: overlayColor,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Info section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  distance,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                const Icon(
                                  Icons.directions_walk,
                                  color: Colors.white70,
                                  size: 11,
                                ),
                                Text(
                                  duration,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // View button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BA72),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onTap,
                          child: const Row(
                            children: [
                              Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Iconsax.box_2,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
