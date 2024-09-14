import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import '../guideProfileDisplay.dart/uploadReel.dart';

class MemoriesUploader extends StatefulWidget {
  const MemoriesUploader({super.key});

  @override
  _MemoriesUploaderState createState() => _MemoriesUploaderState();
}

class _MemoriesUploaderState extends State<MemoriesUploader> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  String? _thumbnailPath;
  // ignore: unused_field
  String? _mediaType;

  Future<Map<String, dynamic>?> _getMemoryDetails(
      String thumbnailPath, String mediaType) async {
    Map<String, dynamic>? memoryDetails = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddMemoryDetailsPage(
          thumbnailPath: thumbnailPath,
          mediaType: mediaType,
        ),
      ),
    );

    return memoryDetails;
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        return;
      }

      setState(() {
        _thumbnailPath = pickedFile.path;
        _mediaType = 'image';
      });

      Map<String, dynamic>? memoryDetails =
          await _getMemoryDetails(pickedFile.path, 'image');
      if (memoryDetails == null) return;

      await _uploadFile(pickedFile, 'image', memoryDetails);
    } catch (e) {
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
        return;
      }

      setState(() {
        _thumbnailPath = pickedVideo.path;
        _mediaType = 'video';
      });

      Map<String, dynamic>? memoryDetails =
          await _getMemoryDetails(pickedVideo.path, 'video');
      if (memoryDetails == null) return;

      await _uploadFile(pickedVideo, 'video', memoryDetails);
    } catch (e) {
    }
  }

  Future<void> _uploadFile(XFile pickedFile, String mediaType,
      Map<String, dynamic> memoryDetails) async {
    try {
      File file = File(pickedFile.path);
      User? user = _auth.currentUser;
      if (user == null) {
        return;
      }

      String userId = user.uid;
      String fileName = file.path.split('/').last;
      String filePath = 'Memories/$userId/$fileName';

      await _storage.ref(filePath).putFile(file);
      String downloadURL = await _storage.ref(filePath).getDownloadURL();

      await _firestore.collection('memories').add({
        'downloadURL': downloadURL,
        'mediaType': mediaType,
        'uploadedAt': FieldValue.serverTimestamp(),
        'caption': memoryDetails['caption'],
        'hashtags': memoryDetails['hashtags'],
        'location': memoryDetails['location'],
        'userId': userId,
        'like_count': 10,
        'isLiked': false
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memory uploaded successfully'),
        ),
      );
    } catch (e) {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/vimosh/upload.jpg',
                height: 400,
              ),
              if (_thumbnailPath != null)
                ElevatedButton(
                  onPressed: _pickAndUploadImage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF2A966C),
                    foregroundColor: Colors.white,
                    elevation: 4,
                  ),
                  child: const Text('Upload Image'),
                ),
              const SizedBox(height: 10),
              // Text("or", style: TextStyle(color: Colors.black)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickAndUploadVideo,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF2A966C),
                    ), // Add border color here
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2A966C),
                  elevation: 4,
                ),
                child: const Text('Upload Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
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
        : Container(
            child:
                const Center(child: CircularProgressIndicator(color: Colors.green)),
          );
  }
}

class MemoriesDisplay extends StatelessWidget {
  const MemoriesDisplay({super.key});

  String _formatTimestamp(Timestamp timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Your Memories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MemoriesUploader()),
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
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No memories found'));
          }

          var memories = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: memories.length,
            itemBuilder: (context, index) {
              var memory = memories[index];
              String mediaType = memory['mediaType'];
              String downloadURL = memory['downloadURL'];
              Timestamp uploadedAt = memory['uploadedAt'] ?? Timestamp.now();
              String memoryId = memory.id;
              String caption = memory['caption'] ?? '';
              List<dynamic> hashtagsDynamic = memory['hashtags'] ?? [];
              List<String> hashtags = hashtagsDynamic.cast<String>();
              String location = memory['location'] ?? '';
              int likeCount = memory['like_count'] ?? 0;

              return GestureDetector(
                onTap: () {
                  _showMediaDialog(context, mediaType, downloadURL, uploadedAt,
                      memoryId, caption, hashtags, location, likeCount);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: mediaType == 'image'
                            ? Image.network(downloadURL, fit: BoxFit.cover)
                            : VideoThumbnailWidget(url: downloadURL),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  void _confirmDelete(BuildContext context, String memoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this memory?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('memories')
                    .doc(memoryId)
                    .delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Memory deleted successfully"),
                  ),
                );
                Navigator.of(context).pop(); // Close the dialog
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Failed to delete memory"),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text("Delete"),
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
                const Text("Your memory"),
                const SizedBox(height: 20),
                Text('Location: $location'),
                const SizedBox(height: 20),
                Text('Hashtags: ${hashtags.join(', ')}'),
                const SizedBox(height: 20),
                Image.network(url),
                const SizedBox(height: 20),
                Text('Uploaded at: ${_formatTimestamp(uploadedAt)}'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Likes: $likeCount'), // Display like count for image
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        _editMemoryDetails(context, memoryId);
                      },
                      child: const Text('Edit'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _confirmDelete(context, memoryId);
                      },
                      child: const Text('Delete'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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
                    const Text('Caption: ',
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Hashtags: ',
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Location: ',
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
    }
  }
}

class VideoThumbnailWidget extends StatefulWidget {
  final String url;

  const VideoThumbnailWidget({super.key, required this.url});

  @override
  _VideoThumbnailWidgetState createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  Uint8List? _thumbnailBytes;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      final cacheManager = DefaultCacheManager();
      final file = await cacheManager.getSingleFile(widget.url);

      final uint8list = await VideoThumbnail.thumbnailData(
        video: file.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the width of the thumbnail, higher quality
        quality: 75,
      );

      if (uint8list != null) {
        setState(() {
          _thumbnailBytes = uint8list;
        });
      }
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_thumbnailBytes == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.green));
    }

    return Image.memory(_thumbnailBytes!, fit: BoxFit.cover);
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
    super.key,
    required this.url,
    required this.uploadedAt,
    required this.caption,
    required this.memoryId,
    required this.hashtags,
    required this.location,
    required this.likeCount, // Updated constructor
    required this.editCallback,
    required this.deleteCallback,
  });

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
            const Text('Your memory'),
            const SizedBox(height: 20),
            Text('Location: ${widget.location}'),
            const SizedBox(height: 20),
            Text('Hashtags: ${widget.hashtags.join(', ')}'),
            const SizedBox(height: 20),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                }
              },
            ),
            const SizedBox(height: 20),
            Text('Caption: ${widget.caption}'),
            const SizedBox(height: 20),
            Text(
                'Uploaded at: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.uploadedAt.toDate())}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Likes: ${widget.likeCount}'), // Display like count
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: widget.editCallback,
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: widget.deleteCallback,
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
