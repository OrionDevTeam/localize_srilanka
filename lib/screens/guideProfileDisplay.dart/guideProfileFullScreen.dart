import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:ui';

import 'editMemory.dart';
import 'guideProfileReel.dart';

class FullScreenPostDialogReel extends StatefulWidget {
  final Postreel postreel;

  FullScreenPostDialogReel({required this.postreel});

  @override
  _FullScreenPostDialogState createState() => _FullScreenPostDialogState();
}

class _FullScreenPostDialogState extends State<FullScreenPostDialogReel> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.postreel.downloadURL);
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
    if (_isDisposed) return; // Prevent further operations if disposed

    if (isVisible) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  void _toggleLike() async {
    setState(() {
      widget.postreel.isLiked = !widget.postreel.isLiked;
      widget.postreel.like_count += widget.postreel.isLiked ? 1 : -1;
    });

    // Reference to the Firestore document
    var postDocRef = FirebaseFirestore.instance.collection('reelsDemo').doc(
        widget.postreel.username); // Adjust this line based on your document ID

    // Check if the document exists before updating
    var docSnapshot = await postDocRef.get();

    if (docSnapshot.exists) {
      // Document exists, update it
      postDocRef.update({
        'isLiked': widget.postreel.isLiked,
        'like': widget.postreel.like_count,
      });
    } else {
      // Document does not exist, handle accordingly
      print("Document not found. Unable to update like status.");
    }
  }

  Offset _fabPosition = Offset(0, 180); // Initial position

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.black,
      child: VisibilityDetector(
        key: Key(widget.postreel.downloadURL),
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
            Navigator.of(context).pop();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTap: () {
                        if (_isDisposed) return; // Prevent tapping if disposed

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
                                width: _controller.value.size?.width ?? 0,
                                height: _controller.value.size?.height ?? 0,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                          ),
                          if (!_controller.value.isPlaying)
                            Icon(Icons.play_arrow,
                                size: 40.0, color: Colors.white),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.7),
                            ],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              // Positioned(
              // top: 0,
              // left: 0,
              // right: 0,
              // bottom: 0,
              // child: BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              //   child: Container(
              //   color: Colors.black.withOpacity(0.5),
              //   ),
              // ),
              // ),
              Positioned(
                top: 30,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10.0)),
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
                                  leading: Icon(
                                    Icons.edit,
                                    color: Color(0xFF2A966C),
                                  ),
                                  title: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Color(0xFF2A966C),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _editMemory(
                                        context, widget.postreel.memoryId);
                                    print("Edit memory details");
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Color(0xFF2A966C),
                                  ),
                                  title: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Color(0xFF2A966C),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _confirmDelete(
                                        context, widget.postreel.memoryId);
                                    print(widget.postreel.memoryId);
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
                              return GuideMemoriesPage(
                                  username: widget.postreel.username);
                            },
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(0.0, 1.0); // Slide from bottom to top
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
                            NetworkImage(widget.postreel.profileUrl),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to guide memories page
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return GuideMemoriesPage(
                                      username: widget.postreel.username);
                                },
                                transitionDuration: Duration(milliseconds: 500),
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
                          child: Text(
                            widget.postreel.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          widget.postreel.type,
                          style: TextStyle(
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
                        widget.postreel.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            widget.postreel.isLiked ? Colors.red : Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${widget.postreel.like_count}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 60,
                left: 10,
                right: 10,
                child: Text(
                  widget.postreel.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: _fabPosition.dx,
                top: _fabPosition.dy,
                child: MouseRegion(
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        // Add your onPressed functionality here
                        print('Widget pressed!');
                      },
                      child: Draggable(
                        feedback: Material(
                          color: Colors.transparent,
                          child: Tooltip(
                            message: 'Chat with Mochi',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.asset(
                                'assets/vimosh/chatBot.jpg', // Replace with your image asset path
                                width: 56.0,
                                height: 56.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        child: Tooltip(
                          message: 'Chat with Mochi',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.asset(
                              'assets/vimosh/chatBot.jpg', // Replace with your image asset path
                              width: 56.0,
                              height: 56.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onDragEnd: (details) {
                          setState(() {
                            // Get the screen width
                            final screenWidth =
                                MediaQuery.of(context).size.width;

                            // Snap to the nearest side (left or right)
                            final newOffsetX =
                                details.offset.dx < screenWidth / 2
                                    ? 0.0
                                    : screenWidth -
                                        56.0; // 56.0 is the image's width
                            _fabPosition =
                                Offset(newOffsetX, details.offset.dy);
                          });
                        },
                        childWhenDragging:
                            Container(), // Empty container when dragging
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guide Page')),
      body: Center(child: Text('Guide Page Content')),
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
