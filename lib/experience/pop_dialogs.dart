import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popup Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Some Random Text'),
            ElevatedButton(
              onPressed: () => _showFirstRecieptDialog(context),
              child: const Text('Click Me'),
            ),
            ElevatedButton(
              onPressed: () => _showPaymentOptionDialog(context),
              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showFirstRecieptDialog(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/vimosh/banner1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Trip with Vimosh',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'March 21 | 9.30PM',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 100, // Specify the width
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius
                            ),
                            padding: const EdgeInsets.all(4), // Add padding
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                _showViewRecieptDialog(context);
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.receipt,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10, // Adjust the space as needed
                                  ),
                                  Text(
                                    'Receipt',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF2A966C), // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/vimosh/g6.JPG',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
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
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Secret Waterfall - Ella',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trip started time',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('03 : 00 pm',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trip ended time',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('06 : 00 pm',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('No tip added',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100, // Specify the width
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            padding: const EdgeInsets.all(4), // Add padding
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                _showTipDialog(
                                    context); // Show the second popup
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10, // Adjust the space as needed
                                  ),
                                  Text(
                                    'Add Tip',
                                    style: TextStyle(fontSize: 15),
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
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      flex: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rated 5',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(width: 5),
                          Icon(
                            Icons.star,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.reviews_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('No Reviews yet',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100, // Specify the width
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            padding: const EdgeInsets.all(4), // Add padding
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                _showReviewDialog(
                                    context); // Show the fourth popup
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10, // Adjust the space as needed
                                  ),
                                  Text(
                                    'Review',
                                    style: TextStyle(fontSize: 15),
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Help',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.edit_document,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Report safety issue here',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4), // Add padding
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Row(
                                children: [
                                  SizedBox(
                                    width: 60, // Adjust the space as needed
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
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
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Provide driver feedback',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4), // Add padding
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Row(
                                children: [
                                  SizedBox(
                                    width: 60, // Adjust the space as needed
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
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
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showTipDialog(BuildContext context) {
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
                _showFirstRecieptDialog(context);
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'Add Tip',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF2A966C), // Border color
                              width: 2, // Border width
                            ),

                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                          ),
                          padding: const EdgeInsets.all(8), // Padding around the icon
                          child: const Icon(
                            Icons.credit_card,
                            size: 40, // Icon size
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                          ),
                          padding: const EdgeInsets.all(8), // Padding around the icon
                          child: const Icon(
                            Icons.paypal,
                            size: 40, // Icon size
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                          ),
                          padding: const EdgeInsets.all(8), // Padding around the icon
                          child: const Icon(
                            Icons.currency_bitcoin,
                            size: 40, // Icon size
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 185,
                      width: 290,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/vimosh/card${index + 1}.png', // Use different images
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 20,
                    height: 5,
                    decoration: BoxDecoration(
                      color: index == 1
                          ? const Color(0xFF2A966C)
                          : Colors.grey, // Set color conditionally
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(118, 158, 158,
                        158), // Background color of the container
                    border: Border.all(
                      color: const Color.fromARGB(
                          118, 158, 158, 158), // Border color
                      width: 1.0, // Choose your border width
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Enter the Amount',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .end, // Align text to the end of the row
                              children: [
                                Text(
                                  'LKR 500',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 20),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200, // Specify the width of the button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showTipDoneDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A966C),
                        foregroundColor: Colors.white,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showTipDoneDialog(BuildContext context) {
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
                const SizedBox(height: 40),
                Container(
                  height: 100, // Specify the image height
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/vimosh/done.png',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Success !',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Thank you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
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
                    _showFirstRecieptDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C),
                    foregroundColor: Colors.white,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
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

void _showReviewDialog(BuildContext context) {
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
                _showFirstRecieptDialog(context);
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'Add Review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Align stars to the center horizontally
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xFF2A966C),
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFF2A966C),
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFF2A966C),
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star,
                    color: Color(0xFF2A966C),
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Color(0xFF2A966C),
                    size: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 130, // Specify the width
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A966C), // Border color),

                      border: Border.all(
                        color: const Color(0xFF2A966C), // Border color),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20), // Border radius
                    ),
                    padding: const EdgeInsets.all(4), // Add padding
                    child: GestureDetector(
                      onTap: () async {
                        // FilePickerResult? result =
                        //     await FilePicker.platform.pickFiles();
                        // if (result != null) {
                        //   // User has selected a file
                        // }
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10, // Adjust the space as needed
                          ),
                          Text(
                            'Add Images',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(
                          118, 158, 158, 158), // Border color
                      width: 1.0, // Choose your border width
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter the Review',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Color.fromARGB(160, 158, 158, 158),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showTipDoneDialog(context); // Show the third popup
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
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showViewRecieptDialog(BuildContext context) {
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
                _showFirstRecieptDialog(context);
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'Reciept',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '20 - April, 2024',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.ios_share,
                            size: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 150, // Specify the image height
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/vimosh/reciept.png',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here\'s your receipt !',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Guide Charges',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('9,000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(
                  color: Color.fromARGB(133, 158, 158, 158),
                  thickness: 1.0,
                ),
                const SizedBox(height: 2),

                // Bullock-Cart Ride
                // Drones
                // 360 Camera
                const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sri Lankan-style buffet',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('3,000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(
                  color: Color.fromARGB(133, 158, 158, 158),
                  thickness: 1.0,
                ),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bullock-Cart Ride',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('1,500',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(
                  color: Color.fromARGB(133, 158, 158, 158),
                  thickness: 1.0,
                ),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Drone Charges',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('2,000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(
                  color: Color.fromARGB(133, 158, 158, 158),
                  thickness: 1.0,
                ),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('360 camera',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('2,000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(
                  color: Color.fromARGB(133, 158, 158, 158),
                  thickness: 1.0,
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('LKR 17,500',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C),
                    foregroundColor: Colors.white,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Text('Download Receipt'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showPaymentDoneDialog(BuildContext context) {
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
                const SizedBox(height: 40),
                Container(
                  height: 100, // Specify the image height
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: const Color(0xFF2A966C), // Border color
                      width: 6,
                    ),
                  ),
                  child: const Icon(
                    Icons.done_rounded,
                    size: 80,
                    color: Color(0xFF2A966C),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Success !',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Congratulations , Reservation Success !',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
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
                    _showPaymentReceiptDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C),
                    foregroundColor: Colors.white,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Show Receipt'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    },
  );
}

void _showPaymentReceiptDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.ios_share),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50, // Specify the image height
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(
                            color: const Color(0xFF2A966C), // Border color
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.done_rounded,
                          size: 40,
                          color: Color(0xFF2A966C),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Payment Success!',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LKR 10,000.00',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ref Number',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('000085752257',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Payment Time',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('25-03-24, 13.50.17',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Payment Method',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Bank Transfer',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sender Name',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Vimosh V.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromARGB(110, 158, 158, 158),
                        thickness: 1.0,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Amount',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('10,000',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Transaction Fee',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('30',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250, // Specify the width of the button
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A966C),
                          foregroundColor: Colors.white,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_download_outlined,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text('Get PDF Receipt'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showPaymentOptionDialog(BuildContext context) {
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
                // _showFirstRecieptDialog(context);
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'Payment Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 20),
                          height: 185,
                          width: 290,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/vimosh/card${index + 1}.png', // Use different images
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 20,
                        height: 5,
                        decoration: BoxDecoration(
                          color: index == 1
                              ? const Color(0xFF2A966C)
                              : Colors.grey, // Set color conditionally
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(width: 2),
                                        Text('22.04.2024',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alarm_sharp,
                                          size: 20,
                                        ),
                                        SizedBox(width: 2),
                                        Text('10.00 am - 15.00 pm',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Divider(
                            color: Color.fromARGB(110, 158, 158, 158),
                            thickness: 1.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text('Vimosh Vasanthakumar (2000/hr)',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      Container(
                        width: 150, // Specify the width
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              121, 42, 150, 109), // Border color),

                          borderRadius:
                              BorderRadius.circular(20), // Border radius
                        ),
                        padding: const EdgeInsets.all(4), // Add padding
                        child: GestureDetector(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 20,
                                color: Color.fromARGB(255, 17, 60, 44),
                              ),
                              SizedBox(
                                width: 10, // Adjust the space as needed
                              ),
                              Text(
                                'Add Vouchers',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 17, 60, 44),
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Subtotal',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('LKR 10,000',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('VAT(10%)',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('LKR 1,000',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Discount',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('LKR 1,000',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(
                            color: Color.fromARGB(110, 158, 158, 158),
                            thickness: 1.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('10,000',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showPaymentDoneDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2A966C),
                            foregroundColor: Colors.white,
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Continue'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
