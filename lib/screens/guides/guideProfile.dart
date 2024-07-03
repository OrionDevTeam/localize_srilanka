import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';

import 'guidereel.dart';

class GuideProfilePage extends StatefulWidget {
  final String userId;

  const GuideProfilePage({required this.userId, Key? key}) : super(key: key);

  @override
  State<GuideProfilePage> createState() => _GuideProfilePageState();
}

class _GuideProfilePageState extends State<GuideProfilePage> {
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
          .doc(widget.userId)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                                ? NetworkImage(profileImageUrl) as ImageProvider
                                : const AssetImage('assets/placeholder.jpg'),
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${location}',
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange),
                                  Text('$rating ($reviews Reviews)',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
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
                    Text(
                      userBio,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GuideDetailPage(userId: widget.userId),
                      ),
                    );
                  },
                  child: Text(
                    'View Full Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A966C),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Set border radius
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton(
                  onPressed: () {
                    // Implement your chat logic here
                    // Example: Navigate to chat page or open a chat window
                    // Replace with your actual chat implementation
                  },
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF2A966C), // Customize button color as needed
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Set border radius
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 1200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SocialMediaFeedy(
                  userId: widget.userId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
