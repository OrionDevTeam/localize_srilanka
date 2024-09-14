
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/floating_chat.dart';
import 'package:localize_sl/guides/guide_location.dart';

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

  const Location({super.key, 
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
      for (var doc in hotelSnapshots.docs) {
        hotelList.add(doc.data()); // Add the hotel details to the list
      }
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

// Initial position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
          // style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    child: Image.network(
                      widget.imageUrl,
                      height: 300,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            widget.rating,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
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
                        text: 'Food',
                        icon: Icon(Icons.fastfood_outlined),
                      ),
                    ],
                    dividerColor: Colors.transparent,
                    indicatorColor: const Color(0xFF2A966C),
                    labelColor: const Color(0xFF2A966C),
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  SizedBox(
                    height: 300, // Set a fixed height for the TabBarView
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        GuidePlace(
                          place: widget.place,
                        ),
                        HotelList(hotelDetails: _hotelDetails),
                        // Adventure(
                        //   title: widget.title,
                        // ),
                        Adventures(
                          place: widget.title,
                        ),
                        const Center(child: Text('Explore Groceries')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const FloatingChatButton(),
        ],
      ),
    );
  }
}

class HotelList extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> hotelDetails;

  const HotelList({super.key, required this.hotelDetails});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: hotelDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Hotels Found'));
        } else {
          List<Map<String, dynamic>> hotels = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: hotels.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 0),
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
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Image.network(
                                          hotel['imageUrl'],
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(
                                            hotel['name'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on_outlined,
                                                  color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${hotel['location']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text('${hotel['payment']}/ Night'),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.orange),
                                              const SizedBox(width: 4),
                                              Text('${hotel['rating']}'),
                                              const SizedBox(width: 4),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
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

class Adventures extends StatelessWidget {
  final String place;

  const Adventures({super.key, required this.place});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('place: $place');

    return Scaffold(
      body: Center(
        child: FutureBuilder<List<String>>(
          future: fetchAdventureDetails(place),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.green));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No adventures available'));
            } else {
              final adventures = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: adventures.map((adventure) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: GestureDetector(
                        onTap: () => _navigateTo(
                          context,
                          AdventurePage(
                            place: place,
                            adventure: adventure,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(18)),
                              child: Image.asset(
                                'assets/vimosh/${adventure.toLowerCase().replaceAll(' ', '_')}.jpg', // Assuming images are named like 'snorkelling.jpg' and 'surfing.jpg'
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
                                  borderRadius: const BorderRadius.only(
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
                                  adventure,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<String>> fetchAdventureDetails(String place) async {
    List<String> adventureTypes = [];

    try {
      // Get a reference to the place document
      DocumentReference placeRef =
          FirebaseFirestore.instance.collection('adventures').doc(place);

      // Fetch collections (adventure types) under the place document
      CollectionReference placeCollectionRef =
          placeRef.collection('Snorkelling');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Snorkelling');
      }

      placeCollectionRef = placeRef.collection('Surfing');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Surfing');
      }

      placeCollectionRef = placeRef.collection('Elephant Ride');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Elephant Ride');
      }

      placeCollectionRef = placeRef.collection('Whale Watching');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Whale Watching');
      }

      // zipline
      placeCollectionRef = placeRef.collection('Zipline');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Zipline');
      }

      // hiking
      placeCollectionRef = placeRef.collection('Hiking');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Hiking');
      }

      // camping
      placeCollectionRef = placeRef.collection('Camping');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Camping');
      }

      // wildlife
      placeCollectionRef = placeRef.collection('Wildlife');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Wildlife');
      }

      // birdwatching
      placeCollectionRef = placeRef.collection('Birdwatching');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Birdwatching');
      }

      // fishing
      placeCollectionRef = placeRef.collection('Fishing');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Fishing');
      }

      // cycling
      placeCollectionRef = placeRef.collection('Cycling');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Cycling');
      }

      // kayaking
      placeCollectionRef = placeRef.collection('Kayaking');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Kayaking');
      }

      // boat rides
      placeCollectionRef = placeRef.collection('Boat Rides');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Boat Rides');
      }

      // water sports
      placeCollectionRef = placeRef.collection('Parasailing');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Water Sports');
      }

      // jet ski
      placeCollectionRef = placeRef.collection('Jet Ski');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Jet Ski');
      }

      // rock climbing
      placeCollectionRef = placeRef.collection('Rock Climbing');
      if ((await placeCollectionRef.get()).docs.isNotEmpty) {
        adventureTypes.add('Rock Climbing');
      }

      print('adventureTypes: $adventureTypes');
      return adventureTypes;
    } catch (e) {
      print('Error fetching adventure types: $e');
      return []; // Return empty list on error
    }
  }
}
