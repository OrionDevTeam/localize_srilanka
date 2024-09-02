import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/guide_profile.dart';
import 'chats/chatselection.dart';
import 'package:localize_sl/screens/users/userProfile.dart';
import 'package:localize_sl/user_profile.dart';
import 'package:iconsax/iconsax.dart';

import '../map/map_home.dart';
import '../reels/reels.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0; // Add selected index for navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
              MapS(),
              SocialMediaFeed(),
              ChatSelectionPage(),
              UserProfilePage(),
            ],
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              decoration: BoxDecoration(
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.home_2),
                      label: "Orders",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.video_play,
                        // size: 35,
                      ),
                      label: "Home",
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
                  selectedIconTheme: IconThemeData(size: 32),
                  unselectedIconTheme: IconThemeData(size: 28),
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
