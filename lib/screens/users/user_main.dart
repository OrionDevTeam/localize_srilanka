import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chats/chatselection.dart';
import 'package:localize_sl/user_profile.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../map/map_home.dart';
import '../reels/reels.dart';
import '../../home_screen.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0; // Add selected index for navigation
  User? currentUser; // Variable to hold the logged-in user

  @override
  void initState() {
    super.initState();
    _getCurrentUser(); // Get the logged-in user when the widget initializes
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to get the currently logged-in user
  void _getCurrentUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          currentUser = user; // Set the current user
        });
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              HomeScreen(user: currentUser),
              const MapS(showBackButton: false),
              const SocialMediaFeed(),
              const ChatSelectionPage(),
              const UserProfilePage(),
            ],
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 20,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.home_2),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.map),
                      label: "Maps",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.video_play,
                        // size: 35,
                      ),
                      label: "Reels",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.message),
                      label: "Chat",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.user),
                      label: "Profile",
                    ),
                  ],

                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color.fromARGB(192, 189, 189, 189),
                  backgroundColor: Colors.black,
                  selectedIconTheme: const IconThemeData(size: 32),
                  unselectedIconTheme: const IconThemeData(size: 28),
                  // selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  // unselectedLabelStyle:
                  //     TextStyle(fontWeight: FontWeight.normal),
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
