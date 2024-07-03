import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EditMemoryPage extends StatefulWidget {
  final String memoryId;

  EditMemoryPage({required this.memoryId});

  @override
  _EditMemoryPageState createState() => _EditMemoryPageState();
}

class _EditMemoryPageState extends State<EditMemoryPage> {
  late TextEditingController _captionController;
  late TextEditingController _hashtagsController;
  late TextEditingController _locationController;
  String? _videoUrl;
  String? _thumbnailPath;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
    _hashtagsController = TextEditingController();
    _locationController = TextEditingController();
    _fetchMemoryDetails();
  }

  Future<void> _fetchMemoryDetails() async {
    var memoryRef =
        FirebaseFirestore.instance.collection('memories').doc(widget.memoryId);
    var snapshot = await memoryRef.get();

    if (!snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memory not found'),
        ),
      );
      Navigator.of(context).pop();
      return;
    }

    Map<String, dynamic> currentData = snapshot.data() as Map<String, dynamic>;

    setState(() {
      _captionController.text = currentData['caption'];
      _hashtagsController.text = currentData['hashtags'].join(' #');
      _locationController.text = currentData['location'];
      _videoUrl =
          currentData['downloadURL']; // Assuming there's a field 'videoUrl'
      _generateThumbnail();
    });
  }

  Future<void> _generateThumbnail() async {
    if (_videoUrl != null) {
      final directory = await getTemporaryDirectory();
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: _videoUrl!,
        thumbnailPath: directory.path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 200, // specify the height of the thumbnail, optional
        quality: 75,
      );

      setState(() {
        _thumbnailPath = thumbnailPath;
      });
    }
  }

  Future<void> _updateMemory() async {
    String caption = _captionController.text;
    List<String> hashtags =
        _hashtagsController.text.split(',').map((e) => e.trim()).toList();
    String location = _locationController.text;

    var memoryRef =
        FirebaseFirestore.instance.collection('memories').doc(widget.memoryId);

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
    } catch (e) {
      print("Error updating memory: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update memory'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: _thumbnailPath == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(File(_thumbnailPath!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _captionController,
                      decoration: const InputDecoration(
                        labelText: 'Caption',
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _hashtagsController,
                      decoration: const InputDecoration(
                        labelText: 'Hashtags',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2A966C),
                            foregroundColor: Colors.white),
                        onPressed: _updateMemory,
                        child: const Text('Update'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
