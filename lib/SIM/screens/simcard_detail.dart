import 'package:flutter/material.dart';

import '../widgets/selected_card.dart';

class SimCardDetailWidget extends StatelessWidget {
  final String title;
  final String reviews;
  final String duration;
  final String network;
  final String dataType;
  final String price;
  final String imagePath;

  const SimCardDetailWidget({super.key, 
    required this.title,
    required this.reviews,
    required this.duration,
    required this.network,
    required this.dataType,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Set the title of the AppBar
        backgroundColor: Colors.white, // You can customize the color
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 270,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover, // Fit the image to cover
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 240,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), // Rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'eSIM Sri Lanka with high - speed and stable internet connection',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '4.8',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          reviews,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Package options',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Popins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                      'Package type',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        // Data in total button
                        Expanded(
                          child: PackageOptionButton(
                            label: 'Data in total',
                            isSelected: true, // Selected state
                          ),
                        ),
                        SizedBox(width: 10),
                        // Data per day button
                        Expanded(
                          child: PackageOptionButton(
                            label: 'Data per day',
                            isSelected: false,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Network: $network',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Data Type: $dataType',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Price: $price',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
