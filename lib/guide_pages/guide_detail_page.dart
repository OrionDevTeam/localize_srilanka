import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_sl/guide_pages/contact_page.dart';
import 'package:localize_sl/guide_pages/vacation_detail_page.dart';
import 'package:localize_sl/screens/guides/guidereel.dart';
import 'guide_model.dart';

class GuideDetailPage extends StatefulWidget {
  final String userId;

  GuideDetailPage({required this.userId});

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
          title: Text('Guide Profile'),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );
    }

    if (guide == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Guide Profile'),
        ),
        body: Center(
          child: Text('Guide not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Handle favorite button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: guide!.profileImageURL.isNotEmpty
                    ? NetworkImage(guide!.profileImageURL)
                        as ImageProvider // Cast to ImageProvider
                    : AssetImage(
                        'assets/placeholder.jpg'), // Placeholder image asset path
              ),

              SizedBox(height: 16.0),
              Text(
                guide!.username,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                guide!.bio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star),
                      Text('${guide!.reviews} reviews'),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [Text("${guide!.Average_hourly_rate}")],
                      ),
                      Text(
                          '  Average Hourly rate'), // Example, adjust as per your structure
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(),
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
              Divider(),
              SizedBox(height: 16.0),
              // Content based on selected index
              if (_selectedIndex == 0) ...[
                Text(
                  'Available Packages',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 300.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                  itemCount: guide!.packages.length,
                  itemBuilder: (context, index, realIdx) {
                    var package = guide!.packages[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VacationDetailPage(),
                          ),
                        );
                      },
                      child: ShortVideoThumbnail(
                        imageRef: package['image'],
                        description: package['price'],
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Experiences',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.8,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                  itemCount: guide!.experiences.length,
                  itemBuilder: (context, index, realIdx) {
                    var experience = guide!.experiences[index];
                    return ExperienceThumbnail(
                      imageRef: experience['image'],
                      description: experience['description'],
                    );
                  },
                ),
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
                SizedBox(height: 8.0),
                if (memories.isEmpty)
                  Center(
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
              SizedBox(height: 16.0),
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
            color: _selectedIndex == index ? Colors.green : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.green : Colors.grey,
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class ExperienceThumbnail extends StatelessWidget {
  final String imageRef;
  final String description;

  const ExperienceThumbnail({
    required this.imageRef,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            backgroundColor: Colors.black54,
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
    Key? key,
  }) : super(key: key);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text('$day, $time'),
                Text(description),
                Text('Attendees: $attendees'),
              ],
            ),
          ),
        ],
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
    Key? key,
  }) : super(key: key);

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
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
