import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';

import 'screens/simcard_detail.dart';
import 'widgets/simwidget.dart';

class SimCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Wifi & Sim Cards',
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
                  hintText: 'Choose your sim card',
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
                  SimCardWidget(
                    title:
                        'eSIM Sri Lanka with high-speed and stable internet connection',
                    reviews: '(35 Reviews)',
                    duration: '3 - 30 days',
                    network: '4G / 5G',
                    dataType: 'Data Only',
                    price: 'LKR 500.00',
                    imagePath: 'assets/SIM/hutch.png', // Your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimCardDetailWidget(
                            reviews: '(35 Reviews)',
                            duration: '3 - 30 days',
                            network: '4G / 5G',
                            dataType: 'Data Only',
                            price: 'LKR 500.00',
                            imagePath: 'assets/SIM/hutchbg.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  SimCardWidget(
                    title: 'Mobitel 4G SIM Card with 5GB data',
                    reviews: '(25 Reviews)',
                    duration: '7 - 14 days',
                    network: '4G',
                    dataType: 'Data & Calls',
                    price: 'LKR 1000.00',
                    imagePath: 'assets/SIM/mobitel.jpg', // Your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimCardDetailWidget(
                            reviews: '(25 Reviews)',
                            duration: '7 - 14 days',
                            network: '4G',
                            dataType: 'Data & Calls',
                            price: 'LKR 1000.00',
                            imagePath: 'assets/SIM/mobitelbg.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  SimCardWidget(
                    title: 'Dialog 4G SIM Card with 10GB data',
                    reviews: '(45 Reviews)',
                    duration: '30 - 60 days',
                    network: '4G / 5G',
                    dataType: 'Data & Calls',
                    price: 'LKR 1500.00',
                    imagePath: 'assets/SIM/dialog.webp', // Your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimCardDetailWidget(
                            reviews: '(45 Reviews)',
                            duration: '7 - 14 days',
                            network: '4G / 5G',
                            dataType: 'Data & Calls',
                            price: 'LKR 1500.00',
                            imagePath: 'assets/SIM/dialogbg.jpg',
                          ),
                        ),
                      );
                    },
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
