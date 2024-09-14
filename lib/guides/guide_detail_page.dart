import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'guide_model.dart';
import 'guide_contact_page.dart';
import 'guide_reserve.dart';

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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VacationDetailPage(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: 300,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageRef,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 250),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> thumbnailDescription = [
  {'description': 'description'},
  {'description': 'description'},
  {'description': 'description'},
  {'description': 'description'},
];

class GuideDetailPage extends StatelessWidget {
  final String guideId;

  const GuideDetailPage({super.key, required this.guideId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide Details'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future:
            FirebaseFirestore.instance.collection('guides').doc(guideId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          Guide guide = Guide.fromFirestore(snapshot.data!);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        radius: 48.0,
                        backgroundImage: NetworkImage(guide.profilePictureUrl),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guide.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Age: ${guide.age}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Address: ${guide.address}',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20.0),
                            const SizedBox(width: 2.0),
                            Text(
                              '${guide.rating}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '(${guide.reviews} Reviews)',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(8.0),
                      selectedColor: Colors.white,
                      fillColor: const Color.fromARGB(255, 22, 156, 140),
                      isSelected: const [false, false],
                      onPressed: (int index) {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactPage(guide: guide),
                            ),
                          );
                        } else if (index == 1) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ChatPage(guide: guide),
                          //   ),
                          // );
                        }
                      },
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 2.0),
                          child: Text(
                            'Contact me',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 2.0),
                          child: Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  guide.about,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Available Packages',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 300.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  ),
                  itemCount: guide.packages.length,
                  itemBuilder: (context, index, realIdx) {
                    var package = guide.packages[index];
                    return ShortVideoThumbnail(
                      imageRef: package['image'],
                      description: package['price'],
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Experiences',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  ),
                  itemCount: guide.experiences.length,
                  itemBuilder: (context, index, realIdx) {
                    var experience = guide.experiences[index];
                    return Container(
                      width: 160.0, // Adjust the width as needed
                      margin: const EdgeInsets.only(right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 4),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12.0)),
                            child: Image.network(
                              'https://example.com/image.jpg', // Replace with your image URL
                              height: 120.0,
                              width: 160.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  experience,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Memories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Fetch and display images from Firebase
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(guideId)
                      .collection('memories')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.green,
                      ));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No memories available'));
                    }

                    var memories = snapshot.data!.docs;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: memories.length,
                      itemBuilder: (context, index) {
                        var memory = memories[index].data();
                        var imageUrl = memory['imageUrl'];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
                // Add additional memories here similar to the above experiences
              ],
            ),
          );
        },
      ),
    );
  }
}

class VacationDetailPage extends StatelessWidget {
  final List<String> imgList = [
    'assets/biru/image_1.jpg',
    'assets/biru/image_2.jpg',
    'assets/biru/image_3.jpg',
  ];

  VacationDetailPage({super.key});

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
                        builder: (context) => const ReservationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 22, 156, 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text("Reserve",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
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
