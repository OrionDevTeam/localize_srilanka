import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class MemoriesUploader extends StatefulWidget {
  const MemoriesUploader({Key? key}) : super(key: key);

  @override
  _MemoriesUploaderState createState() => _MemoriesUploaderState();
}

class _MemoriesUploaderState extends State<MemoriesUploader> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        User? user = _auth.currentUser;
        if (user == null) {
          // Handle the case where the user is not logged in
          print('No user logged in');
          return;
        }

        String userId = user.uid;
        String fileName = file.path.split('/').last;
        String filePath = 'Memories/$userId/$fileName';

        // Upload the file to Firebase Storage
        await _storage.ref(filePath).putFile(file);
        String downloadURL = await _storage.ref(filePath).getDownloadURL();

        // Save metadata to Firestore
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('memories')
            .add({
          'fileName': fileName,
          'filePath': filePath,
          'downloadURL': downloadURL,
          'uploadedAt': FieldValue.serverTimestamp(),
        });

        print('Memory uploaded successfully');

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Memory uploaded successfully'),
          ),
        );
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking or uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Memory'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _pickAndUploadImage,
          child: const Text('Pick and Upload Image'),
        ),
      ),
    );
  }
}

class MemoriesDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Your Memories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemoriesUploader()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('memories')
            .orderBy('uploadedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var memories = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: memories.length,
            itemBuilder: (context, index) {
              var memory = memories[index];
              return Image.network(memory['downloadURL'], fit: BoxFit.cover);
            },
          );
        },
      ),
    );
  }
}
