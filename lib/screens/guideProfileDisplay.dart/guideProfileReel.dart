import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/screens/guideProfileDisplay.dart/guideProfileFullScreen.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'editMemory.dart';

// Data model for a Post
class Postreel {
  final String caption;
  int like_count;
  final String location;
  final String profileUrl;
  final String downloadURL;
  final String type;
  final String username;
  final String userId;
  bool isLiked; // Add this field
  final String memoryId;

  Postreel({
    required this.caption,
    required this.like_count,
    required this.location,
    required this.profileUrl,
    required this.downloadURL,
    required this.type,
    required this.username,
    required this.userId,
    this.isLiked = false, // Initialize it
    required this.memoryId,
  });

  factory Postreel.fromDocument(DocumentSnapshot doc) {
    return Postreel(
        memoryId: doc.id,
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

class ProfileFeed extends StatefulWidget {
  final String userId; // Add userId as a parameter

  ProfileFeed({required this.userId}); // Pass userId to the constructor

  @override
  _SocialMediaFeedState createState() => _SocialMediaFeedState();
}

class _SocialMediaFeedState extends State<ProfileFeed> {
  final TextEditingController _searchController = TextEditingController();

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
                        return Center(child: CircularProgressIndicator());
                      }

                      var posts = snapshot.data!.docs;
                      List<Future<Postreel>> futurePosts =
                          posts.map((doc) async {
                        // Create Post object from document
                        String userId = doc['userId'];
                        Map<String, dynamic> userDetails =
                            await getUserDetails(userId);

                        // Create Post object with fetched user details
                        return Postreel(
                          caption: doc['caption'] ?? '',
                          like_count: doc['like_count'] ?? 0,
                          location: doc['location'] ?? '',
                          profileUrl: userDetails['profileUrl'] ?? 'x',
                          downloadURL: doc['downloadURL'] ?? '',
                          type: 'LOCALIZE ${userDetails['type']}'.toUpperCase(),
                          username: userDetails['username'] ?? 'x',
                          userId: userId,
                          isLiked: doc['isLiked'] ?? false,
                          memoryId: doc.id,
                        );
                      }).toList();

                      // Use FutureBuilder to handle asynchronous fetching of posts
                      return FutureBuilder<List<Postreel>>(
                        future: Future.wait(futurePosts),
                        builder: (context, futureSnapshot) {
                          if (!futureSnapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var posts = futureSnapshot.data!;

                          // Adding one to the itemCount to include the extra SizedBox
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
        ],
      ),
    );
  }
}

// Widget for displaying individual posts
class PostWidget extends StatefulWidget {
  final Postreel post;

  PostWidget({required this.post});

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
    _controller.setVolume(1.0);
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
              builder: (context) =>
                  FullScreenPostDialogReel(postreel: widget.post),
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
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0)),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 4.0),
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
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0)),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.more_vert),
                            color: Colors.white,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text('Edit'),
                                          onTap: () {
                                            Navigator.of(context).pop();

                                            _editMemory(
                                                context, widget.post.memoryId);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text('Delete'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _confirmDelete(
                                                context, widget.post.memoryId);
                                            print(widget.post.memoryId);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
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
  final Postreel post;

  VideoPlayerWidget({required this.post});

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
    _controller.setVolume(1.0);
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
                      height: _controller.value.size?.height ?? 0,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                if (!_controller.value.isPlaying)
                  Icon(Icons.play_arrow, size: 40.0, color: Colors.white),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// Placeholder for the guide page
class GuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guide Page')),
      body: Center(),
    );
  }
}

// Placeholder for the guide memories page
class GuideMemoriesPage extends StatelessWidget {
  final String username;

  GuideMemoriesPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guide Memories of $username')),
      body: Center(child: Text('Guide Memories Page Content for $username')),
    );
  }
}

void _confirmDelete(BuildContext context, String memoryId) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this memory?"),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF2A966C)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
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
              print("Error deleting memory: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to delete memory"),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF2A966C)),
          child: const Text("Delete"),
        ),
      ],
    ),
  );
}

void _editMemory(BuildContext context, String memoryId) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditMemoryPage(memoryId: memoryId),
    ),
  );
}
