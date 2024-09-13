import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_sl/chat.dart';
import 'package:localize_sl/guide_pages/guide_list_page.dart';

import '../screens/map/map_home.dart';

import 'SIM/sim_home.dart';
import 'vehicle/vehicle_main.dart';
import 'visa/widgets/banner.dart';

class HomeScreen extends StatelessWidget {
  final dynamic user;

  const HomeScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter, // Fill vertically
        //     colors: [
        //       Color(0xFF2A966C), // Start color
        //       Colors.white, // End color
        //     ],
        //     stops: [0.5, 0.5], // Stops to define where the colors transition
        //   ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.0, 0.0),
            colors: [
              Color(0xFF2A966C),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Localize Srilanka",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Row with 5 Images (SVG)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50, // Set the height for the image
                                  width: 50, // Set the width for the image
                                  child: SvgPicture.asset(
                                    'assets/features/ticket.svg',
                                    fit: BoxFit
                                        .contain, // Ensures the asset fits within the box
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Experiences',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2A966C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to MyApp page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const VehicleScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50, // Set the height for the image
                                    width: 50, // Set the width for the image
                                    child: SvgPicture.asset(
                                      'assets/features/sim.svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Networks',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF2A966C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Panorama page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SimCardsPage()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50, // Set the height for the image
                                    width: 50, // Set the width for the image
                                    child: SvgPicture.asset(
                                      'assets/features/hotel.svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '360',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF2A966C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 50, // Set the height for the image
                                  width: 50, // Set the width for the image
                                  child: SvgPicture.asset(
                                    'assets/features/shopping.svg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Shopping',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2A966C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF00BA72), // Start color of gradient
                                  Color(0xFF2A966C), // End color of gradient
                                ],
                                begin: Alignment
                                    .topLeft, // Starting point of the gradient
                                end: Alignment
                                    .bottomRight, // Ending point of the gradient
                              ),
                              borderRadius: BorderRadius.circular(
                                  7), // Match the button's border radius
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MapS(showBackButton: true),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                ), // Adjust button padding
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      7), // Match the container's radius
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center the content
                                  children: [
                                    Icon(
                                      Iconsax.map,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                        width:
                                            8), // Space between icon and text
                                    Text(
                                      'Explore map',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
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
                  const SizedBox(height: 20),
                  const Text(
                    'Apply for SriLankan Visa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const VisaBanner(
                    backgroundColor: Color(0xFF2A966C),
                    buttonColor: Color(0xFF286A50),
                    textColor: Colors.white,
                    text:
                        'Get Your Sri Lankan Tourist Visa Hassle-Free with Us!',
                    imagePath: 'assets/visa/girl.png',
                  ),
                  // Container with an SVG Image
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const VisaHomePage()),
                  //     );
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 150,
                  //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(12),
                  //       child: SvgPicture.asset(
                  //         'assets/features/visaprocess.svg',
                  //         fit: BoxFit.fill,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 20),
                  const Text(
                    'New Localize Features',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatBotPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Change SvgPicture.asset to Image.asset
                                Container(
                                  height: 100, // Adjust height as needed
                                  width: 100, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        12), // Optional for rounded corners
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners for the image
                                    child: Image.asset(
                                      'assets/vimosh/localx.png', // Path to your image asset
                                      fit: BoxFit
                                          .cover, // Ensures the image covers the box entirely
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        10), // Add spacing between the image and text
                                const Text(
                                  'Vidara',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatBotPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Change SvgPicture.asset to Image.asset
                                Image.asset(
                                  'assets/vimosh/360.png', // Path to your image asset
                                  height: 100, // Adjust height as needed
                                  width: 80, // Adjust width as needed
                                ),
                                const SizedBox(
                                    height:
                                        10), // Add spacing between the image and text
                                const Text(
                                  '360',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuideListPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Change SvgPicture.asset to Image.asset
                                Image.asset(
                                  'assets/vimosh/guidex.jpg', // Path to your image asset
                                  height: 100, // Adjust height as needed
                                  width: 100, // Adjust width as needed
                                ),
                                const SizedBox(
                                    height:
                                        10), // Add spacing between the image and text
                                const Text(
                                  'Localizers',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Experineces in Srilanka',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                  ),
                  items: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AnotherPage()),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/experiences/Surfing.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 110,
                            child: Text(
                              "Surfing",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AnotherPage()),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/experiences/camping.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 100,
                            child: Text(
                              "Camping",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AnotherPage()),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/experiences/ele_safari.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 80,
                            child: Text(
                              "Elephant Safari",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//remove this and put this as visa form page in a different file
class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: const Center(
        child: Text('This is another page'),
      ),
    );
  }
}
