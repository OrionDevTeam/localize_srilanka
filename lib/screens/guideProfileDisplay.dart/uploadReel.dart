import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class AddMemoryDetailsPage extends StatefulWidget {
  final String thumbnailPath;
  final String mediaType;

  const AddMemoryDetailsPage({super.key, required this.thumbnailPath, required this.mediaType});

  @override
  _AddMemoryDetailsPageState createState() => _AddMemoryDetailsPageState();
}

class _AddMemoryDetailsPageState extends State<AddMemoryDetailsPage> {
  TextEditingController captionController = TextEditingController();
  TextEditingController hashtagsController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.mediaType == 'video') {
      _videoController = VideoPlayerController.file(File(widget.thumbnailPath))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    if (widget.mediaType == 'video') {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(); // Close the screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (widget.mediaType == 'image')
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.file(
                    File(widget.thumbnailPath),
                    fit: BoxFit.cover,
                  ),
                )
              else if (widget.mediaType == 'video' &&
                  _videoController.value.isInitialized)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: captionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter caption here',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: hashtagsController,
                  decoration: const InputDecoration(
                    hintText: 'Enter hashtags (#-separated)',
                    border: InputBorder.none,
                  ),
                  maxLines: 2, // Allows for multiline input
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    hintText: 'Enter location',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop(); // Close the screen
                  //   },
                  //   child: const Text('Cancel'),
                  // ),
                  TextButton(
                    onPressed: () {
                      String caption = captionController.text;
                      List<String> hashtags = hashtagsController.text
                          .split('#')
                          .map((e) => e.trim())
                          .toList();
                      String location = locationController.text;
                      Navigator.of(context).pop({
                        'caption': caption,
                        'hashtags': hashtags,
                        'location': location,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xFF2A966C),
                      foregroundColor: Colors.white,
                      elevation: 4,
                    ),
                    child: const Text('Upload Memory'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
