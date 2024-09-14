import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_sl/colorpalate.dart';
import 'package:video_player/video_player.dart';

class AdventureHomePage extends StatelessWidget {
  final Map<String, dynamic> provider;
  final List<String> memories = [
    'assets/vimosh/s4.mp4',
    'assets/vimosh/s2.mp4',
    'assets/vimosh/s1.mp4',
    'assets/vimosh/s4.mp4',
    'assets/vimosh/s2.mp4',
    'assets/vimosh/s1.mp4',
  ];

  AdventureHomePage({super.key, required this.provider});

  void showAllReels(BuildContext context, List<String> reelUrls) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            color: Colors.transparent,
            height: 400,
            child: ListView.builder(
              itemCount: reelUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      playVideo(context, reelUrls[index]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: VideoThumbnail(
                        videoUrl: reelUrls[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void playVideo(BuildContext context, String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Surf with ${provider['name']}' ?? "Unknown",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  provider['titleImageUrl'],
                  fit: BoxFit.cover,
                  height: 161,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 161,
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Row(
                      children: [
                        const Text(
                          'LKR ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          provider['rate'].toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Text(
                          ' / hour',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorPalette.green2,
                          ColorPalette.green,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement booking functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${provider['about']}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: memories.take(2).map((url) {
                  return GestureDetector(
                    onTap: () {
                      playVideo(context, url);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: VideoThumbnail(videoUrl: url),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (memories.length > 2)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showAllReels(context, memories);
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              ReviewSection(
                  reviews:
                      List<Map<String, dynamic>>.from(provider['reviews'])),
              SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         _setDetailsDialog(context, provider);
              //       },
              //       child: Icon(Icons.add),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoThumbnail extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnail({super.key, required this.videoUrl});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
          _controller.pause(); // Pause the video to show the thumbnail
        });
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? SizedBox(
            height: 230,
            width: 162,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : Container(
            height: 230,
            width: 162,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(color: Colors.green),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 30, // Position the button at the top
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: const Color(0xFF009DE1),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: Positioned(
      //   bottom: 100, // Position the button at the top
      //   right: 20, // Align it to the right
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     onPressed: () {
      //       setState(() {
      //         _controller.value.isPlaying
      //             ? _controller.pause()
      //             : _controller.play();
      //       });
      //     },
      //     child: Icon(
      //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //       color: Color(0xFF009DE1),
      //     ),
      //   ),
      // ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  final List<dynamic> reviews;

  const ReviewSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: reviews.take(5).map((review) {
              var reviewMap = review as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReviewTile(
                  name: reviewMap['name'] ?? 'Anonymous',
                  date: reviewMap['date'] ?? 'Unknown date',
                  rating: reviewMap['rating'].toString(),
                  review: reviewMap['review'] ?? 'No review available',
                  imageUrl:
                      reviewMap['imageUrl'] ?? 'https://via.placeholder.com/50',
                ),
              );
            }).toList(),
          ),
        ),
        if (reviews.length > 3)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllReviewsScreen(reviews: reviews),
                  ),
                );
              },
              child: const Text(
                'See All Reviews',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String name;
  final String date;
  final String rating;
  final String review;
  final String imageUrl;

  const ReviewTile({
    super.key,
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Fixed width for each review tile
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.grey1!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A966C),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              review,
              maxLines: 3, // Limit the number of lines for the review text
              overflow: TextOverflow.ellipsis, // Handle overflow
            ),
          ],
        ),
      ),
    );
  }
}

class AllReviewsScreen extends StatelessWidget {
  final List<dynamic> reviews;

  const AllReviewsScreen({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var reviewMap = reviews[index] as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ReviewTile(
              name: reviewMap['name'] ?? 'Anonymous',
              date: reviewMap['date'] ?? 'Unknown date',
              rating: reviewMap['rating'].toString(),
              review: reviewMap['review'] ?? 'No review available',
              imageUrl:
                  reviewMap['imageUrl'] ?? 'https://via.placeholder.com/50',
            ),
          );
        },
      ),
    );
  }
}

_setDetailsDialog(BuildContext context, Map<String, dynamic> provider) {
  TextEditingController ratingController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  File? image;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add Review'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                  ),
                  TextField(
                    controller: ratingController,
                    decoration: const InputDecoration(labelText: 'Rating'),
                  ),
                  TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(labelText: 'Review'),
                  ),
                  const SizedBox(height: 20),
                  image == null
                      ? const Text('No image selected.')
                      : Image.file(image!),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      setState(() {
                        if (pickedFile != null) {
                          image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: const Text('Pick Image'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  String rating = ratingController.text;
                  String review = reviewController.text;
                  String name = nameController.text;
                  String date = dateController.text;

                  Map<String, dynamic> newReview = {
                    'date': date,
                    'name': name,
                    'rating': rating,
                    'review': review,
                    'imageUrl': image != null
                        ? await uploadImageAndReturnUrl(
                            image!, provider['name'], context)
                        : null,
                  };

                  // Add the new review to the existing reviews
                  provider['reviews'] ??= [];
                  provider['reviews'].add(newReview);

                  // Save updated provider to Firestore
                  await FirebaseFirestore.instance
                      .collection('adventures/Coconut Tree Hill/Surfing')
                      .doc(provider['name'])
                      .update(provider);

                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<String> uploadImageAndReturnUrl(
    File imageFile, String markerId, BuildContext context) async {
  try {
    final fileName = imageFile.path.split('/').last;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('Adventures/South/Surfing/$fileName');
    final uploadTask = storageRef.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    print('Uploaded image URL: $downloadUrl');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image uploaded successfully!')),
    );

    return downloadUrl;
  } catch (e) {
    print('Failed to upload image: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to upload image.')),
    );
    return ''; // Handle error case
  }
}
