import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/guide_profile.dart';
import 'package:localize_sl/screens/users/userProfile.dart';

import '../map/map_home.dart';
import '../reels/reels.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<GuidePage> {
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 50, // Height of the BottomNavigationBar
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                MapS(),
                SocialMediaFeed(),
                userProfilePage(),
                GuideProfilePage(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map_outlined),
                      label: "Orders",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat_sharp),
                      label: "Chat",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey[400],
                  backgroundColor: Colors.white,
                  selectedIconTheme: IconThemeData(size: 32),
                  unselectedIconTheme: IconThemeData(size: 28),
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
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
