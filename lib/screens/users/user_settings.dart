import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        setState(() {
          _usernameController.text = snapshot.get('username') ?? '';
          _emailController.text = user.email ?? '';
          _bioController.text = snapshot.get('bio') ?? '';
          _profileImageUrl = snapshot.get('profileImageUrl') ?? '';

          // Debugging statements
          print('Username: ${_usernameController.text}');
          print('Email: ${_emailController.text}');
          print('Bio: ${_bioController.text}');
          print('Profile Image URL: $_profileImageUrl');
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _updateUserDetails() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String newUsername = _usernameController.text.trim();
        String newEmail = _emailController.text.trim();
        String newPassword = _passwordController.text.trim();
        String newBio = _bioController.text.trim();

        if (newUsername.isNotEmpty) {
          await _firestore.collection('users').doc(user.uid).update({
            'username': newUsername,
          });
        }

        if (newEmail.isNotEmpty && newEmail != user.email) {
          await user.updateEmail(newEmail);
          await _firestore.collection('users').doc(user.uid).update({
            'email': newEmail,
          });
        }

        if (newPassword.isNotEmpty) {
          await user.updatePassword(newPassword);
        }

        if (newBio.isNotEmpty) {
          await _firestore.collection('users').doc(user.uid).update({
            'bio': newBio,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User details updated successfully')),
        );
      }
    } catch (e) {
      print('Error updating user details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update user details')),
      );
    }
  }

  Future<void> _updateProfilePicture() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);
        User? user = _auth.currentUser;

        // Upload to Firebase Storage
        TaskSnapshot snapshot =
            await _storage.ref('Profile pictures/${user!.uid}').putFile(file);

        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update Firestore with the new image URL
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          _profileImageUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully')),
        );
      }
    } catch (e) {
      print('Error updating profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile picture')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _profileImageUrl.isNotEmpty
                  ? NetworkImage(_profileImageUrl) as ImageProvider
                  : const AssetImage('assets/placeholder.jpg'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfilePicture,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2A966C), // White text color
                textStyle: const TextStyle(
                  fontSize: 14, // Optional: Change the font size if needed
                ),
              ),
              child: const Text('Change Profile Picture'),
            ),
            const SizedBox(height: 32.0),
            const Text('Username:'),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Enter your new username',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Email:'),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your new email',
              ),
            ),
            // const SizedBox(height: 16.0),
            // const Text('Bio:'),
            // TextFormField(
            //   controller: _bioController,
            //   decoration: const InputDecoration(
            //     hintText: 'Enter your bio',
            //   ),
            // ),
            const SizedBox(height: 16.0),
            const Text('Password:'),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your new password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _updateUserDetails,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // White text color
                backgroundColor:
                    const Color(0xFF2A966C), // Green background color
                textStyle: const TextStyle(
                  fontSize: 14, // Optional: Change the font size if needed
                ),
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
