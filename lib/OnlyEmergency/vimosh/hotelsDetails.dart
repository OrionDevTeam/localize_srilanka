import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HotelDetailsPage extends StatelessWidget {
  HotelDetailsPage({
    super.key,
  });

  void _setDetailsDialog(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController ratingController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController noRatingController = TextEditingController();
    TextEditingController paymentController = TextEditingController();
    TextEditingController placeController = TextEditingController();

    File? _image;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Marker Details'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      controller: idController,
                      decoration: InputDecoration(labelText: 'id'),
                    ),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(labelText: 'location'),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'name'),
                    ),
                    TextField(
                      controller: paymentController,
                      decoration: InputDecoration(labelText: 'payment'),
                    ),
                    TextField(
                      controller: ratingController,
                      decoration: InputDecoration(labelText: 'rating'),
                    ),
                    TextField(
                      controller: noRatingController,
                      decoration: InputDecoration(labelText: 'norating'),
                    ),
                    TextField(
                      controller: placeController,
                      decoration: InputDecoration(labelText: 'place'),
                    ),
                    SizedBox(height: 20),
                    _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final XFile? pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        setState(() {
                          if (pickedFile != null) {
                            _image = File(pickedFile.path);
                          } else {
                            print('No image selected.');
                          }
                        });
                      },
                      child: Text('Pick Image'),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    String rating = ratingController.text;
                    String location = locationController.text;
                    String n = noRatingController.text;
                    String payment = paymentController.text;
                    String place = placeController.text;
                    String description = descriptionController.text;
                    String name = nameController.text;
                    String id = idController.text;

                    // Save data to Firestore
                    await FirebaseFirestore.instance
                        .collection('hotels')
                        .doc(place)
                        .collection('Hotels_Collection')
                        .doc(id)
                        .set({
                      'description': description,
                      'id': id,
                      'location': location,
                      'name': name,
                      'noRating': n,
                      'payment': payment,
                      'place': place,
                      'rating': rating,
                      'imageUrl': _image != null
                          ? await uploadImageAndReturnUrl(
                              _image!, place, context)
                          : null,
                    });

                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String> uploadImageAndReturnUrl(
      File imageFile, String place, BuildContext context) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final storageRef =
          FirebaseStorage.instance.ref().child('Hotels/$place/$fileName');
      final uploadTask = storageRef.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      print('Uploaded image URL: $downloadUrl');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );

      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image.')),
      );
      return ''; // Handle error case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _setDetailsDialog(context);
          },
          child: Text('Add Hotel Details'),
        ),
      ),
    );
  }
}
