import 'package:flutter/material.dart';

List<Map<String, dynamic>> categoryData = [
  {
    'image': 'assets/vimosh/x1.png',
    'name': 'Italian',
  },
  {
    'image': 'assets/vimosh/x2.jpg',
    'name': 'American',
  },
  {
    'image': 'assets/vimosh/x3.jpg',
    'name': 'Seafood',
  },
  {
    'image': 'assets/vimosh/x4.jpg',
    'name': 'Chinese',
  },
  {
    'image': 'assets/vimosh/x5.jpg',
    'name': 'Japanese',
  },
  {
    'image': 'assets/vimosh/x6.jpg',
    'name': 'Thaiwanese',
  },
  {
    'image': 'assets/vimosh/x7.png',
    'name': 'South Indian',
  },
  {
    'image': 'assets/vimosh/x8.jpg',
    'name': 'Ice Cream',
  },
];
List<Map<String, dynamic>> hotelData = [
  {
    'image': 'assets/vimosh/c1.png',
    'name': 'Coffee',
    'price': 'LKR 2,400',
    'rating': '4.5',
    'reviews': '(110 Reviews)',
    'description':
        'A classic brewed coffee made from premium Arabica beans, offering a rich and smooth taste.',
    'ingredients': [
      'Arabica coffee beans',
      'Water',
      'Sugar',
      'Milk',
      'Ice',
      'Whipped cream'
    ],
  },
  {
    'image': 'assets/vimosh/c2.jpg',
    'name': 'Pizza',
    'price': 'LKR 2,100',
    'rating': '4.4',
    'reviews': '(210 Reviews)',
    'description':
        'A delicious pizza with a crispy crust, topped with fresh tomato sauce, melted cheese, and your choice of toppings.',
    'ingredients': [
      'Pizza dough',
      'Tomato sauce',
      'Mozzarella cheese',
      'Toppings (e.g., pepperoni, mushrooms, bell peppers)'
    ],
  },
  {
    'image': 'assets/vimosh/c3.jpeg',
    'name': 'Burger',
    'price': 'LKR 2,400',
    'rating': '4.4',
    'reviews': '(210 Reviews)',
    'description':
        'A juicy burger made with a grilled beef patty, fresh lettuce, tomatoes, onions, and a special sauce, all served on a toasted bun.',
    'ingredients': [
      'Beef patty',
      'Lettuce',
      'Tomato',
      'Onion',
      'Burger bun',
    ],
  },
  {
    'image': 'assets/vimosh/c4.jpg',
    'name': 'Fresh Juice',
    'price': 'LKR 2,300',
    'rating': '4.3',
    'reviews': '(141 Reviews)',
    'description':
        'A refreshing blend of fresh fruits, juiced to perfection, offering a burst of natural flavors.',
    'ingredients': [
      'Assorted fresh fruits (e.g., oranges, apples, pineapples, berries)'
    ],
  },
  {
    'image': 'assets/vimosh/c5.jpg',
    'name': 'Mojito',
    'price': 'LKR 1,000',
    'rating': '4.4',
    'reviews': '(110 Reviews)',
    'description':
        'A classic cocktail made with rum, fresh mint, lime juice, sugar, and soda water, creating a refreshing and minty drink.',
    'ingredients': ['Rum', 'Mint leaves', 'Lime juice', 'Sugar', 'Soda water'],
  },
  {
    'image': 'assets/vimosh/c6.jpeg',
    'name': 'Biriyani',
    'price': 'LKR 3,500',
    'rating': '4.4',
    'reviews': '(110 Reviews)',
    'description':
        'A flavorful rice dish cooked with fragrant spices, tender meat (chicken or mutton), and aromatic herbs, creating a savory and aromatic meal.',
    'ingredients': [
      'Basmati rice',
      'Meat (chicken or mutton)',
      'Spices',
      'Herbs'
    ],
  },
  {
    'image': 'assets/vimosh/c7.jpg',
    'name': 'Starter',
    'price': 'LKR 1,650',
    'rating': '4.4',
    'reviews': '(110 Reviews)',
    'description':
        'A delectable starter made with crispy fried or grilled appetizers, perfect for sharing or as an appetizer before the main course.',
    'ingredients': [
      'Varied based on the starter (e.g., chicken wings, spring rolls, samosas)'
    ],
  },
  {
    'image': 'assets/vimosh/c8.jpg',
    'name': 'Ice Cream',
    'price': 'LKR 1,200',
    'rating': '4.4',
    'reviews': '(110 Reviews)',
    'description':
        'A creamy and indulgent dessert made from fresh dairy cream, sugar, and natural flavors, offering a delightful treat for any occasion.',
    'ingredients': [
      'Dairy cream',
      'Sugar',
      'Natural flavors',
      'Toppings',
      'Cone'
    ],
  },
];

class FoodsInfoSection extends StatefulWidget {
  const FoodsInfoSection({super.key});

  @override
  State<FoodsInfoSection> createState() => _FoodsInfoSectionState();
}

class _FoodsInfoSectionState extends State<FoodsInfoSection> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

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
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search your favorite food...',
                      border:
                          InputBorder.none, // Hide the default border
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // Add your search functionality here
                    },
                    icon: const Icon(Icons.search)),
                const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Add your filter functionality here
                  },
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
            'Categories',
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
              for (int i = 0; i < 2; i++)

                // Use a loop to create a container for each hotel
                for (var cat in categoryData)
                  Container(
                    width: 120,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(86, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        // Top half for the image
                        SizedBox(
                          width: double.infinity,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              cat['image'],
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
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              Text(
                                cat['name'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Popins',
                                    fontWeight: FontWeight.bold),
                              ),
                              // SizedBox(height: 5),
                              // Text(hotel['price'],
                              //     style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.bold)),
                              // SizedBox(height: 5),
                              // Row(
                              //   children: [
                              //     Icon(Icons.star_half_outlined,
                              //         color: Colors.yellow),
                              //     Text(hotel['rating'],
                              //         style: TextStyle(
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.grey)),
                              //     SizedBox(width: 5),
                              //     Text(hotel['reviews'],
                              //         style: TextStyle(
                              //             fontSize: 12,
                              //             color: Colors.grey)),
                              //     SizedBox(width: 5),
                              //     Text(hotel['category'],
                              //         style: TextStyle(
                              //             fontSize: 12,
                              //             color: Colors.grey)),
                              //   ],
                              // ),
                              // SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Popular',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Use a loop to create a container for each hotel
              for (var hotel in hotelData)
                Container(
                  width: 200,
                  height: 240,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              hotel['name'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Popins',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(hotel['price'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            // Row(
                            //   children: [
                            //     Icon(Icons.star_half_outlined,
                            //         color: Colors.yellow),
                            //     Text(hotel['rating'],
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.bold,
                            //             color: Colors.grey)),
                            //     SizedBox(width: 5),
                            //     Text(hotel['reviews'],
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             color: Colors.grey)),
                            //     SizedBox(width: 5),
                            //     Text(hotel['category'],
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             color: Colors.grey)),
                            //   ],
                            //),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Recomended',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Use a loop to create a container for each hotel
              for (var hotel in hotelData)
                Container(
                  height: 300,
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
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Description: ${hotel['description']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Ingredients:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: hotel['ingredients']
                                    .map<Widget>((ingredient) {
                                  return Text(
                                    '- $ingredient',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add your view details functionality here
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
