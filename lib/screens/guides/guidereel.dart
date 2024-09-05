import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/floating_chat.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'fullScreenGuide.dart';

// Data model for a Post
class Postx {
  final String caption;
  int like_count;
  final String location;
  final String profileUrl;
  final String downloadURL;
  final String type;
  final String username;
  final String userId;
  bool isLiked; // Add this field

  Postx({
    required this.caption,
    required this.like_count,
    required this.location,
    required this.profileUrl,
    required this.downloadURL,
    required this.type,
    required this.username,
    required this.userId,
    this.isLiked = false, // Initialize it
  });

  factory Postx.fromDocument(DocumentSnapshot doc) {
    return Postx(
        caption: doc['caption'] ?? '',
        like_count: doc['like_count'] ?? 0,
        location: doc['location'] ?? '',
        profileUrl: doc['profileUrl'] ?? '', // Initialize to empty
        downloadURL: doc['downloadURL'] ?? '',
        type: doc['type'] ?? '',
        username: doc['username'] ?? '', // Initialize to empty
        isLiked: doc['isLiked'] ?? false, // Initialize from document
        userId: doc['userId'] ?? '');
  }

  Map<String, dynamic> toDocument() {
    return {
      'caption': caption,
      'like_count': like_count,
      'location': location,
      'profileUrl': profileUrl,
      'downloadURL': downloadURL,
      'type': type,
      'username': username,
      'isLiked': isLiked,
      'userId': userId,
    };
  }
}

Future<Map<String, dynamic>> getUserDetails(String userId) async {
  try {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return {
        'profileUrl': userDoc['profileImageUrl'] ?? '',
        'username': userDoc['username'] ?? '',
        'type': userDoc['user_role'] ?? ''
      };
    } else {
      throw Exception("User not found");
    }
  } catch (e) {
    print("Error fetching user details: $e");
    return {};
  }
}

class SocialMediaFeedy extends StatefulWidget {
  final String userId; // Add userId as a parameter

  const SocialMediaFeedy({super.key, required this.userId}); // Pass userId to the constructor

  @override
  _SocialMediaFeedState createState() => _SocialMediaFeedState();
}

class _SocialMediaFeedState extends State<SocialMediaFeedy> {
  final TextEditingController _searchController = TextEditingController();
  final Offset _fabPosition = const Offset(0, 140); // Initial position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                // Add some space at the top (status bar height)
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('memories')
                        .where('userId',
                            isEqualTo: widget.userId) // Filter by userId
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.green));
                      }

                      var posts = snapshot.data!.docs;
                      List<Future<Postx>> futurePosts = posts.map((doc) async {
                        // Create Post object from document
                        String userId = doc['userId'];
                        Map<String, dynamic> userDetails =
                            await getUserDetails(userId);

                        // Create Post object with fetched user details
                        return Postx(
                          caption: doc['caption'] ?? '',
                          like_count: doc['like_count'] ?? 0,
                          location: doc['location'] ?? '',
                          profileUrl: userDetails['profileUrl'] ?? 'x',
                          downloadURL: doc['downloadURL'] ?? '',
                          type: 'LOCALIZE ${userDetails['type']}'.toUpperCase(),
                          username: userDetails['username'] ?? 'x',
                          userId: userId,
                          isLiked: doc['isLiked'] ?? false,
                        );
                      }).toList();

                      // Use FutureBuilder to handle asynchronous fetching of posts
                      return FutureBuilder<List<Postx>>(
                        future: Future.wait(futurePosts),
                        builder: (context, futureSnapshot) {
                          if (!futureSnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.green));
                          }
                          var posts = futureSnapshot.data!;

                          // Adding one to the itemCount to include the extra SizedBox
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of items per row
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                              childAspectRatio:
                                  3 / 4, // Aspect ratio for each item
                            ),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return PostWidget(post: posts[index]);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const FloatingChatButton(),
        ],
      ),
    );
  }
}

// Widget for displaying individual posts
class PostWidget extends StatefulWidget {
  final Postx post;

  const PostWidget({super.key, required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.post.downloadURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _isDisposed = true;
    super.dispose();
  }

  void _playPauseVideo(bool isVisible) {
    if (_isDisposed) return;
    if (isVisible) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  void _toggleLike() async {
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
      widget.post.like_count += widget.post.isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0), // Add padding here
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenPostDialogx(ost: widget.post),
            ),
          );
        },
        child: VisibilityDetector(
          key: Key(widget.post.downloadURL),
          onVisibilityChanged: (visibilityInfo) {
            var isVisible = visibilityInfo.visibleFraction > 0.5;
            _playPauseVideo(isVisible);
          },
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: FutureBuilder<void>(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: VideoPlayer(_controller),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10.0)),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    widget.post.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: widget.post.isLiked
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfile {}

// Custom widget for the fullscreen video player
class VideoPlayerWidget extends StatefulWidget {
  final Postx post;

  const VideoPlayerWidget({super.key, required this.post});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.post.downloadURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
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
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width ?? 0,
                      height: _controller.value.size.height ?? 0,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                if (!_controller.value.isPlaying)
                  const Icon(Icons.play_arrow, size: 40.0, color: Colors.white),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }
      },
    );
  }
}
