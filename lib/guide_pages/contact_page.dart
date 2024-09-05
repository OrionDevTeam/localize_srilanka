import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guide_model.dart';
import 'contact_card.dart';
import 'package:localize_sl/screens/users/chats/chatselection.dart';

class ContactPage extends StatefulWidget {
  final Guide guide;

  const ContactPage({super.key, required this.guide});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? currentUserRole;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserRole();
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
      // Check if a chat already exists between currentUserID and widget.guide.documentId (GuideID)
      QuerySnapshot<Map<String, dynamic>> chatSnapshot = await FirebaseFirestore
          .instance
          .collection('chats')
          .where('UserID', isEqualTo: currentUserID)
          .where('GuideID', isEqualTo: widget.guide.documentId)
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
            'GuideID': widget.guide.documentId,
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Contact Me',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Don\'t hesitate to contact me for \nbookings and if you have any \nsuggestions on how I \ncan improve my service',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ContactCard(
              icon: Icons.phone,
              title: 'Call me',
              subtitle: 'For booking inquiries',
              onTap: () async {
                // Handle phone call
              },
            ),
            ContactCard(
              icon: Icons.email,
              title: 'Email me',
              subtitle: 'For all your queries',
              onTap: () async {
                // Handle email
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity, // Full width
          child: ElevatedButton(
            onPressed: _handleChat,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A966C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Set border radius
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
        const SizedBox(height: 16.0),
        const Text(
          'Contact me in Social Media',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        ContactSocialMediaCard(
          icon: Icons.camera_alt,
          platform: 'Instagram',
          followers: 'vimoshtheguide',
          posts: '',
          url: widget.guide.instagramUrl,
        ),
        ContactSocialMediaCard(
          icon: Icons.send,
          platform: 'Telegram',
          followers: 'vimoshtele',
          posts: '',
          url: widget.guide.telegramUrl,
        ),
        ContactSocialMediaCard(
          icon: Icons.facebook,
          platform: 'Facebook',
          followers: 'Vimosh Vasanthakumar',
          posts: '',
          url: widget.guide.facebookUrl,
        ),
        ContactSocialMediaCard(
          icon: Icons.chat,
          platform: 'WhatsUp',
          followers: 'Hello there! I use Whatsapp as well',
          posts: '',
          url: widget.guide.whatsappUrl,
        ),
      ],
    );
  }
}
