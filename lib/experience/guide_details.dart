import 'package:flutter/material.dart';

class GuideDetailsPage extends StatelessWidget {
  final String title;

  const GuideDetailsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side (40%)
          Expanded(
            flex: 3, // 40% width
            child: Container(
              color: Colors.white, // Example color for left side
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align content to the top
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align content to the start
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0), // Add some top padding
                    child: CircleAvatar(
                      radius: 50, // Radius of the circle avatar
                      backgroundImage: AssetImage(
                          'assets/aadi/20dc041d0a52add5a92e63d8ec71eacb.jpeg'), // Add image
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0), // Add some top padding
                    child: Text(
                      'Mr. Vimosh V',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins', // Specify Inter font family
                        fontWeight: FontWeight.w900, // Increase boldness
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Add spacing between the two texts
                  const Text(
                    'Age 25, No:29, Wellawaya Highway, Ella',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'popins', // Specify Inter font family
                      fontWeight: FontWeight.w300, // Thinner letters
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Align content to the center vertically
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Align content to the center horizontally
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Align content to the center horizontally
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Align content to the center vertically
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber, // Golden star color
                          ),
                          SizedBox(
                              width:
                                  4), // Add spacing between the star and the text
                          Text(
                            '4.8 (35 Reviews)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'popins', // Specify Inter font family
                              fontWeight: FontWeight.w300, // Thinner letters
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HiringPage()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .green; // Set the background color to green when hovered
                              }
                              return Colors.white; // Default background color
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .white; // Set the text color to white when hovered
                              }
                              return const Color.fromRGBO(
                                  42, 150, 108, 1); // Default text color
                            }),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                              return const BorderSide(
                                color: Color.fromRGBO(
                                    42, 150, 108, 1), // Border color
                                width: 2, // Border width
                              );
                            }),
                          ),
                          child: const Text('Hire'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .green; // Set the background color to green when hovered
                              }
                              return Colors.white; // Default background color
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .white; // Set the text color to white when hovered
                              }
                              return const Color.fromRGBO(
                                  42, 150, 108, 1); // Default text color
                            }),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                              return const BorderSide(
                                color: Color.fromRGBO(
                                    42, 150, 108, 1), // Border color
                                width: 2, // Border width
                              );
                            }),
                          ),
                          child: const Text('Call'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .green; // Set the background color to green when hovered
                              }
                              return Colors.white; // Default background color
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .white; // Set the text color to white when hovered
                              }
                              return const Color.fromRGBO(
                                  42, 150, 108, 1); // Default text color
                            }),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                              return const BorderSide(
                                color: Color.fromRGBO(
                                    42, 150, 108, 1), // Border color
                                width: 2, // Border width
                              );
                            }),
                          ),
                          child: const Text('e-mail'),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'About',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'popins', // Specify Inter font family
                        fontWeight: FontWeight.w900, // Thinner letters
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                        maxWidth:
                            500), // Limit the maximum width of the container
                    margin:
                        const EdgeInsets.all(8.0), // Add margin around the container
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0), // Add horizontal padding
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(219, 229, 224,
                          1), // Set the background color of the box
                      borderRadius: BorderRadius.circular(
                          8.0), // Add rounded corners to the box
                    ),
                    child: const Text(
                      'I have been guiding tourists for 4 years. With a focus on providing memorable experiences, I ensure that every tour is informative, engaging, and enjoyable.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'popins', // Specify Inter font family
                        fontWeight: FontWeight.w300, // Thinner letters
                      ),
                    ),
                  ),
                  const Text(
                    "Available Packages",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'popins', // Specify Inter font family
                      fontWeight: FontWeight.w900, // Thinner letters
                    ),
                  ),

                  // Buttons Row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HiringPage()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .green; // Set the background color to green when hovered
                              }
                              return Colors.white; // Default background color
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .white; // Set the text color to white when hovered
                              }
                              return const Color.fromRGBO(
                                  42, 150, 108, 1); // Default text color
                            }),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                              return const BorderSide(
                                color: Color.fromRGBO(
                                    42, 150, 108, 1), // Border color
                                width: 2, // Border width
                              );
                            }),
                          ),
                          child: const Text('LKR    3000 / per person'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HiringPage()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .green; // Set the background color to green when hovered
                              }
                              return Colors.white; // Default background color
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .white; // Set the text color to white when hovered
                              }
                              return const Color.fromRGBO(
                                  42, 150, 108, 1); // Default text color
                            }),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                              return const BorderSide(
                                color: Color.fromRGBO(
                                    42, 150, 108, 1), // Border color
                                width: 2, // Border width
                              );
                            }),
                          ),
                          child: const Text('LKR    2000 / per hour'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right side (60%)
          Expanded(
            flex: 7, // 60% width
            child: SingleChildScrollView(
              // Make the right side scrollable
              padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                bottom: 40, // Add some bottom padding
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Experiences",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'popins', // Specify Inter font family
                          fontWeight: FontWeight.w900, // Thinner letters
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(4.0, 16.0, 20.0, 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // First Picture with Description
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/f58b16235864c72499340999e4f54f48.png',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Hiking',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            // Second Picture with Description
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/db2f5d7d548f69a33beaf7af503c9abe.png',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Camping',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/sri-lanka-photos-0251.jpg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Scenic Train Ride',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/kayaking-and-boating.jpg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Kayaking',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Additional Experiences",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'popins', // Specify Inter font family
                          fontWeight: FontWeight.w900, // Thinner letters
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(4.0, 16.0, 20.0, 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // First Picture with Description
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/009c6f93041c8ca8665bdf8ea43b48c7.jpeg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Srilankan Style Buffet',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                                const Text(
                                  'LKR 3000/per person',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            // Second Picture with Description
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/d627e4d2d0fd4aa38c13b92e4e1e00c3.jpeg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Bullock-Cart Ride',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                                const Text(
                                  'LKR 1500/per person',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/sri-lanka-photos-8716.jpg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Elephant Ride',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                                const Text(
                                  'LKR 3000/per person',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/default-header-mobile.jpg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'The Tea Plucking Experience',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                                const Text(
                                  'LKR 5000/per person',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.fromLTRB(8.0, 16.0, 20.0, 20.0),
                      child: Text(
                        'Available Services',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'popins', // Specify Inter font family
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 5.0),
                      child: Center(
                        child: Text(
                          'Select the extra services you would like to rent for your tour. Each additional service can be rented for 3000 LKR. If you prefer, the guide can also provide assistance with these services during your tour.',
                          textAlign: TextAlign
                              .center, // Align the text to the center
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'popins', // Specify Inter font family
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        height: 320,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // First Picture with Description
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/9ZXV8w6NKbLhhp6nvqMRef-1200-80.jpg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  '360 camera',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            // Second Picture with Description
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/d1aaa004c036511f92907b8504fdc84f.jpeg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Drone',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'popins',
                                  ),
                                ),
                              ],
                            ),
                            // Add more pictures with descriptions here
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/abb688983c8ce242aaf4c7c73c132360.jpeg',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'DSLR',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'popins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/aadi/Gear-Sony-A7IV.jpg.webp',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Mirrorless Camera',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'popins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Reviews',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'popins',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.fromLTRB(8.0, 2.0, 15.0, 5.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 229, 224, 1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Circular picture
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/aadi/IMG_3860_11zon.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  // Name and Verification text
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mr. Donald Aadithiyan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        'Verified User',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Rating stars
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star_half,
                                                color: Colors.amber),
                                          ],
                                        ),
                                        // Rating text
                                        Text(
                                          'Jan 20, 2024',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8), // Add some space
                              // Review text
                              const Text(
                                'The service provided by Mr. Vimosh V was excellent. He was very knowledgeable and friendly throughout the tour. I highly recommend him as a tour guide.',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.fromLTRB(8.0, 2.0, 15.0, 5.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 229, 224, 1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Circular picture
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/aadi/Unknown.jpeg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  // Name and Verification text
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mrs. Shriya Saran',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        'Verified User',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Rating stars
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star,
                                                color: Colors.amber),
                                            Icon(Icons.star_half,
                                                color: Colors.amber),
                                          ],
                                        ),
                                        // Rating text
                                        Text(
                                          'Mar 20, 2024',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8), // Add some space
                              // Review text
                              const Text(
                                'Great Experience and very good quality service',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HiringPage extends StatefulWidget {
  const HiringPage({super.key});

  @override
  State<HiringPage> createState() => _HiringPageState();
}

class _HiringPageState extends State<HiringPage> {
  String? selectedMonth;
  int? selectedDateIndex;
  int? selectedOptionIndex;
  bool isContinueButtonEnabled = false;
  List<bool> isButtonClickedList =
      List.filled(10, false); // Adjust the size as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors
                    .green, // Set the background color of the dropdown button to green
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: Add border radius
              ),
              child: DropdownButton<String>(
                value: selectedMonth,
                items: <String>[
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue;
                  });
                },
                hint: const Text(
                  'Select a month',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 10.0, 15.0, 0.0),
              child: Text(
                'Select date:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                        if (selectedOptionIndex != null) {
                          isContinueButtonEnabled = true;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: MediaQuery.of(context).size.width / 7,
                      padding: const EdgeInsets.all(
                          5), // Reduced padding for smaller buttons
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(42, 150, 108, 1)
                            : Colors.white,
                        borderRadius:
                            BorderRadius.circular(20), // Stadium shape
                        border: Border.all(
                          color: isSelected
                              ? const Color.fromRGBO(42, 150, 108, 1)
                              : const Color.fromRGBO(42, 150, 108, 1),
                          width: 3, // Green border width
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color.fromRGBO(42, 150, 108, 1),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildOptionButton('8:00 - 10:00', 0),
                  buildOptionButton('10:00 - 12:00', 1),
                  buildOptionButton('12:00 - 14:00', 2),
                  buildOptionButton('14:00 - 16:00', 3),
                  buildOptionButton('8:30 - 10:30', 4),
                  buildOptionButton('10:30 - 12:30', 5),
                  buildOptionButton('12:30 - 14:30', 6),
                  buildOptionButton('14:30 - 16:30', 7),
                  buildOptionButton('16:30 - 18:30', 8),
                  buildOptionButton('16:00 - 17:00', 9),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isContinueButtonEnabled
                  ? () {
                      // Add functionality for continue button
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentPage(),
                        ),
                      );
                    }
                  : null,
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 24), // Adjust padding as needed
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors
                          .white; // Default background color when disabled
                    }
                    return Colors.blue; // Brighten to green when enabled
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return const Color.fromRGBO(
                          42, 150, 108, 1); // Default text color when disabled
                    }
                    return Colors.white; // Brighten to white when enabled
                  },
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Adjust the border radius
                    side: const BorderSide(width: 3), // Set initial border width
                  ),
                ),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return const BorderSide(
                          color: Color.fromRGBO(42, 150, 108, 1),
                          width: 3); // Border color when disabled
                    }
                    return const BorderSide(
                        color: Colors.white,
                        width: 3); // Border color when enabled
                  },
                ),
              ),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0.5, end: 1.0),
                builder: (BuildContext context, double value, Widget? child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: const Text(
                  'Continue',
                  style:
                      TextStyle(fontSize: 16), // Adjust the font size as needed
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildOptionButton(String text, int index) {
    int? parsedOptionIndex;
    try {
      parsedOptionIndex = int.parse(text.split(' ')[1]) - 1;
    } catch (e) {
      parsedOptionIndex = null; // Set to null if parsing fails
    }
    bool isSelected = selectedOptionIndex == parsedOptionIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedDateIndex != null) {
            isContinueButtonEnabled = true;
            // Reset all buttons to unclicked state
            isButtonClickedList = List.filled(30, false);
            // Set the clicked state for the currently tapped button
            isButtonClickedList[index] = true;
          }
        });
      },
      child: Center(
        child: Container(
          width: 200, // Adjust the width according to your needs
          margin: const EdgeInsets.symmetric(vertical: 14),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected && selectedDateIndex != null
                ? const Color.fromRGBO(42, 150, 108, 1)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color.fromRGBO(42, 150, 108, 1)
                  : const Color.fromRGBO(42, 150, 108, 1),
              width: 3, // Green border width
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected
                      ? Colors.black
                      : const Color.fromRGBO(42, 150, 108, 1),
                  fontSize: 14,
                ),
              ),
              if (isSelected && selectedDateIndex != null)
                const Icon(Icons.check, color: Color.fromRGBO(42, 150, 108, 1)),
              if (!isSelected && selectedDateIndex != null)
                Icon(Icons.check, color: Colors.grey[300]),
              if (isButtonClickedList[index]) // Check if this button is clicked
                const Icon(Icons.check,
                    color: Colors.black), // Change only the icon color to black
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isCardOptionSelected = false;
  bool isVisaSelected = false;
  bool isMasterCardSelected = false;
  bool isAmericanExpressSelected = false;

  bool isConfirmEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 100),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCardOptionSelected = true;
                        isVisaSelected = false;
                        isMasterCardSelected = false;
                        isAmericanExpressSelected = false;
                        isConfirmEnabled = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: isCardOptionSelected
                          ? const Color.fromRGBO(42, 150, 108, 1)
                          : Colors.white,
                      side: const BorderSide(
                          color: Color.fromRGBO(42, 150, 108, 1), width: 2),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/aadi/Unknown.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Card',
                          style: TextStyle(
                              color: isCardOptionSelected
                                  ? Colors.white
                                  : const Color.fromRGBO(42, 150, 108, 1),
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      side: const BorderSide(
                          color: Color.fromRGBO(42, 150, 108, 1), width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/aadi/apple-pay-og-twitter.jpg',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 8),
                        const Text('Apple pay',
                            style: TextStyle(
                                color: Color.fromRGBO(42, 150, 108, 1),
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      side: const BorderSide(
                          color: Color.fromRGBO(42, 150, 108, 1), width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/aadi/paypal-3384015_1280.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 8),
                        const Text('Paypal',
                            style: TextStyle(
                                color: Color.fromRGBO(42, 150, 108, 1),
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Select your card',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 550,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVisaSelected = true;
                          isMasterCardSelected = false;
                          isAmericanExpressSelected = false;
                          isConfirmEnabled =
                              isCardOptionSelected && isVisaSelected;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isVisaSelected
                            ? const Color.fromRGBO(42, 150, 108, 1)
                            : Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/aadi/Card.png',
                            width: 500,
                            height: 500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Visa',
                            style: TextStyle(
                                color: isVisaSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVisaSelected = false;
                          isMasterCardSelected = true;
                          isAmericanExpressSelected = false;
                          isConfirmEnabled =
                              isCardOptionSelected && isMasterCardSelected;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isMasterCardSelected
                            ? const Color.fromRGBO(42, 150, 108, 1)
                            : Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/aadi/world-mastercard-card_1280x720.jpg',
                            width: 500,
                            height: 500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'MasterCard',
                            style: TextStyle(
                                color: isMasterCardSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVisaSelected = false;
                          isMasterCardSelected = false;
                          isAmericanExpressSelected = true;
                          isConfirmEnabled =
                              isCardOptionSelected && isAmericanExpressSelected;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isAmericanExpressSelected
                            ? const Color.fromRGBO(42, 150, 108, 1)
                            : Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/aadi/1684306263-web-platinum-card.webp',
                            width: 500,
                            height: 500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'American Express',
                            style: TextStyle(
                                color: isAmericanExpressSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                color: const Color.fromRGBO(42, 150, 108, 1),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      'Hideaway Camping Trials',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'By Birunthaban',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                color: const Color.fromRGBO(219, 229, 224, 1),
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.calendar_today), // Calendar icon
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '02.03.2024',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.people), // People icon
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '7 Adults, 4 Children',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.access_time), // Clock icon
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '10:00 AM - 2:00 PM',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isConfirmEnabled ? () {} : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  side: const BorderSide(
                      color: Color.fromRGBO(42, 150, 108, 1),
                      width: 2), // Add green border
                ),
                icon: const Icon(Icons.add, color: Color.fromRGBO(42, 150, 108, 1)),
                label: const Text('Add Voucher',
                    style: TextStyle(color: Color.fromRGBO(42, 150, 108, 1))),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.all(20),
                color: const Color.fromRGBO(219, 229, 224, 1),
                child: const Center(
                  child: Column(children: [
                    Text(
                      'Sub Total                           LKR 125,000',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'VAT(10%)                           LKR 12,500',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'Discount                            LKR -10,000',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'Total                                LKR 127,500',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    )
                  ]),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isConfirmEnabled
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConfirmationPage()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: isConfirmEnabled
                      ? const Color.fromRGBO(42, 150, 108, 1)
                      : const Color.fromRGBO(42, 150, 108, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  side: const BorderSide(
                      color: Color.fromRGBO(42, 150, 108, 1),
                      width: 3), // Add green border
                ),
                child: const Text(
                  'Confirm and Continue',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/aadi/Screenshot 2024-04-11 at 17.48.28.png', // Replace 'your_huge_image.jpg' with the path to your image asset
              width: MediaQuery.of(context).size.width *
                  0.4, // Adjust width as needed
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle 'Get PDF receipt' button press
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color.fromRGBO(
                        42, 150, 108, 1); // Green background color when hovered
                  }
                  return Colors.white; // White background color by default
                }),
                foregroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.white; // Green background color when hovered
                  }
                  return const Color.fromRGBO(
                      42, 150, 108, 1); // White background color by default
                }), // Green text color
                side: MaterialStateProperty.resolveWith<BorderSide>((states) {
                  return const BorderSide(
                      color: Colors.green, width: 2); // Green border
                }),
              ),
              child: const Text('Get PDF receipt'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle 'Go to Booking' button press
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color.fromRGBO(
                        42, 150, 108, 1); // Green background color when hovered
                  }
                  return Colors.white; // White background color by default
                }),
                foregroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.white; // Green background color when hovered
                  }
                  return const Color.fromRGBO(
                      42, 150, 108, 1); // White background color by default
                }), // Green text color
                side: MaterialStateProperty.resolveWith<BorderSide>((states) {
                  return const BorderSide(
                      color: Colors.green, width: 2); // Green border
                }),
              ),
              child: const Text('Go to Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
