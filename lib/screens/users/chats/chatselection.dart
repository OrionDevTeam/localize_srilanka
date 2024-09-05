import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localize_sl/chat.dart';
import '../userProfile.dart';
import 'chat.dart';

class ChatSelectionPage extends StatefulWidget {
  final bool showBackButton;

  const ChatSelectionPage({super.key, this.showBackButton = false});

  @override
  _ChatSelectionPageState createState() => _ChatSelectionPageState();
}

class _ChatSelectionPageState extends State<ChatSelectionPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _currentUser;
  String _currentUserRole = '';
  List<Map<String, dynamic>> _chats = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          _currentUser = user;
          _currentUserRole = userSnapshot.get('user_role');
        });

        _fetchChats();
        await printAllUserDocumentIds(); // Call the method here
      } catch (e) {
        print('Error fetching current user: $e');
      }
    }
  }

  void _fetchChats() async {
    try {
      final chatsSnapshot =
          await FirebaseFirestore.instance.collection('chats').get();
      final List<Map<String, dynamic>> chats = [];

      print('Chats snapshot size: ${chatsSnapshot.size}');

      for (var chatDoc in chatsSnapshot.docs) {
        final chatData = chatDoc.data();
        String? otherUserId;
        String? userRole;

        print('_currentUserRole: $_currentUserRole');

        if (_currentUserRole == 'Guide') {
          if (chatData['GuideID'] == _currentUser.uid) {
            otherUserId = chatData['UserID'];
            userRole = 'User';
          }
        } else if (_currentUserRole == 'user') {
          if (chatData['UserID'] == _currentUser.uid) {
            otherUserId = chatData['GuideID'];
            userRole = 'Guide';
          }
        }

        if (otherUserId != null && userRole != null) {
          print('Fetching user data for userID: $otherUserId');
          final otherUserData = await fetchUserData(otherUserId);
          if (otherUserData != null) {
            print("Adding chat");
            chats.add({
              'chatID': chatDoc.id,
              'otherUserData': otherUserData,
              'userRole': userRole,
            });
          }
        }
            }

      setState(() {
        _chats = chats;
      });

      print('Fetched ${_chats.length} chats');
    } catch (e) {
      print('Error fetching chats: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      print("userid: $userId");
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      print('Attempting to fetch user data for userID: $userId');
      print('Document exists: ${userSnapshot.exists}');
      print('Fetched document ID: ${userSnapshot.id}'); // Debug statement

      if (userSnapshot.exists) {
        // Exclude 'bio' and 'email' fields from the data
        print("hi");
        Map<String, dynamic> userData = userSnapshot.data()!;
        userData.remove('bio');
        userData.remove('email');

        // Add the document id to the userData map
        userData['id'] = userSnapshot.id;

        print('User data: $userData');
        return userData;
      } else {
        print('User document does not exist for userID: $userId');
      }
    } catch (e) {
      print('Error fetching user data for userID: $userId, error: $e');
    }

    return null;
  }

  Future<void> printAllUserDocumentIds() async {
    try {
      final usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      print('All document IDs in the users collection:');
      for (var doc in usersSnapshot.docs) {
        print(doc.id);
      }
    } catch (e) {
      print('Error fetching user document IDs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Adjust the height as needed
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(18.0)), // Add border radius to the bottom
          child: AppBar(
            backgroundColor: const Color(0xFF2A966C),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12.0), // Border radius for the TextField
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _chats.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                final otherUserData =
                    chat['otherUserData'] as Map<String, dynamic>;
                return Column(
                  children: [
                    // create a container for the AI chat
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatBotPage(),
                            ),
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                // Leading Icon
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Iconsax.message,
                                    color: Colors.blue[700],
                                  ),
                                ),
                                SizedBox(width: 16),
                                // Title and Subtitle
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "AI Chat",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Chat with Vidara",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        SizedBox(width: 16.0),
                        Text(
                          'Chats',
                          style: TextStyle(
                            fontSize: 14.0, // Adjust the font size
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0), // Adjust padding as needed
                      leading: CircleAvatar(
                        radius: 24, // Adjust the size of the avatar
                        backgroundImage: NetworkImage(
                            otherUserData['profileImageUrl'] ?? ''),
                      ),
                      title: Text(
                        otherUserData['username'] ?? '',
                        style: const TextStyle(
                          fontSize: 16.0, // Adjust the font size
                          fontWeight: FontWeight.bold, // Make the username bold
                          color: Colors.black, // Set the text color
                        ),
                      ),
                      subtitle: Text(
                        chat['userRole'] ?? '',
                        style: const TextStyle(
                          fontSize:
                              14.0, // Adjust the font size for the subtitle
                          color: Colors.grey, // Set the subtitle color
                        ),
                      ),
                      trailing: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '10 min', // Replace with your dynamic time
                            style: TextStyle(
                              fontSize:
                                  12.0, // Adjust the font size for the time
                              color: Colors.grey, // Set the color for the time
                            ),
                          ),
                          SizedBox(height: 4.0),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              chatId: chat['chatID'],
                              guideData: {
                                'id': otherUserData[
                                    'id'], // Assuming 'id' is the key for guide's ID
                                'username': otherUserData[
                                    'username'], // Assuming 'username' is the key for guide's username
                                'profileImageUrl': otherUserData[
                                    'profileImageUrl'], // Key for guide's profile image URL
                                'user_role': otherUserData[
                                    'user_role'], // Key for guide's user role
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
