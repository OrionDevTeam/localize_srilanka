import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';

class SimCardWidget extends StatelessWidget {
  final String title;
  final String reviews;
  final String duration;
  final String network;
  final String dataType;
  final String price;
  final String imagePath;
  final VoidCallback onTap;

  // Constructor to accept data dynamically
  const SimCardWidget({super.key, 
    required this.title,
    required this.reviews,
    required this.duration,
    required this.network,
    required this.dataType,
    required this.price,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Makes the whole card tappable
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Title and Star Rating
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '4.8',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              reviews,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Provider Image with border radius
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Add border radius
                    child: Image.asset(
                      imagePath, // Dynamic image from constructor
                      width: 85,
                      height: 60,
                      fit:
                          BoxFit.cover, // Ensures the image fits within the box
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Details Row (Duration, Network, Data Type)
              Row(
                children: [
                  // Duration
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: ColorPalette.green,
                      ),
                      const SizedBox(width: 8),
                      Text(duration, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  // Network
                  Row(
                    children: [
                      Image.asset(
                        'assets/SIM/speed.png', // Dynamic image from constructor
                        height: 30,
                        fit: BoxFit
                            .cover, // Ensures the image fits within the box
                      ),
                      const SizedBox(width: 8),
                      Text(network, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  // Data Only
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    'assets/SIM/signal.png', // Dynamic image from constructor
                    width: 20,
                    fit: BoxFit.cover, // Ensures the image fits within the box
                  ),
                  const SizedBox(width: 8),
                  Text(network, style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'per SIM card',
                        style: TextStyle(
                          color: Color.fromARGB(134, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: onTap, // Action for Book Now button
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFFEFEFEF), // Button color
                      foregroundColor: Colors.black, // Text color
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text('Book now'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
