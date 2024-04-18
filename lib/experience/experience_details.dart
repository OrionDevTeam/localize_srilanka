import 'package:flutter/material.dart';
import 'package:localize_sl/experience/foods.dart';
import 'package:localize_sl/experience/guides.dart';
import 'package:localize_sl/experience/hotels.dart';


class ExperienceDetailsPage extends StatefulWidget {
  const ExperienceDetailsPage({
    super.key,
    required this.heroTag,
  });

  final String heroTag;

  @override
  State<ExperienceDetailsPage> createState() => _ExperienceDetailsPageState();
}

class _ExperienceDetailsPageState extends State<ExperienceDetailsPage> {
  int _activeImageIndex = 0;
  int _activeSectionIndex = 0;

  // active button style
  final ButtonStyle activeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2A966C),
    shadowColor: Colors.white,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Color(0xFF2A966C)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // inactive button style
  final ButtonStyle inactiveButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Part (40% Width)
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: widget.heroTag,
                          child: Image.asset(
                            'assets/vimosh/w${_activeImageIndex+1}.jpg', // Replace with the path to your image
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.5),
                            ),
                            icon: const Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: () {
                              if (_activeImageIndex > 0) {
                                setState(() {
                                  _activeImageIndex--;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.5),
                            ),
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: Colors.white,
                            onPressed: () {
                              if (_activeImageIndex < 2) {
                                setState(() {
                                  _activeImageIndex++;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ for (var i = 0; i < 3; i++)
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _activeImageIndex
                            ? Colors.blue
                            : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Secret Waterfall',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star_half_outlined,
                        color: Color.fromARGB(255, 234, 205, 40),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.0',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 26,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Wellawaya-Ella High way',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Adjust color as needed
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A Rural water fall, situated in a silent place. And recently they made a iron steps which is very convenient to enjoy the beauty of the Waterfall.',
                    style: TextStyle(fontSize: 14, fontFamily: 'Popins'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _activeSectionIndex = 0;
                          });
                        },
                        style: _activeSectionIndex == 0
                          ? activeButtonStyle
                          : inactiveButtonStyle,
                        child: const Row(
                          children: [
                            Icon(Icons.person_sharp),
                            SizedBox(width: 5),
                            Text('Guides'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _activeSectionIndex = 1;
                          });
                        },
                        style: _activeSectionIndex == 1
                          ? activeButtonStyle
                          : inactiveButtonStyle,
                        child: const Row(
                          children: [
                            Icon(Icons.restaurant),
                            SizedBox(width: 5),
                            Text('Food'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _activeSectionIndex = 2;
                          });
                        },
                        style: _activeSectionIndex == 2
                          ? activeButtonStyle
                          : inactiveButtonStyle,
                        child: const Row(
                          children: [
                            Icon(Icons.hotel),
                            SizedBox(width: 5),
                            Text('Hotels'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: inactiveButtonStyle,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.local_grocery_store,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text('Groceries'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: inactiveButtonStyle,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.atm,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text('ATM'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: inactiveButtonStyle,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text('To do'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: _activeSectionIndex == 0
              ? const GuidesInfoSection()
              : _activeSectionIndex == 1
                ? const FoodsInfoSection()
                : const HotelsInfoSection()
          ),
        ],
      ),
    );
  }
}
