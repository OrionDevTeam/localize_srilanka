import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HotelPage extends StatelessWidget {
  final String hotelId;
  final String place;

  const HotelPage({super.key, required this.hotelId, required this.place});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('hotels')
                .doc(place)
                .collection('Hotels_Collection')
                .doc(hotelId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('No data available'));
              }
              var data = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Image.network(
                          data['imageUrl'] ??
                              'https://firebasestorage.googleapis.com/v0/b/localize-sri-lanka.appspot.com/o/Map%20images%2FSouth%2Fmirrisa%20beach.jpg?alt=media&token=096fea5a-ee3b-408a-912b-a8114fed42d3',
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                          icon:
                              Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2A966C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'] ?? 'Secret View Homestay Ella',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              data['location'] ?? 'Wellawaya-Ella Highway',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          data['description'] ?? 'No description available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        FacilitiesSection(),
                        SizedBox(height: 16),
                        Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              '${data['rating'] ?? 'No rating available'}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              '[${data['noRating'] ?? 0} reviews]',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text('See all'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ReviewSection(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FacilitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/vimosh/h3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.black.withOpacity(0.4),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Rooms",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 98,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/vimosh/gym.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.black.withOpacity(0.4),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Gym",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Stack(
                children: [
                  Container(
                    height: 98,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/vimosh/pool.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.black.withOpacity(0.4),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pool",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 98,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/vimosh/c4.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.black.withOpacity(0.4),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Food",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Stack(
                children: [
                  Container(
                    height: 98,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/vimosh/bar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.black.withOpacity(0.4),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FacilityTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  FacilityTile({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(title),
      ],
    );
  }
}

class ReviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('hotels')
          .doc('Mirrissa')
          .collection('Hotel1')
          .doc('reviews')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No reviews available');
        }
        var reviewsData = snapshot.data!.data() as Map<String, dynamic>;
        var reviews = reviewsData.entries.map((entry) {
          var data = entry.value as Map<String, dynamic>;
          return ReviewTile(
            name: entry.key,
            date: data['Date'] ?? 'Unknown date',
            rating: data['rating'] ?? 0,
            review: data['review'] ?? 'No review available',
            imageUrl: data['imageUrl'] ?? 'https://via.placeholder.com/50',
          );
        }).toList();

        return Column(children: reviews);
      },
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String name;
  final String date;
  final String rating;
  final String review;
  final String imageUrl;

  ReviewTile({
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF2A966C),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(review),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
