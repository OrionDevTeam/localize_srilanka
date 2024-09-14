import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'visa_application1.dart';

class SelectVisaType extends StatefulWidget {
  const SelectVisaType({super.key});

  @override
  _VisaScreenState createState() => _VisaScreenState();
}

class _VisaScreenState extends State<SelectVisaType> {
  String selectedVisaType = 'Standard Visitor';

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _applyForVisa() async {
    try {
      // Get current user
      User? user = _auth.currentUser;
      if (user == null) {
        // Handle user not logged in
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      // Create a new visa document
      DocumentReference visaRef = await _firestore.collection('visas').add({
        'type': selectedVisaType,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create a new visa application document
      await _firestore.collection('visa applications').add({
        'ongoing': true,
        'status': 'Ongoing',
        'userRef': _firestore.collection('users').doc(user.uid),
        'visa': visaRef,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Visa application initiated successfully')),
      );

      // Optionally, navigate to another page or reset state
      Navigator.pop(context);
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF00BA72),
          ),
          // Positioned(
          //   top: 60,
          //   left: 15,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Icon(
          //       Icons.arrow_back_ios_new_sharp,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Positioned(
            top: 70,
            left: 20,
            child: Column(
              children: [
                Image.asset(
                  'assets/visa/girl.png', // Path to your foreground image
                  height: 200,
                ),
              ],
            ),
          ),
          Positioned(
            top: 70,
            right: 40,
            child: Column(
              children: [
                const Text(
                  'Select Visa Type',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: DropdownButton<String>(
                        value: selectedVisaType,
                        icon: const Icon(Icons.arrow_drop_down_sharp,
                            color: Colors.white),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedVisaType = newValue!;
                          });
                        },
                        items: <String>[
                          'Standard Visitor',
                          'Business Visa',
                          'Student Visa'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF2A966C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        await _applyForVisa();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VisaApplicationFormPage()),
                        );
                      },
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                )
              ],
            ),
          ),
          Positioned(
            top: 270, // Adjust the position based on the design
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                ),
              ),
              child: const Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xFF2A966C),
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(
                  //           left: 8,
                  //           right: 8,
                  //         ),
                  //         child: Text(
                  //           "50\$",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "1. Period of Visa",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "06 months at one stretch limiting 60 days at each visit (Double entry within the validity period of the visa). "
                            "If more than 60 days are needed, you can extend for 2 months (terminating the double entry facility).",
                          ),
                          SizedBox(height: 16),

                          // Allowed Activities
                          Text(
                            "2. Allowed Activities:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "- Sightseeing / Holidaying\n"
                            "- Visiting friends and relatives\n"
                            "- Medical treatment including Ayurveda and Yoga\n"
                            "- Participating in sports events, competitions, and cultural performances",
                          ),
                          SizedBox(height: 16),

                          // Not Allowed Activities
                          Text(
                            "3. Not Allowed Activities:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "- Engage in Business/Trade activities\n"
                            "- Taking part in meetings, conferences, and short-term training programs\n"
                            "- Employment-related activities\n"
                            "- Long-term stay in Sri Lanka",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 250,
          //   right: 40,
          //   child: Container(
          //     padding: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF2A966C),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: const Padding(
          //       padding: EdgeInsets.only(
          //         left: 8,
          //         right: 8,
          //       ),
          //       child: Text(
          //         "50\$",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
