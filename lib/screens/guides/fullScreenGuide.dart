import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localize_sl/floating_chat.dart';
import 'package:localize_sl/screens/guides/guideProfile.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:ui';

import 'guidereel.dart';

class FullScreenPostDialogx extends StatefulWidget {
  final Postx ost;

  const FullScreenPostDialogx({super.key, required this.ost});

  @override
  _FullScreenPostDialogState createState() => _FullScreenPostDialogState();
}

class _FullScreenPostDialogState extends State<FullScreenPostDialogx> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.ost.downloadURL);
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
      widget.ost.isLiked = !widget.ost.isLiked;
      widget.ost.like_count += widget.ost.isLiked ? 1 : -1;
    });

    // Reference to the Firestore document
    var postDocRef = FirebaseFirestore.instance
        .collection('reelsDemo')
        .doc(widget.ost.username); // Adjust this line based on your document ID

    // Check if the document exists before updating
    var docSnapshot = await postDocRef.get();

    if (docSnapshot.exists) {
      // Document exists, update it
      postDocRef.update({
        'isLiked': widget.ost.isLiked,
        'like': widget.ost.like_count,
      });
    } else {
      // Document does not exist, handle accordingly
      print("Document not found. Unable to update like status.");
    }
  }

  final Offset _fabPosition = const Offset(0, 180); // Initial position

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.black,
      child: VisibilityDetector(
        key: Key(widget.ost.downloadURL),
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
                                width: _controller.value.size.width ?? 0,
                                height: _controller.value.size.height ?? 0,
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
                        child: CircularProgressIndicator(color: Colors.green));
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
              // Positioned(
              //   top: 20,
              //   left: 10,
              //   child: Container(
              //     height: 40,
              //     padding: EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       color: Colors.white70,
              //       borderRadius: BorderRadius.circular(32),
              //     ),
              //     child: Center(
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: 8,
              //           ),
              //           Icon(
              //             Icons.location_on,
              //             size: 16,
              //             color: Colors.black,
              //           ),
              //           SizedBox(width: 4),
              //           Text(
              //             widget.post.location,
              //             style: TextStyle(
              //               fontFamily: 'Poppins',
              //               fontWeight: FontWeight.w500,
              //               fontSize: 14,
              //             ),
              //           ),
              //           SizedBox(
              //             width: 8,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              Positioned(
                top: 40,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: const Icon(
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
                              return const GuidePage();
                            },
                            transitionDuration: const Duration(milliseconds: 500),
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
                                  userId: widget.ost.userId);
                            },
                            transitionDuration: const Duration(milliseconds: 500),
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
                        backgroundImage: NetworkImage(widget.ost.profileUrl),
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return GuideProfilePage(
                                      userId: widget.ost.userId);
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
                          child: Text(
                            widget.ost.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          widget.ost.type,
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
                        widget.ost.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.ost.isLiked ? Colors.red : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.ost.like_count}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 60,
                left: 10,
                right: 10,
                child: Text(
                  widget.ost.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const FloatingChatButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guide Page')),
      body: const Center(child: Text('Guide Page Content')),
    );
  }
}
