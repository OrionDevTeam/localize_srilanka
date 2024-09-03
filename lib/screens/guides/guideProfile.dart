import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';
import 'package:localize_sl/screens/users/chats/chat.dart';
import 'package:localize_sl/screens/users/chats/chatselection.dart';

import 'guidereel.dart';

class GuideProfilePage extends StatefulWidget {
  final String userId;

  const GuideProfilePage({required this.userId, super.key});

  @override
  State<GuideProfilePage> createState() => _GuideProfilePageState();
}

class _GuideProfilePageState extends State<GuideProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? guideUserRole;
  String userName = '';
  String userEmail = '';
  String userBio = '';
  String profileImageUrl = '';
  String rating = '0';
  String reviews = '10';
  String location = "";
  String? currentUserRole;

  Future<void> _fetchUserRole() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          guideUserRole = data['user_role'] ?? '';
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

  Future<void> _fetchCurrentUserRole() async {
    try {
      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            currentUserRole = data['user_role'] ?? '';
          });
        } else {
          print('Current user role not found in snapshot data');
        }
      }
    } catch (e) {
      print('Error fetching current user role: $e');
    }
  }

  void _handleChat() async {
    // Fetch the current user's ID
    String? currentUserID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserRole == 'Guide' || currentUserRole == 'Business') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chat Not Allowed'),
            content: const Text('A Guide or Business cannot initiate a chat.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (currentUserID != null) {
      // Check if a chat already exists between currentUserID and widget.userId (GuideID)
      QuerySnapshot<Map<String, dynamic>> chatSnapshot = await FirebaseFirestore
          .instance
          .collection('chats')
          .where('UserID', isEqualTo: currentUserID)
          .where('GuideID', isEqualTo: widget.userId)
          .get();

      if (chatSnapshot.docs.isNotEmpty) {
        // Chat already exists, navigate to chat selection page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatSelectionPage(
              showBackButton: true, // Show back button on ChatSelectionPage
            ),
          ),
        );
      } else {
        // Chat does not exist, create a new chat document
        try {
          await FirebaseFirestore.instance.collection('chats').add({
            'UserID': currentUserID,
            'GuideID': widget.userId,
            // You can add more fields as needed
          });

          // Navigate to chat selection page after creating chat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatSelectionPage(
                showBackButton: true, // Show back button on ChatSelectionPage
              ),
            ),
          );
        } catch (e) {
          print('Error creating chat: $e');
          // Handle error creating chat
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
    _fetchCurrentUserRole();
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
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName ?? "Unknown",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    location,
                                    style: const TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange),
                                  Text('$rating ($reviews Reviews)',
                                      style: const TextStyle(color: Colors.black)),
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
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(122, 0, 0, 0)),
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
              const SizedBox(height: 10),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Set border radius
                    ),
                  ),
                  child: const Text(
                    'View Full profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton(
                  onPressed: _handleChat,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2A966C), // Customize button color as needed
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Set border radius
                    ),
                  ),
                  child: const Text(
                    'Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
