import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glossy/glossy.dart'; // Import glossy package
import 'package:localize_sl/colorpalate.dart';
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
            bottom: 10,
            child: SafeArea( // Wrap in SafeArea to prevent overflow
              child: Container(
                width: double.infinity,
                height: 68,
                // borderRadius: BorderRadius.circular(24),
                // opacity: 0.5,
                // strengthX: 20, // Horizontal blur strength
                // strengthY: 20, // Vertical blur strength
                // border: Border.all(
                //   color: ColorPalette.grey2,
                //   width: 1.5,
                // ),
                // color: Colors.white.withOpacity(0.2),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black,
                //     blurRadius: 10,
                //     // spreadRadius: 2,
                //     offset: const Offset(0, 3),
                //   ),
                // ],
                // blendMode: BlendMode.overlay, // Define the blending mode
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Container(
                    color: ColorPalette.green,
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
                          icon: Icon(Iconsax.video_play),
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
                      unselectedItemColor:
                          Colors.white.withOpacity(0.45),
                      backgroundColor: Colors.transparent, // Transparent to show glossy effect
                      selectedIconTheme: const IconThemeData(size: 32),
                      unselectedIconTheme: const IconThemeData(size: 28),
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      onTap: _onItemTapped,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}