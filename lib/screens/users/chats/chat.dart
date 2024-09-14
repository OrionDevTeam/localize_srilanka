import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:image_picker/image_picker.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final Map<String, dynamic> guideData;

  const ChatPage({
    super.key,
    required this.chatId,
    required this.guideData,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late types.User _currentUser;
  late types.User _otherUser;
  String _guideProfileImageUrl = '';
  String _guideUserRole = '';
  final List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeUsers();
    _fetchGuideData();
  }

  void _initializeUsers() {
    _currentUser = types.User(
      id: FirebaseAuth.instance.currentUser!.uid,
    );

    final guideId = widget.guideData['id'];

    if (guideId != null && guideId is String) {
      _otherUser = types.User(
        id: guideId,
      );
    } else {
      _otherUser = const types.User(
        id: 'default_user_id',
      );
    }
  }

  void _fetchGuideData() {
    setState(() {
      _guideProfileImageUrl = widget.guideData['profileImageUrl'] ?? '';
      _guideUserRole = widget.guideData['user_role'] ?? '';
    });
    print('Profile Image URL: $_guideProfileImageUrl');
    print('User Role: $_guideUserRole');
  }

  void _addMessage(types.Message message) async {
    // Convert message to JSON
    final messageJson = message.toJson();

    // Upload image or video to Firebase Storage
    if (message is types.ImageMessage) {
      final imageMessage = message;
      final file = File(imageMessage.uri);

      // Create reference to storage path
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chats')
          .child('images')
          .child('${imageMessage.id}.jpg');

      // Upload file to storage
      final uploadTask = storageRef.putFile(file);

      // Get download URL
      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      // Update message JSON with download URL
      messageJson['uri'] = downloadUrl.toString();
    } else if (message is types.VideoMessage) {
      final videoMessage = message;
      final file = File(videoMessage.uri);

      // Create reference to storage path
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chats')
          .child('videos')
          .child('${videoMessage.id}.mp4');

      // Upload file to storage
      final uploadTask = storageRef.putFile(file);

      // Get download URL
      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      // Update message JSON with download URL
      messageJson['uri'] = downloadUrl.toString();
    }

    // Update Firestore with message details including URI
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .update({
      'messages': FieldValue.arrayUnion([messageJson])
    });
  }

  Future<File> _saveImageToFilesystem(String name, Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/$name');

    await image.writeAsBytes(bytes);
    return image;
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo'),
              onTap: () {
                Navigator.pop(context);
                _handleImageSelection(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Video'),
              onTap: () {
                Navigator.pop(context);
                _handleVideoSelection();
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleImageSelection(ImageSource source) async {
    if (await _requestPhotoPermission()) {
      final result = await ImagePicker().pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 1440,
      );

      if (result != null) {
        final bytes = await result.readAsBytes();
        final image = await decodeImageFromList(bytes);

        final message = types.ImageMessage(
          author: _currentUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: path.basename(result.path),
          size: bytes.length,
          uri: result.path,
          height: image.height.toDouble(),
          width: image.width.toDouble(),
        );

        _addMessage(message);
      }
    } else {
      print('Permission denied.');
      // Optionally show a message to the user about why the permission is needed
    }
  }

  Future<void> _handleVideoSelection() async {
    if (await _requestVideoPermission()) {
      final result = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );

      if (result != null) {
        final videoFile = File(result.path);

        final message = types.VideoMessage(
          author: _currentUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: path.basename(result.path),
          size: videoFile.lengthSync(),
          uri: result.path,
        );

        _addMessage(message);
      }
    } else {
      print('Permission denied.');
    }
  }

  Future<bool> _requestPhotoPermission() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      status = await Permission.photos.request();
    }
    return status.isGranted;
  }

  Future<bool> _requestVideoPermission() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      status = await Permission.photos.request();
    }
    return status.isGranted;
  }

  Stream<List<types.Message>> _messagesStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data()!.containsKey('messages')) {
        final messagesData = snapshot['messages'] as List<dynamic>;
        final messages = messagesData.map((messageData) {
          final messageMap = Map<String, dynamic>.from(messageData);
          return types.Message.fromJson(messageMap);
        }).toList();
        return messages.reversed.toList();
      }
      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: _guideProfileImageUrl.isNotEmpty
                  ? NetworkImage(_guideProfileImageUrl)
                  : const AssetImage('assets/default_profile_image.jpg')
                      as ImageProvider,
              radius: 20,
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: () {
                if (_guideUserRole == "Guide") {
                  // Navigate to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuideDetailPage(
                        userId: widget.guideData['id'],
                      ),
                    ),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.guideData['username']}'),
                  Text(
                    'LOCALIZE ${_guideUserRole.toUpperCase()}',
                    style: const TextStyle(
                        fontSize: 12, color: Color.fromARGB(137, 22, 1, 1)),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<List<types.Message>>(
        stream: _messagesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No messages'));
          }

          return chat_ui.Chat(
            messages: snapshot.data!,
            onSendPressed: (partialTextMessage) {
              final textMessage = types.TextMessage(
                author: _currentUser,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                text: partialTextMessage.text,
              );

              _addMessage(textMessage);
            },
            user: _currentUser,
            onAttachmentPressed: _handleAttachmentPressed,
          );
        },
      ),
    );
  }
}