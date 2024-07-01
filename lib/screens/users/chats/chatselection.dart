import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat.dart'; // Import the ChatPage

class ChatSelectionPage extends StatefulWidget {
  @override
  _ChatSelectionPageState createState() => _ChatSelectionPageState();
}

class _ChatSelectionPageState extends State<ChatSelectionPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _currentUser;
  late String _userRole;
  List<Map<String, dynamic>> _chats = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
      });
      await _fetchUserRole();
      _fetchChats();
    }
  }

  Future<void> _fetchUserRole() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .get();
    if (userDoc.exists) {
      setState(() {
        _userRole = userDoc.data()?['user_role'];
      });
    }
  }

  void _fetchChats() async {
    final query = _userRole == 'Guide'
        ? FirebaseFirestore.instance
            .collection('chats')
            .where('GuideID', isEqualTo: _currentUser.uid)
        : FirebaseFirestore.instance
            .collection('chats')
            .where('UserID', isEqualTo: _currentUser.uid);

    final chatsSnapshot = await query.get();
    final List<Map<String, dynamic>> chats = [];

    for (var chatDoc in chatsSnapshot.docs) {
      final chatData = chatDoc.data();
      final userID =
          _userRole == 'Guide' ? chatData['UserID'] : chatData['GuideID'];
      final userData = await fetchUserData(userID);
      if (userData != null) {
        chats.add({
          'chatID': chatDoc.id,
          'userData': userData,
        });
      }
    }

    setState(() {
      _chats = chats;
    });
  }

  Future<Map<String, dynamic>?> fetchUserData(String userID) async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    if (userSnapshot.exists) {
      return userSnapshot.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Chat"),
        automaticallyImplyLeading: false,
      ),
      body: _chats.isEmpty
          ? Center(child: Text("You have made no chats"))
          : ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                final userData = chat['userData'];
                return ListTile(
                  title: Text(userData['username']),
                  subtitle: Text(userData['user_role']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userData['profileImageUrl']),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          chatId: chat['chatID'],
                          userData: userData,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
