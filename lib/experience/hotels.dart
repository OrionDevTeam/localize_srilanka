import 'package:flutter/material.dart';
import 'package:localize_sl/experience/hotel_details.dart';

// Define a global variable list to store the hotel data
List<Map<String, dynamic>> hotelData = [
  {
    'image': 'assets/vimosh/h1.jpg',
    'name': 'Homestay Ella Resort',
    'price': 'LKR 24,512',
    'rating': '4.5',
    'reviews': '(110 Reviews)',
    'category': '5 star hotel',
    'features': [
      'Lunch',
      'Wifi',
      'Gym',
    ],
    'features2': [
      'Spa',
      'AC',
      'Room Service',
    ],
  },
  {
    'image': 'assets/vimosh/h2.jpg',
    'name': 'New View Resort & Spa',
    'price': 'LKR 19,269',
    'rating': '4.4',
    'reviews': '(210 Reviews)',
    'category': '5 star hotel',
    'features': [
      'Swimming Pool',
      'Child Care',
      'Breakfast',
    ],
    'features2': [
      'Spa',
      'Wifi',
      'Room Service',
    ],
  },
  {
    'image': 'assets/vimosh/h3.jpg',
    'name': 'Hideaway Camping Trails',
    'price': 'LKR 22,318',
    'rating': '4.4',
    'reviews': '(210 Reviews)',
    'category': '4 star hotel',
    'features': [
      'Bar',
      'Wifi',
      'Gym',
    ],
    'features2': [
      'Spa',
      'AC',
      'Parking',
    ],
  },
  {
    'image': 'assets/vimosh/h4.jpg',
    'name': 'Nine Skies Resort',
    'price': 'LKR 23,102',
    'rating': '4.3',
    'reviews': '(141 Reviews)',
    'category': '4 star hotel',
    'features': [
      'Swimming Pool',
      'Bar',
      'AC',
    ],
    'features2': [
      'Parking',
      'AC',
      'Room Service',
    ],
  },
  {
    'image': 'assets/vimosh/h5.jpg',
    'name': 'Anasa Wellness Resort',
    'price': 'LKR 23,409',
    'rating': '4.4',
    'reviews': '(110 Reviews)',
    'category': '4 star hotel',
    'features': [
      'Gym',
      'Wifi',
      'Bar',
    ],
    'features2': [
      'Spa',
      'AC',
      'Swimming Pool',
    ],
  },
];

class HotelsInfoSection extends StatefulWidget {
  const HotelsInfoSection({super.key});

  @override
  State<HotelsInfoSection> createState() => _HotelsInfoSectionState();
}

class _HotelsInfoSectionState extends State<HotelsInfoSection> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        // Add a heading
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 50, // Specify the desired height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  10), // Specify the border radius
              border: Border.all(
                  color: Colors.grey), // Specify the border color
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search hotels...',
                      border: InputBorder.none, // Hide the default border
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search)),
                const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // Rating filter
            const SizedBox(
              width: 8,
            ),
            Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF2A966C)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.filter_alt,
                        color: Color(0xFF2A966C), size: 16),
                    SizedBox(width: 5),
                    Text('All Filters',
                        style: TextStyle(color: Color(0xFF2A966C))),
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 5),
                    Text('4 + Rating')
                  ],
                )),
            // Gym filter
            Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.pool),
                    SizedBox(width: 5),
                    Text('Swimming Pool')
                  ],
                )),
            // Pool filter
            Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.fitness_center),
                    SizedBox(width: 5),
                    Text('Gym')
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.local_offer_outlined),
                    SizedBox(width: 5),
                    Text('Offers')
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(width: 5),
                    Text('Price')
                  ],
                )),
            // Add more filters as needed
          ],
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Suggested Hotels',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
  
        // Horizontal scrollable list of hotels
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Use a loop to create a container for each hotel
              for (var hotel in hotelData)
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HotelDetailsPage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 220,
                    height: 263,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(86, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        // Top half for the image
                        SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              hotel['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Bottom half for the name and rating
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hotel['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Popins',
                                      color: Colors.blue[400])),
                              const SizedBox(height: 5),
                              Text(hotel['price'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.star_half_outlined,
                                      color: Colors.yellow),
                                  Text(hotel['rating'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                  const SizedBox(width: 5),
                                  Text(hotel['reviews'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey)),
                                  const SizedBox(width: 5),
                                  Text(hotel['category'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Secret Waterfall · 12 results found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Use a loop to create a container for each hotel
              for (var hotel in hotelData)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromARGB(86, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      // right half for the image
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(hotel['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // left half for the name and rating
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hotel['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Popins',
                                      color: Colors.blue[400],
                                    ),
                                  ),
                                  Text(
                                    hotel['price'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.star_half_outlined,
                                      color: Colors.yellow),
                                  Text(
                                    hotel['rating'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    hotel['reviews'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    hotel['category'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const SizedBox(height: 5),
                              Wrap(
                                children: hotel['features']
                                    .map<Widget>((feature) {
                                  IconData iconData;
                                  switch (feature) {
                                    case 'Spa':
                                      iconData = Icons.spa;
                                      break;
                                    case 'AC':
                                      iconData = Icons.ac_unit;
                                      break;
                                    case 'Room Service':
                                      iconData = Icons.room_service;
                                      break;
                                    case 'Parking':
                                      iconData = Icons.local_parking;
                                      break;
                                    case 'Bar':
                                      iconData = Icons.local_bar;
                                      break;
                                    case 'Wifi':
                                      iconData = Icons.wifi;
                                      break;
                                    case 'Gym':
                                      iconData = Icons.fitness_center;
                                      break;
                                    case 'Swimming Pool':
                                      iconData = Icons.pool;
                                      break;
                                    case 'Child Care':
                                      iconData = Icons.child_friendly;
                                      break;
                                    case 'Breakfast':
                                      iconData = Icons.free_breakfast;
                                      break;
                                    case 'Lunch':
                                      iconData = Icons.restaurant;
                                      break;
                                    default:
                                      iconData =
                                          Icons.info; // Default icon
                                      break;
                                  }
  
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, bottom: 5),
                                    child: Chip(
                                      avatar: Icon(
                                        iconData,
                                        color: const Color(0xFF2A966C),
                                      ),
                                      label: Text(
                                        feature,
                                        style: const TextStyle(
                                          color: Color(0xFF2A966C),
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 1,
                                      labelPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      labelStyle:
                                          const TextStyle(fontSize: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                              158, 158, 158, 158),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                children: hotel['features2']
                                    .map<Widget>((feature) {
                                  IconData iconData;
                                  switch (feature) {
                                    case 'Spa':
                                      iconData = Icons.spa;
                                      break;
                                    case 'AC':
                                      iconData = Icons.ac_unit;
                                      break;
                                    case 'Room Service':
                                      iconData = Icons.room_service;
                                      break;
                                    case 'Parking':
                                      iconData = Icons.local_parking;
                                      break;
                                    case 'Bar':
                                      iconData = Icons.local_bar;
                                      break;
                                    case 'Wifi':
                                      iconData = Icons.wifi;
                                      break;
                                    case 'Gym':
                                      iconData = Icons.fitness_center;
                                      break;
                                    case 'Swimming Pool':
                                      iconData = Icons.pool;
                                      break;
                                    case 'Child Care':
                                      iconData = Icons.child_friendly;
                                      break;
                                    case 'Breakfast':
                                      iconData = Icons.free_breakfast;
                                      break;
                                    case 'Lunch':
                                      iconData = Icons.restaurant;
                                      break;
                                    default:
                                      iconData =
                                          Icons.info; // Default icon
                                      break;
                                  }
  
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, bottom: 5),
                                    child: Chip(
                                      avatar: Icon(
                                        iconData,
                                        color: const Color(0xFF2A966C),
                                      ),
                                      label: Text(
                                        feature,
                                        style: const TextStyle(
                                          color: Color(0xFF2A966C),
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 1,
                                      labelPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      labelStyle:
                                          const TextStyle(fontSize: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                              158, 158, 158, 158),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const HotelDetailsPage();
                                          },
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text(
                                      'View Details',
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 30),
  
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                // Handle page navigation to previous page
              },
            ),
            const Text('Showing results 1 – 8 of 20'),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // Handle page navigation to next page
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
