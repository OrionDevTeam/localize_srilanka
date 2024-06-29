import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

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
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        print('No image selected');
        return;
      }

      String? caption = await _getCaption();
      if (caption == null) return;

      await _uploadFile(pickedFile, 'image', caption);
    } catch (e) {
      print('Error picking or uploading image: $e');
    }
  }

  Future<void> _pickAndUploadVideo() async {
    try {
      final XFile? pickedVideo = await _picker.pickVideo(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10),
      );

      if (pickedVideo == null) {
        print('No video selected');
        return;
      }

      String? caption = await _getCaption();
      if (caption == null) return;

      await _uploadFile(pickedVideo, 'video', caption);
    } catch (e) {
      print('Error picking or uploading video: $e');
    }
  }

  Future<void> _uploadFile(
      XFile pickedFile, String mediaType, String caption) async {
    try {
      File file = File(pickedFile.path);
      User? user = _auth.currentUser;
      if (user == null) {
        print('No user logged in');
        return;
      }

      String userId = user.uid;
      String fileName = file.path.split('/').last;
      String filePath = 'Memories/$userId/$fileName';

      await _storage.ref(filePath).putFile(file);
      String downloadURL = await _storage.ref(filePath).getDownloadURL();

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('memories')
          .add({
        'fileName': fileName,
        'filePath': filePath,
        'downloadURL': downloadURL,
        'mediaType': mediaType,
        'uploadedAt': FieldValue.serverTimestamp(),
        'caption': caption,
      });

      print('Memory uploaded successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memory uploaded successfully'),
        ),
      );
    } catch (e) {
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload memory'),
        ),
      );
    }
  }

  Future<String?> _getCaption() async {
    String? caption;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController captionController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Caption'),
          content: TextField(
            controller: captionController,
            decoration: const InputDecoration(
              hintText: 'Enter caption here',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                caption = captionController.text;
                Navigator.of(context).pop(caption);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
    return caption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Memory'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: const Text('Upload Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickAndUploadVideo,
              child: const Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}

class MemoriesDisplay extends StatelessWidget {
  String _formatTimestamp(Timestamp timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp.toDate());
  }

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
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: memories.length,
            itemBuilder: (context, index) {
              var memory = memories[index];
              String mediaType = memory['mediaType'];
              String downloadURL = memory['downloadURL'];
              Timestamp uploadedAt = memory['uploadedAt'];
              String memoryId = memory.id;
              String caption = memory['caption'] ?? '';

              return GestureDetector(
                onTap: () {
                  _showMediaDialog(context, mediaType, downloadURL, uploadedAt,
                      memoryId, caption);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: mediaType == 'image'
                          ? Image.network(downloadURL, fit: BoxFit.cover)
                          : VideoThumbnail(url: downloadURL),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String memoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete this memory?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('memories')
                    .doc(memoryId)
                    .delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Memory deleted successfully"),
                  ),
                );
                Navigator.of(context).pop(); // Close the dialog
              } catch (e) {
                print("Error deleting memory: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to delete memory"),
                  ),
                );
              }
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showMediaDialog(BuildContext context, String mediaType, String url,
      Timestamp uploadedAt, String memoryId, String caption) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Your Memory",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Uploaded at: ${_formatTimestamp(uploadedAt)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 15),
                mediaType == 'image'
                    ? Image.network(url)
                    : VideoPlayerDialog(url: url),
                SizedBox(height: 15),
                Text(
                  'Caption: $caption',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _editCaption(context, memoryId, caption);
                      },
                      child: Text('Edit Caption'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        _confirmDelete(context, memoryId);
                      },
                      child: Text('Delete'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editCaption(
      BuildContext context, String memoryId, String currentCaption) {
    String newCaption = currentCaption;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Caption'),
          content: TextField(
            onChanged: (value) {
              newCaption = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter new caption',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('memories')
                      .doc(memoryId)
                      .update({
                    'caption': newCaption,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Caption updated successfully'),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error updating caption: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update caption'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class VideoThumbnail extends StatelessWidget {
  final String url;

  const VideoThumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        VideoPlayerWidget(url: url),
        Icon(Icons.play_circle_outline, size: 50, color: Colors.white),
      ],
    );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final String url;

  const VideoPlayerDialog({required this.url});

  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}
