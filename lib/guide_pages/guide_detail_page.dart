import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_sl/colorpalate.dart';
import 'package:localize_sl/guide_pages/contact_page.dart';
import 'package:localize_sl/guide_pages/vacation_detail_page.dart';
import 'package:localize_sl/screens/guides/guidereel.dart';
import 'guide_model.dart';

class GuideDetailPage extends StatefulWidget {
  final String userId;

  const GuideDetailPage({super.key, required this.userId});

  @override
  _GuideDetailPageState createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends State<GuideDetailPage> {
  int _selectedIndex = 0;
  List<DocumentSnapshot> memories = [];
  Guide? guide; // Guide object to hold the fetched data
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    fetchGuideInfo();
  }

  void fetchGuideInfo() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (doc.exists) {
        setState(() {
          guide =
              Guide.fromFirestore(doc); // Pass the DocumentSnapshot directly
          isLoading = false;
        });
      } else {
        // Handle case where guide is not found
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching guide data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      fetchMemories();
    }
  }

  void fetchMemories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('memories')
        .where('userId', isEqualTo: widget.userId)
        .get();
    setState(() {
      memories = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Guide Profile'),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );
    }

    if (guide == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Guide Profile'),
        ),
        body: const Center(
          child: Text('Guide not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.favorite_border),
        //     onPressed: () {
        //       // Handle favorite button press
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: guide!.profileImageUrl.isNotEmpty
                    ? NetworkImage(guide!.profileImageUrl)
                        as ImageProvider // Cast to ImageProvider
                    : const AssetImage(
                        'assets/placeholder.jpg'), // Placeholder image asset path
              ),

              const SizedBox(height: 16.0),
              Text(
                guide!.username,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'LOCALIZE ${guide!.user_role.toUpperCase()}',
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(137, 22, 1, 1)),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  guide!.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 4),
                          Text(guide!.rating.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      Text('(${guide!.reviews} reviews)'),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [Text(guide!.Average_hourly_rate)],
                      ),
                      const Text(
                          'Average Hourly rate'), // Example, adjust as per your structure
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              // Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.card_giftcard, 'Packages', 0),
                  _buildNavItem(Icons.handshake, 'Services', 1),
                  _buildNavItem(Icons.photo_album, 'Memories', 2),
                  _buildNavItem(Icons.contact_mail, 'Contact Me', 3),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16.0),
              // Content based on selected index
              if (_selectedIndex == 0) ...[
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Available Packages',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

SingleChildScrollView(
  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
  child: Row(
    children: List.generate(guide!.packages.length, (index) {
      var package = guide!.packages[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VacationDetailPage(guide: guide!),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          width: 200.0,
          height: 280, // Width of each item (adjust as needed)
          child: ShortVideoThumbnail(
            imageRef: package['image'],
            description: package['price'],
          ),
        ),
      );
    }),
  ),
)

                // const SizedBox(height: 16.0),
                // const Text(
                //   'Experiences',
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(height: 8.0),
                // CarouselSlider.builder(
                //   options: CarouselOptions(
                //     height: 200.0,
                //     enlargeCenterPage: true,
                //     enableInfiniteScroll: true,
                //     autoPlay: true,
                //     viewportFraction: 0.8,
                //     autoPlayInterval: const Duration(seconds: 3),
                //     autoPlayAnimationDuration:
                //         const Duration(milliseconds: 800),
                //   ),
                //   itemCount: guide!.experiences.length,
                //   itemBuilder: (context, index, realIdx) {
                //     var experience = guide!.experiences[index];
                //     return ExperienceThumbnail(
                //       imageRef: experience['image'],
                //       description: experience['description'],
                //     );
                //   },
                // ),
              ] else if (_selectedIndex == 1) ...[
                SizedBox(
                  height: 250.0, // Adjust height as needed
                  child: ListView(
                    shrinkWrap: true,
                    children: guide!.services.map((service) {
                      return ServiceCard(
                        day: service['day'],
                        time: service['time'],
                        title: service['title'],
                        description: service['description'],
                        attendees: service['attendees'],
                        imageRef: service['image'],
                      );
                    }).toList(),
                  ),
                ),
              ] else if (_selectedIndex == 2) ...[
                // Text(
                //   "${guide!.username}'s Memories",
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 8.0),
                if (memories.isEmpty)
                  const Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  ))
                else
                  Container(
                    height: 1200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SocialMediaFeedy(
                      userId: widget.userId,
                    ),
                  ),
              ] else if (_selectedIndex == 3) ...[
                ContactPage(guide: guide!),
              ],
              const SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: () {
              //     // Handle book mentoring
              //   },
              //   child: Text('Book Mentoring'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? ColorPalette.green : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? ColorPalette.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class ShortVideoThumbnail extends StatelessWidget {
  final String imageRef;
  final String description;

  const ShortVideoThumbnail({
    required this.imageRef,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(imageRef),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                // backgroundColor: Colors.black54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
              description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                // backgroundColor: Colors.black54,
              ),
            ),
      ],
    );
  }
}

class ExperienceThumbnail extends StatelessWidget {
  final String imageRef;
  final String description;

  const ExperienceThumbnail({
    required this.imageRef,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            // backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String day;
  final String time;
  final String title;
  final String description;
  final String attendees;
  final String imageRef;

  const ServiceCard({
    required this.day,
    required this.time,
    required this.title,
    required this.description,
    required this.attendees,
    required this.imageRef,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageRef,
                  width: double.infinity,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(description),
                  Text('Attendees: $attendees'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemoryGridItem extends StatelessWidget {
  final String imageRef;
  final String description;

  const MemoryGridItem({
    required this.imageRef,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageRef,
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
