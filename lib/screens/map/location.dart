import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Adventures/adventure.dart';
import '../hotels/hotel.dart';

class Location extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String location;
  final String rating;
  final String place;
  final List<String> tags;
  final String n;

  Location({
    required this.imageUrl,
    required this.place,
    required this.description,
    required this.title,
    required this.location,
    required this.rating,
    required this.tags,
    required this.n,
  });

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Map<String, dynamic>>> _hotelDetails;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _hotelDetails = fetchHotelDetails();
  }

  Future<List<Map<String, dynamic>>> fetchHotelDetails() async {
    List<Map<String, dynamic>> hotelList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> hotelSnapshots =
          await FirebaseFirestore.instance
              .collection('hotels')
              .doc(widget.place)
              .collection(
                  'Hotels_Collection') // Replace with your subcollection name
              .get();
      print('hotelSnapshots: ${hotelSnapshots.docs}');
      print('hotelSnapshots: ${hotelSnapshots.docs.length}');
      hotelSnapshots.docs.forEach((doc) {
        hotelList.add(doc.data()); // Add the hotel details to the list
      });
      print('hotelList: $hotelList');

      return hotelList;
    } catch (e) {
      print('Error fetching hotels: $e');
      return []; // Return empty list on error
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                child: Image.network(
                  widget.imageUrl,
                  height: 300,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        widget.location,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        widget.rating,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Guides',
                    icon: Icon(Icons.person_outline_rounded),
                  ),
                  Tab(
                    text: 'Hotels',
                    icon: Icon(Icons.hotel_outlined),
                  ),
                  Tab(
                    text: 'Adventure',
                    icon: Icon(Icons.surfing_outlined),
                  ),
                  Tab(
                    text: 'Groceries',
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
                dividerColor: Colors.transparent,
                indicatorColor: Color(0xFF2A966C),
                labelColor: Color(0xFF2A966C),
                unselectedLabelColor: Colors.grey[600],
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              SizedBox(
                height: 300, // Set a fixed height for the TabBarView
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Center(child: Text('Explore with Guides')),
                    HotelList(hotelDetails: _hotelDetails),
                    Adventure(
                      title: widget.title,
                    ),
                    Center(child: Text('Explore Groceries')),
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

class HotelList extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> hotelDetails;

  HotelList({required this.hotelDetails});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: hotelDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Hotels Found'));
        } else {
          List<Map<String, dynamic>> hotels = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: hotels.length,
                  separatorBuilder: (context, index) => SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    var hotel = hotels[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelPage(
                              hotelId: hotel['id'],
                              place: hotel['place'],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.7,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Image.network(
                                          hotel['imageUrl'],
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4),
                                          Text(
                                            hotel['name'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined,
                                                  color: Colors.grey),
                                              SizedBox(width: 4),
                                              Text(
                                                '${hotel['location']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text('${hotel['payment']}/ Night'),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.orange),
                                              SizedBox(width: 4),
                                              Text('${hotel['rating']}'),
                                              SizedBox(width: 4),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class Adventure extends StatelessWidget {
  final String title;

  Adventure({required this.title});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: () => _navigateTo(
                    context,
                    AdventurePage(
                      place: title,
                      adventure: "Snorkelling",
                    )),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: Image.asset(
                        'assets/vimosh/snorkel.jpg',
                        height: 160,
                        width: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.3),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Snorkelling",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: () => _navigateTo(
                    context,
                    AdventurePage(
                      place: title,
                      adventure: "Surfing",
                    )),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: Image.asset(
                        'assets/vimosh/surf.jpg',
                        height: 160,
                        width: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.3),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Surfing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
