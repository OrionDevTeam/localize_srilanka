import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserSettingsPage extends StatefulWidget {
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _bioController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String _username = '';
  String _newEmail = '';
  String _newPassword = '';
  String _newBio = '';
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      User? user = _auth.currentUser;
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user!.uid).get();

      setState(() {
        _username = snapshot.get('username');
        _newEmail = user.email ?? '';
        _newBio = snapshot.get('bio') ?? ''; // Fetch bio from Firestore
        _profileImageUrl =
            snapshot.get('image_src') ?? ''; // Fetch profile image URL
        _bioController.text = _newBio; // Set bio in TextEditingController
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _updateUsername(String newUsername) async {
    try {
      User? user = _auth.currentUser;

      await _firestore.collection('users').doc(user!.uid).update({
        'username': newUsername,
      });

      setState(() {
        _username = newUsername;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username updated successfully')),
      );
    } catch (e) {
      print('Error updating username: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update username')),
      );
    }
  }

  Future<void> _updateEmail(String newEmail) async {
    try {
      User? user = _auth.currentUser;

      await user!.updateEmail(newEmail);

      await _firestore.collection('users').doc(user.uid).update({
        'email': newEmail,
      });

      setState(() {
        _newEmail = newEmail;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email updated successfully')),
      );
    } catch (e) {
      print('Error updating email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update email')),
      );
    }
  }

  Future<void> _updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;

      await user!.updatePassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated successfully')),
      );
    } catch (e) {
      print('Error updating password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password')),
      );
    }
  }

  Future<void> _updateBio(String newBio) async {
    try {
      User? user = _auth.currentUser;

      await _firestore.collection('users').doc(user!.uid).update({
        'bio': newBio,
      });

      setState(() {
        _newBio = newBio;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bio updated successfully')),
      );
    } catch (e) {
      print('Error updating bio: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update bio')),
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
          SnackBar(content: Text('Profile picture updated successfully')),
        );
      }
    } catch (e) {
      print('Error updating profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile picture')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _profileImageUrl.isNotEmpty
                  ? NetworkImage(_profileImageUrl) as ImageProvider
                  : AssetImage('assets/placeholder.jpg'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfilePicture,
              child: Text('Change Profile Picture'),
            ),
            SizedBox(height: 32.0),
            Text('Current username: $_username'),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'New Username'),
              onChanged: (value) => _username = value.trim(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _updateUsername(_username),
              child: Text('Update username'),
            ),
            SizedBox(height: 32.0),
            Text('Current Email: $_newEmail'),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'New Email'),
              onChanged: (value) => _newEmail = value.trim(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _updateEmail(_newEmail),
              child: Text('Update Email'),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio:'),
              onChanged: (value) => _newBio = value.trim(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _updateBio(_newBio),
              child: Text('Update Bio'),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
              onChanged: (value) => _newPassword = value.trim(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _updatePassword(_newPassword),
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
