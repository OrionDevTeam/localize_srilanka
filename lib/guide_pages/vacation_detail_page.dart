import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';
import 'package:localize_sl/guide_pages/guide_model.dart';
import 'package:localize_sl/calendar.dart';
import '../widgets/vactionCard.dart';

class VacationDetailPage extends StatelessWidget {
  final List<String> imgList = [
    'assets/biru/image_1.jpg',
    'assets/biru/image_2.jpg',
    'assets/biru/image_3.jpg',
  ];

  final Guide guide; // Add guide object here

  VacationDetailPage(
      {super.key, required this.guide}); // Include guide in constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiences'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/vimosh/camping1.jpg', // Corrected the path separator
                      width: double.infinity,
                      height: 250.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Camping',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CalendarPage(
                                      packageName: 'Camping',
                                      imageURL: 'assets/biru/image_13.jpg',
                                      guide: guide,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorPalette.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: const Text(
                                "Reserve",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey[600]),
                            const SizedBox(width: 4.0),
                            Text(
                              'Secret Beach - Mirrisa',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Enjoy your camping with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Additional Experiences',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AditionalExp(
                          title: 'Bullock - Cart Ride',
                          price: 'LKR 1500 / pp',
                          imageUrl: 'assets/vimosh/bull.webp',  
                        ),
                        SizedBox(width: 8.0),
                        AditionalExp(
                          title: 'Sri Lankan - Style Buffett',
                          price: 'LKR 3000 / pp',
                          imageUrl: 'assets/vimosh/food.webp',  
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                          'Additional Experiences',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AditionalExp(
                          title: 'Drone',
                          price: 'LKR 1500 / pp',
                          imageUrl: 'assets/vimosh/drone.jpg',  
                        ),
                        SizedBox(width: 8.0),
                        AditionalExp(
                          title: '360 camera',
                          price: 'LKR 3000 / pp',
                          imageUrl: 'assets/vimosh/360.jpeg',  
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 200.0,
                  //   child: CarouselSlider(
                  //     options: CarouselOptions(
                  //       height: 200.0,
                  //       autoPlay: true,
                  //       enlargeCenterPage: true,
                  //       enableInfiniteScroll: true,
                  //       viewportFraction: 0.8,
                  //     ),
                  //     items: imgList
                  //         .map((item) => ClipRRect(
                  //               borderRadius: BorderRadius.circular(16.0),
                  //               child: Image.asset(item,
                  //                   fit: BoxFit.cover, width: double.infinity),
                  //             ))
                  //         .toList(),
                  //   ),
                  // ),
                  // const SizedBox(height: 16.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => CalendarPage(
                  //               packageName: 'Camping',
                  //               imageURL: 'assets/biru/image_13.jpg',
                  //               guide: guide,
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor:
                  //             const Color.fromARGB(255, 22, 156, 140),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(16.0),
                  //         ),
                  //       ),
                  //       child: const Text(
                  //         "Reserve",
                  //         style: TextStyle(
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
