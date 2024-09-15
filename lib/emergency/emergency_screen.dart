import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Emergency',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              color: ColorPalette.grey1,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for emergency services',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white, // Red border for enabled state
                      width: 1.0, // You can adjust the thickness
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white, // Red border for enabled state
                      width: 1.0, // You can adjust the thickness
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Red border for focused state
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Gap
          const SizedBox(height: 10),
          // Scrollable list of cards
          Expanded(
            child: Container(
              color: ColorPalette.grey1,
              child: ListView(
                children: [
                  EmergencyCardWidget(
                    title: 'Mirissa Police Station',
                    distance: '3km away',
                    duration: 'Open 24 hours',
                    contact: '076 646 6464',
                    address: 'Mirissa, Sri Lanka',
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTp0myo49LHUyp20cwxAtAcp2BZJJhWcDcENQ&s',
                    onTap: () {},
                  ),
                  EmergencyCardWidget(
                    title: 'Nawaloka Hospital',
                    distance: '5km away',
                    duration: 'Open 24 hours',
                    contact: '079 989 8989',
                    address: 'Colombo, Sri Lanka',
                    imageUrl: 'https://s3.amazonaws.com/bizenglish/wp-content/uploads/2022/08/23121759/nava.png',
                    onTap: () {},
                  ),
                  EmergencyCardWidget(
                    title: 'Rescue 911',
                    distance: '10km away',
                    duration: 'Open 24 hours',
                    contact: '077 777 7777',
                    address: 'Colombo, Sri Lanka',
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-HFNMTbljHpxsVGcojCsNv9K5qoAScgFOVw&s',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyCardWidget extends StatelessWidget {
  final String title;
  final String distance;
  final String duration;
  final String contact;
  final String address;
  final String imageUrl;
  final VoidCallback onTap;

  // Constructor to accept data dynamically
  const EmergencyCardWidget({
    super.key, 
    required this.title,
    required this.distance,
    required this.duration,
    required this.contact,
    required this.address,
    required this.imageUrl,
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Provider Image with border radius
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Add border radius
                    child: Image.network(
                      imageUrl, // Dynamic image from constructor
                      width: 115,
                      height: 60,
                      fit: BoxFit.cover, // Ensures the image fits within the box
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
                        Icons.av_timer,
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
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: ColorPalette.green,
                      ),
                      const SizedBox(width: 8),
                      Text(distance, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  // Data Only
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.call,
                        size: 20,
                        color: ColorPalette.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        contact,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
                      backgroundColor: ColorPalette.green,
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text('Call Now', style: TextStyle(fontWeight: FontWeight.bold)),
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
