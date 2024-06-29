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

  Future<Map<String, dynamic>?> _getMemoryDetails() async {
    String? caption;
    List<String> hashtags = [];
    String location = 'not mentioned';

    await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController captionController = TextEditingController();
        TextEditingController hashtagsController = TextEditingController();
        TextEditingController locationController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Memory Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  hintText: 'Enter caption here',
                ),
              ),
              TextField(
                controller: hashtagsController,
                decoration: const InputDecoration(
                  hintText: 'Enter hashtags (comma-separated)',
                ),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  hintText: 'Enter location',
                ),
              ),
            ],
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
                hashtags = hashtagsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .toList();
                location = locationController.text;
                Navigator.of(context).pop({
                  'caption': caption,
                  'hashtags': hashtags,
                  'location': location,
                });
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
    if (caption == null) return null;
    return {
      'caption': caption,
      'hashtags': hashtags,
      'location': location,
    };
  }

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

      Map<String, dynamic>? memoryDetails = await _getMemoryDetails();
      if (memoryDetails == null) return;

      await _uploadFile(pickedFile, 'image', memoryDetails);
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

      Map<String, dynamic>? memoryDetails = await _getMemoryDetails();
      if (memoryDetails == null) return;

      await _uploadFile(pickedVideo, 'video', memoryDetails);
    } catch (e) {
      print('Error picking or uploading video: $e');
    }
  }

  Future<void> _uploadFile(XFile pickedFile, String mediaType,
      Map<String, dynamic> memoryDetails) async {
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

      await _firestore.collection('memories').add({
        'fileName': fileName,
        'filePath': filePath,
        'downloadURL': downloadURL,
        'mediaType': mediaType,
        'uploadedAt': FieldValue.serverTimestamp(),
        'caption': memoryDetails['caption'],
        'hashtags': memoryDetails['hashtags'],
        'location': memoryDetails['location'],
        'userId': userId,
        'like_count': 0,
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
            .collection('memories')
            .where('userId', isEqualTo: user.uid)
            .orderBy('uploadedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No memories found'));
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
              List<dynamic> hashtagsDynamic = memory['hashtags'] ?? [];
              List<String> hashtags = hashtagsDynamic.cast<String>();
              String location = memory['location'] ?? '';
              int likeCount = memory['like_count'] ?? 0; // Fetch like_count

              return GestureDetector(
                onTap: () {
                  _showMediaDialog(
                      context,
                      mediaType,
                      downloadURL,
                      uploadedAt,
                      memoryId,
                      caption,
                      hashtags,
                      location,
                      likeCount); // Pass likeCount
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
            child: Text("Delete"),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showMediaDialog(
      BuildContext context,
      String mediaType,
      String url,
      Timestamp uploadedAt,
      String memoryId,
      String caption,
      List<String> hashtags,
      String location,
      int likeCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (mediaType == 'image') {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Your memory"),
                SizedBox(height: 20),
                Text('Location: $location'),
                SizedBox(height: 20),
                Text('Hashtags: ${hashtags.join(', ')}'),
                SizedBox(height: 20),
                Image.network(url),
                SizedBox(height: 20),
                Text('Uploaded at: ${_formatTimestamp(uploadedAt)}'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Likes: $likeCount'), // Display like count for image
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        _editMemoryDetails(context, memoryId);
                      },
                      child: Text('Edit'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _confirmDelete(context, memoryId);
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return VideoPlayerDialog(
            url: url,
            uploadedAt: uploadedAt,
            caption: caption,
            memoryId: memoryId,
            hashtags: hashtags,
            location: location,
            likeCount: likeCount, // Pass likeCount to VideoPlayerDialog
            editCallback: () => _editMemoryDetails(context, memoryId),
            deleteCallback: () => _confirmDelete(context, memoryId),
          );
        }
      },
    );
  }

  void _editMemoryDetails(BuildContext context, String memoryId) async {
    try {
      var memoryRef =
          FirebaseFirestore.instance.collection('memories').doc(memoryId);
      var snapshot = await memoryRef.get();

      if (!snapshot.exists) {
        print('Document does not exist');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Memory not found'),
          ),
        );
        return;
      }

      Map<String, dynamic> currentData =
          snapshot.data() as Map<String, dynamic>;

      TextEditingController captionController =
          TextEditingController(text: currentData['caption']);
      TextEditingController hashtagsController =
          TextEditingController(text: currentData['hashtags'].join(', '));
      TextEditingController locationController =
          TextEditingController(text: currentData['location']);

      showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Memory Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Caption: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: TextField(
                        controller: captionController,
                        decoration: const InputDecoration(
                          hintText: 'Enter caption here',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Hashtags: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: TextField(
                        controller: hashtagsController,
                        decoration: const InputDecoration(
                          hintText: 'Enter hashtags (comma-separated)',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Location: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          hintText: 'Enter location',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  String caption = captionController.text;
                  List<String> hashtags = hashtagsController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList();
                  String location = locationController.text;

                  try {
                    await memoryRef.update({
                      'caption': caption,
                      'hashtags': hashtags,
                      'location': location,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Memory updated successfully'),
                      ),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  } catch (e) {
                    print("Error updating memory: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to update memory'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error editing memory details: $e');
    }
  }
}

class VideoThumbnail extends StatefulWidget {
  final String url;

  const VideoThumbnail({Key? key, required this.url}) : super(key: key);

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final String url;
  final Timestamp uploadedAt;
  final String caption;
  final String memoryId;
  final List<String> hashtags;
  final String location;
  final int likeCount; // Added parameter
  final VoidCallback editCallback;
  final VoidCallback deleteCallback;

  const VideoPlayerDialog({
    Key? key,
    required this.url,
    required this.uploadedAt,
    required this.caption,
    required this.memoryId,
    required this.hashtags,
    required this.location,
    required this.likeCount, // Updated constructor
    required this.editCallback,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your memory'),
            SizedBox(height: 20),
            Text('Location: ${widget.location}'),
            SizedBox(height: 20),
            Text('Hashtags: ${widget.hashtags.join(', ')}'),
            SizedBox(height: 20),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            Text('Caption: ${widget.caption}'),
            SizedBox(height: 20),
            Text(
                'Uploaded at: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.uploadedAt.toDate())}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Likes: ${widget.likeCount}'), // Display like count
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: widget.editCallback,
                  child: Text('Edit'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: widget.deleteCallback,
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Memory App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: MemoriesDisplay(),
  ));
}
