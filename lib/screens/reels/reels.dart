import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';
import 'package:localize_sl/screens/guides/guideProfile.dart';
import 'package:localize_sl/screens/reels/fullscreen.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

// Data model for a Post
class Post {
  final String caption;
  int like_count;
  final String location;
  final String profileUrl;
  final String downloadURL;
  final String type;
  final String username;
  final String userId;
  bool isLiked; // Add this field

  Post({
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

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
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

//
class SocialMediaFeed extends StatefulWidget {
  const SocialMediaFeed({super.key});

  @override
  _SocialMediaFeedState createState() => _SocialMediaFeedState();
}

class _SocialMediaFeedState extends State<SocialMediaFeed> {
// Initial position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            const SizedBox(
                height: 40), // Add some space at the top (status bar height)
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   margin: const EdgeInsets.only(bottom: 8),
            //   child: Row(
            //     children: [
            //       // Search bar and filter icon
            //       Expanded(
            //         flex: 9,
            //         child: Container(
            //           height: 50,
            //           decoration: BoxDecoration(
            //             color: Colors.grey[200],
            //             borderRadius: BorderRadius.circular(16),
            //           ),
            //           child: Row(
            //             children: [
            //               const SizedBox(width: 12),
            //               const Icon(Icons.search, color: Colors.grey),
            //               const SizedBox(width: 16),
            //               Expanded(
            //                 child: Center(
            //                   child: TextField(
            //                     controller: _searchController,
            //                     decoration: const InputDecoration(
            //                       hintText: 'Search here ..',
            //                       border: InputBorder.none,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 8), // Space between search and filter icon
            //       const Expanded(
            //         flex: 1,
            //         child: Icon(Iconsax.filter, color: Colors.grey),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('memories')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var posts = snapshot.data!.docs;
                  List<Future<Post>> futurePosts = posts.map((doc) async {
                    // Create Post object from document
                    String userId = doc['userId'];
                    Map<String, dynamic> userDetails =
                        await getUserDetails(userId);

                    // Create Post object with fetched user details
                    return Post(
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
                  return FutureBuilder<List<Post>>(
                    future: Future.wait(futurePosts),
                    builder: (context, futureSnapshot) {
                      if (!futureSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var posts = futureSnapshot.data!;

                      // Adding one to the itemCount to include the extra SizedBox
                      return ListView.separated(
                        itemCount:
                            posts.length + 1, // +1 for the SizedBox at the end
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12.0), // Gap between posts
                        itemBuilder: (context, index) {
                          if (index == posts.length) {
                            // Return the SizedBox at the end of the list
                            return const SizedBox(height: 30.0);
                          }
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
    );
  }
}

// Widget for displaying individual posts
class PostWidget extends StatefulWidget {
  final Post post;

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
    if (_isDisposed) return; // Prevent further operations if disposed

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

    // Reference to the Firestore document
    var postDocRef = FirebaseFirestore.instance.collection('memories').doc(
        widget.post.username); // Adjust this line based on your document ID

    // Check if the document exists before updating
    var docSnapshot = await postDocRef.get();

    if (docSnapshot.exists) {
      // Document exists, update it
      postDocRef.update({
        'isLiked': widget.post.isLiked,
        'like_count': widget.post.like_count,
      });
    } else {
      // Document does not exist, handle accordingly
      print("Document not found. Unable to update like status.");
    }
  }

  void _showFullScreenDialog(Post post) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FullScreenPostDialog(post: post);
        },
        opaque: false, // Ensure the dialog is not opaque
        barrierDismissible:
            true, // Allows the dialog to be dismissed by tapping outside
        transitionDuration:
            const Duration(milliseconds: 500), // Transition animation duration
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Slide from bottom to top
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.post.downloadURL),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 50) {
          _playPauseVideo(true);
        } else {
          _playPauseVideo(false);
        }
      },
      child: GestureDetector(
        onTap: () {
          _showFullScreenDialog(widget.post);
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: SizedBox(
                      width: 343,
                      height: 343,
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return GestureDetector(
                              onTap: () {
                                if (_isDisposed) {
                                  return; // Prevent tapping if disposed
                                }

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
                                        width: _controller.value.size.width,
                                        height: _controller.value.size.height,
                                        child: VideoPlayer(_controller),
                                      ),
                                    ),
                                  ),
                                  if (!_controller.value.isPlaying)
                                    const Icon(Icons.play_arrow,
                                        size: 40.0, color: Colors.white),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.green));
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.post.location,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 0,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to guide page
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return GuideDetailPage(
                                    userId: widget.post.userId,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 500),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(
                                      0.0, 1.0); // Slide from bottom to top
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Book Now",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to guide memories page
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return GuideProfilePage(
                                    userId: widget.post.userId,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 500),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(
                                      0.0, 1.0); // Slide from bottom to top
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.post.profileUrl),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to guide memories page
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return GuideProfilePage(
                                        userId: widget.post.userId,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(
                                          0.0, 1.0); // Slide from bottom to top
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                          position: offsetAnimation,
                                          child: child);
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                widget.post.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              widget.post.type,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleLike, // Toggle like on tap
                          child: Icon(
                            widget.post.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                widget.post.isLiked ? Colors.red : Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.post.like_count}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 10,
                    right: 10,
                    child: Text(
                      widget.post.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

class UserProfile {}

// Custom widget for the fullscreen video player
class VideoPlayerWidget extends StatefulWidget {
  final Post post;

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
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
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
