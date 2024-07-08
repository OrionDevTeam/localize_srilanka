import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/chat.dart';
import 'package:localize_sl/floating_chat.dart';
import 'package:localize_sl/screens/users/userProfile.dart';

import 'screens/getStarted.dart';
import 'screens/wrapper.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? userRole;
  String userName = '';
  String userEmail = '';
  String userBio = '';
  String profileImageUrl = '';
  String rating = '0';
  String reviews = '10';
  String location = "";

  Future<void> _fetchUserRole() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          userRole = data['user_role'] ?? '';
          userName = data['username'] ?? '';
          userEmail = data['email'] ?? '';
          userBio = data['bio'] ?? '';
          profileImageUrl = data['profileImageUrl'] ?? '';
          rating = data['rating'].toString() ?? '0';
          reviews = data['reviews'].toString() ?? '10';
          location = data['location'] ?? '';
        });
      } else {
        print('User role not found in snapshot data');
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Offset _fabPosition = Offset(0, 140); // Initial position

  @override
  Widget build(BuildContext context) {
    if (userRole == null) {
      // Show a loading indicator while fetching data
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.green),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            setState(() {
              _fetchUserRole();
            });
          },
          child: const Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.confirmation_num_outlined),
            onPressed: () {
              signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                radius: 50,
                                backgroundImage: profileImageUrl.isNotEmpty
                                    ? NetworkImage(profileImageUrl)
                                        as ImageProvider
                                    : const AssetImage(
                                        'assets/placeholder.jpg'),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userName}' ?? "Unknown",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        '${userEmail}',
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFF2A966C)),
                                    ),
                                    onPressed: () {
                                      signOut();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomeScreen()),
                                        (route) =>
                                            false, // This line ensures you cannot go back to the profile page after signing out
                                      );
                                    },
                                    child: SizedBox(
                                      width: 80,
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Logout',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(122, 0, 0, 0)),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Container(
                    height: 700,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: userProfilePage(),
                  ),
                ],
              ),
            ),
            const FloatingChatButton(),
          ],
        ),
      ),
    );
  }
}

void signOut() {
  FirebaseAuth.instance.signOut();
}
