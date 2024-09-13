import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_sl/guide_pages/guide_model.dart';
import 'guide_reserve_page.dart';
import 'package:localize_sl/calendar.dart';

class VacationDetailPage extends StatelessWidget {
  final List<String> imgList = [
    'assets/biru/image_1.jpg',
    'assets/biru/image_2.jpg',
    'assets/biru/image_3.jpg',
  ];

  final Guide guide; // Add guide object here

  VacationDetailPage({super.key, required this.guide}); // Include guide in constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    'assets/biru/image_13.jpg', // Corrected the path separator
                    width: double.infinity,
                    height: 250.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Camping',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[600]),
                const SizedBox(width: 4.0),
                Text(
                  'Mountain Resort',
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
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Preview',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
              items: imgList
                  .map((item) => ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:
                            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      ))
                  .toList(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarPage(
                          packageName: 'Camping',
                          imageURL : 'assets/biru/image_13.jpg',
                          guide: guide!,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 22, 156, 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text(
                    "Reserve",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
