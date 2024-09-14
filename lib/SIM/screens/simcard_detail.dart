import 'package:flutter/material.dart';
import 'package:localize_sl/SIM/widgets/bottom_nav.dart';
import '../widgets/selected_card.dart';

class SimCardDetailWidget extends StatelessWidget {
  final String reviews;
  final String duration;
  final String network;
  final String dataType;
  final String price;
  final String imagePath;

  SimCardDetailWidget({
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
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius:
                            BorderRadius.circular(12), // Add border radius
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Package type',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
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
                            SizedBox(height: 20),
                            Text(
                              'Package type',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    // Data in total button
                                    Expanded(
                                      child: PackageOptionButton(
                                        label: '7 days',
                                        isSelected: false, // Selected state
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Data per day button
                                    Expanded(
                                      child: PackageOptionButton(
                                        label: '14 days',
                                        isSelected: false,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    // Data in total button
                                    Expanded(
                                      child: PackageOptionButton(
                                        label: '21 days',
                                        isSelected: false, // Selected state
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Data per day button
                                    Expanded(
                                      child: PackageOptionButton(
                                        label: '28 days',
                                        isSelected: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    // Data in total button
                                    Expanded(
                                      child: PackageOptionButton(
                                        label: '30 days',
                                        isSelected: false, // Selected state
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Data per day button
                                    Expanded(
                                      child: PackageOptionButton(
                                        label: '60 days',
                                        isSelected: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Usage validity',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Popins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Column(
                      children: [
                        Text(
                          'The voucher is valid for 180 days from the booking confirmation date.It expires at the same booking confirmation time on the last day. ( I.e if the booking confirmation time at 17.00, it will expire at 17.00 180 days later )',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Popins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BookNowBar(
                pricePerHour: price,
              ))
        ],
      ),
    );
  }
}
