import 'package:flutter/material.dart';

class HotelDetailsPage extends StatelessWidget {
  const HotelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '98 Acres Resort & Spa - Ella',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a1.jpg',
                                      width: 232,
                                      height: 316,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(width: 22),
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 24),
                                      Text(
                                        'View all Photos (312)',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 35),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a2.jpg',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a3.jpg',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a4.jpg',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a5.jpg',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a6.jpg',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/a7.jpg',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Heading
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Check Availability',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide.none,
                                          // Remove the border
                                          // remove border color
                                        ),
                                        backgroundColor: Colors
                                            .transparent, // Remove the border color
                          
                                        content: const SizedBox(
                                          width: 300.0,
                                          height: 400.0,
                                          child: AprilCalendarScreen(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 273,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                size: 40,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Check-in Date'),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text('20/04/2024'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide.none,
                                          // Remove the border
                                          // remove border color
                                        ),
                                        backgroundColor: Colors
                                            .transparent, // Remove the border color
                          
                                        content: const SizedBox(
                                          width: 300.0,
                                          height: 400.0,
                                          child: AprilCalendarScreen(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 272,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                size: 40,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Check-out Date'),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text('22/04/2024'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide.none,
                                          // Remove the border
                                          // remove border color
                                        ),
                                        backgroundColor: Colors
                                            .transparent, // Remove the border color
                          
                                        content: const SizedBox(
                                          width: 300.0,
                                          height: 350.0,
                                          child: GuestScreen(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 273,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFF2A966C), // Set background color to blue
                          
                                    border:
                                        Border.all(color: const Color(0xFF2A966C)),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_sharp,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Guests',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '1 Room, 2 Adults, 0 Children',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color:
                                      Color.fromARGB(120, 158, 158, 158),
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text('Deal 1'),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Breakfast included'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('No prepayment needed'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'LKR 28,754',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showFirstDialog(
                                        context); // Show the first popup dialog
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A966C),
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Color(0xFF2A966C)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('View Deal',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color:
                                      Color.fromARGB(120, 158, 158, 158),
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20), const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text('Deal 2'),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Breakfast included'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Earn rewards on eligible stays'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'LKR 32,432',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showFirstDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A966C),
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Color(0xFF2A966C)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('View Deal',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color:
                                      Color.fromARGB(120, 158, 158, 158),
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20), const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text('Deal 3'),
                              ),
                              const Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Breakfast included'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('No booking fees'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'LKR 33,549',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showFirstDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A966C),
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Color(0xFF2A966C)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('View Deal',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0), // Add spacing between sections
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // About section
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),

                          // Details section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First column (About)
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('4.5',
                                                  style: TextStyle(
                                                      fontSize: 48,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 17,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Excellent'),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star_half,
                                                      color: Colors.yellow),
                                                  SizedBox(width: 8),
                                                  Text('(128 reviews)'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Luxury, Eco Friendly Boutique Resort built in a 98 acre tea estate with panoramic views..... 25 villa type rooms, 3 Executive suits, Large swimming pool, Restaurant serving Western and Sri Lankan food, Specialty tea menu, Heli Pad, Wifi Access, Bikes for Rent, Hiking and Biking Facilities, Wonderful Treks and Right in front of Ella\'s Main Attraction - Little Adams Peak. We do not provide Driver / Guides Accommodation but we are happy to provide you with contact numbers and information of guest houses / hotels in a very close proximity to the resort.',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: 16.0), // Add spacing between columns
                              // Second column (Details)
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Property amenities',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.pool,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Swimming Pool'),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.free_breakfast_outlined,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Free Breakfast'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.hiking,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Hiking'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.spa,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Spa'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_parking,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Free parking'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.wifi,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                                'Free High Speed Internet (WiFi)'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        // Add more rows for other amenities
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Room features',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.bathtub,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Bathrobes'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(Icons.bed, size: 18),
                                            SizedBox(width: 8),
                                            Text('Desk'),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.room_service_outlined,
                                                size: 18),
                                            SizedBox(width: 8),
                                            Text('Room Service'),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.balcony_outlined,
                                                size: 18),
                                            SizedBox(width: 8),
                                            Text('Private Balcony'),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.coffee_maker_outlined,
                                                size: 18),
                                            SizedBox(width: 8),
                                            Text('Coffee/Tea Maker'),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        // Add more rows for other room features
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Location section
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/vimosh/l.png',
                                      width: double.infinity,
                                      height: 316,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 14.0,
                                right: 14.0,
                                child: GestureDetector(
                                  onTap: () {
                                    // Handle button tap
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Icon(
                                      Icons.fullscreen,
                                      color: Colors.black,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Review section
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Review',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            height: 250,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: reviews
                                  .map((review) => buildReviewSection(review))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  int rooms = 0;
  int adults = 0;
  int children = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Rooms'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (rooms > 0) rooms--;
                        });
                      },
                    ),
                    Text('$rooms'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          rooms++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Adults'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (adults > 0) adults--;
                        });
                      },
                    ),
                    Text('$adults'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          adults++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Children'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (children > 0) children--;
                        });
                      },
                    ),
                    Text('$children'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          children++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A966C),
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF2A966C)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.done, color: Colors.white),
                  SizedBox(width: 5),
                  Text('Save', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AprilCalendarScreen extends StatelessWidget {
  const AprilCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('April'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: 30,
              itemBuilder: (context, index) {
                Color backgroundColor = Colors.transparent;
                Color textColor = Colors.black;
                if (index == 19) {
                  backgroundColor = Colors.blue;
                } else if (index == 21) {
                  backgroundColor = Colors.green;
                } else if (index == 23 || index == 24 || index == 25) {
                  backgroundColor = Colors.red;
                }
                if (backgroundColor != Colors.transparent) {
                  textColor = Colors.white;
                }
                return Center(
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Color.fromARGB(120, 158, 158, 158),
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              LegendItem(
                color: Colors.blue,
                text: 'Your Check-In Date',
              ),
            ],
          ),
          const SizedBox(height: 10), // Add spacing between legend items (optional

          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              LegendItem(
                color: Colors.green,
                text: 'Your Check-Out Date',
              ),
            ],
          ),
          const SizedBox(height: 10), // Add spacing between legend items (optional
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              LegendItem(
                color: Colors.red,
                text: 'Not Avilable',
              ),
            ],
          ),
          const SizedBox(height: 10), // Add spacing between legend items (optional
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

void _showFirstDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          AlertDialog(
            title: const Text('Booking Form',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Remove the border radius
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'First Name',
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        // Set text color to white
                        decoration: const InputDecoration(
                          hintText: 'Enter your first name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Last Name',
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        // Set text color to white
                        decoration: const InputDecoration(
                          hintText: 'Enter your last name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email',
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        // Set text color to white
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Contact Number'),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your contact number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Kindly Upload Any Valid ID'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // FilePickerResult? result =
                        //     await FilePicker.platform.pickFiles();
                        // if (result != null) {
                        //   // User has selected a file
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFF2A966C)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.cloud_upload_outlined,
                              color: Color(0xFF2A966C)),
                          SizedBox(width: 10),
                          Text('Click Here to Upload ID'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSecondDialog(context); // Show the second popup
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C),
                    foregroundColor: Colors.white,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFF2A966C)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showSecondDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
                _showFirstDialog(context); // Close the dialog
              },
            ),
            const SizedBox(width: 60), // Add some space between the icon and text
            const Text('Booking Summary'),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Remove the border radius
        ),
        content: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 400,
              padding: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Name'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Vimosh Vasanthakumar'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Email'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('vimosh2002@gmail.com'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Phone Number'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('0767722120'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 400,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(33, 158, 158,
                                158), // Set the background color to grey
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              // Left side with hotel name and rating
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/vimosh/a1.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Right side with image
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('98 Acres Resort & Spa - Ella'),
                                      Row(
                                        children: [
                                          for (int i = 0; i < 4; i++)
                                            const Icon(Icons.star,
                                                color: Colors.green,
                                                size: 20.0),
                                          for (int i = 0; i < 1; i++)
                                            const Icon(
                                                Icons
                                                    .star_border_purple500_sharp,
                                                color: Colors.green,
                                                size: 20.0),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Check In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Check Out',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text('Check-out Date'),
                                      // SizedBox(
                                      //   height: 2,
                                      // ),
                                      Text('Apr 20'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.arrow_forward),
                      const SizedBox(
                          width: 20), // Add some space between the containers
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text('Check-out Date'),
                                      // SizedBox(
                                      //   height: 2,
                                      // ),
                                      Text('Apr 22'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Room Type',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Deluxe Room',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Guest',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '2',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Number of Rooms',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Total Price',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'LKR 28,754',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some space between the containers
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showThirdDialog(context); // Show the second popup
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A966C),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF2A966C)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
        actions: const <Widget>[],
      );
    },
  );
}

void _showThirdDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300, // Specify the image height
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/vimosh/done.png',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200, // Specify the width of the button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showFourthDialog(context); // Show the second popup
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C),
                    foregroundColor: Colors.white,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('View Booking Ticket'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200, // Specify the width of the button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 186, 186, 186),
                    foregroundColor: Colors.black,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Download Ticket'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showFourthDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
                _showFirstDialog(context); // Close the dialog
              },
            ),
            const SizedBox(width: 60), // Add some space between the icon and text
            const Text('Ticket'),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Remove the border radius
        ),
        content: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 400,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('98 Acres Resort & Spa - Ella',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // add image
                    children: [
                      Expanded(
                        child: Container(
                          height: 200, // Specify the image height
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/vimosh/qr.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Booking ID: 005Wf32FR',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Name'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Vimosh Vasanthakumar'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Email'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('vimosh2002@gmail.com'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Phone Number'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('0767722120'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Check In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Check Out',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text('Check-out Date'),
                                      // SizedBox(
                                      //   height: 2,
                                      // ),
                                      Text('Apr 20'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.arrow_forward),
                      const SizedBox(
                          width: 20), // Add some space between the containers
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text('Check-out Date'),
                                      // SizedBox(
                                      //   height: 2,
                                      // ),
                                      Text('Apr 22'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Add some space between the containers
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A966C),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF2A966C)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Download Ticket'),
              ),
            ),
          ],
        ),
        actions: const <Widget>[],
      );
    },
  );
}

List<Map<String, dynamic>> reviews = [
  {
    'name': 'Emily Wilson',
    'verified': true,
    'rating': 4.0,
    'review':
        'I had a great experience at this hotel. The room was clean and comfortable, and the staff was very helpful. The location was perfect for exploring the city. I would definitely stay here again.',
    'date': 'August 2024',
  },
  {
    'name': 'Michael Adams',
    'verified': false,
    'rating': 3.0,
    'review':
        'Overall, my stay was okay. The room was decent, but there were some issues with cleanliness. The staff was friendly but not very attentive. I probably would not stay here again.',
    'date': 'September 2024',
  },
  {
    'name': 'Jessica Miller',
    'verified': true,
    'rating': 5.0,
    'review':
        'This hotel is fantastic! The room was beautiful, the staff was amazing, and the amenities were top-notch. I had a truly wonderful stay and would highly recommend this hotel to anyone.',
    'date': 'October 2024',
  },
];

Widget buildReviewSection(Map<String, dynamic> review) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      width: 300,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/vimosh/g2.jpg'),
                radius: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                review['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (review['verified'])
                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                  size: 20.0,
                ),
            ],
          ),
          Row(
            children: [
              for (int i = 0; i < review['rating']; i++)
                const Icon(Icons.star, color: Colors.green, size: 20.0),
              for (int i = 0; i < 5 - review['rating']; i++)
                const Icon(Icons.star_border_purple500_sharp,
                    color: Colors.green, size: 20.0),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(review['review']),
          const SizedBox(height: 8.0),
          const Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
          Text('Date of stay: ${review['date']}'),
        ],
      ),
    ),
  );
}

