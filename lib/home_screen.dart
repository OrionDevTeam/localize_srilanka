import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  final dynamic user; // Assuming user object is passed as a parameter

  const HomeScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true, // This makes the search bar filled with a color
                      fillColor: Colors.grey[200], // This sets the background color of the search bar
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none, // Remove the border
                      ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(18),
                      //   borderSide: BorderSide(
                      //     color: Colors.green, // Set the color of the border when enabled
                      //     width: 2.0, // Set the width of the border
                      //   ),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFF2A966C), // Set the color of the border when focused
                          width: 2.0, // Set the width of the border
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Top Container with Images and Button
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
                        // Row with 5 Images
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            5,
                            (index) => CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/features/image$index.png'), // Replace with your image assets
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Full-width Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Button action here
                            },
                            icon: const Icon(
                              Iconsax.map,  // Use Iconsax.map or any other appropriate icon
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Explore Map',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color(0xFF2A966C),  // Set text color to white
                              padding: const EdgeInsets.symmetric(vertical: 16.0),  // Adjust padding as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),  // Optional: Set rounded corners
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Text
                  const Text(
                    'Apply for SriLankan Visa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Container with an Image
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AnotherPage()), // Replace with your target page
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/features/visa.png'), // Replace with your image asset
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Text
                  const Text(
                    'LOCALIZE features',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Row with 2 Containers with Images
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnotherPage()), // Replace with your target page
                            );
                          },
                          child: Container(
                            height: 150,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: AssetImage('assets/features/image7.png'), // Replace with your image asset
                                fit: BoxFit.cover,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
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
                              MaterialPageRoute(builder: (context) => const AnotherPage()), // Replace with your target page
                            );
                          },
                          child: Container(
                            height: 150,
                            margin: const EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: AssetImage('assets/image8.png'), // Replace with your image asset
                                fit: BoxFit.cover,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Text
                  const Text(
                    'Carousel Slider',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Vertical Carousel Slider with Containers
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AnotherPage()), // Replace with your target page
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage('assets/image9.png'), // Replace with your image asset
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
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

// Replace with your target page
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
