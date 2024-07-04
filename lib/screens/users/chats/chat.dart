import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final Map<String, dynamic> guideData;

  const ChatPage({
    Key? key,
    required this.chatId,
    required this.guideData,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late types.User _currentUser;
  late types.User _otherUser;
  String _guideProfileImageUrl = '';
  String _guideUserRole = '';
  List<types.Message> _messages = [];

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
      _otherUser = types.User(
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
      final imageMessage = message as types.ImageMessage;
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
      final videoMessage = message as types.VideoMessage;
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
              leading: Icon(Icons.photo_library),
              title: Text('Photo'),
              onTap: () {
                Navigator.pop(context);
                _handleImageSelection(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Video'),
              onTap: () {
                Navigator.pop(context);
                _handleVideoSelection();
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleImageSelection(ImageSource source) async {
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
  }

  void _handleVideoSelection() async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      final videoFile = File(result.path!);

      final message = types.VideoMessage(
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: path.basename(result.path!),
        size: videoFile.lengthSync(),
        uri: result.path!,
      );

      _addMessage(message);
    }
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
                  : AssetImage('assets/default_profile_image.jpg')
                      as ImageProvider,
              radius: 20,
            ),
            SizedBox(width: 14),
            GestureDetector(
              onTap: () {
                if (_guideUserRole == "Guide") {
                  // Navigate to profile page
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => UserProfilePage(
                  //       userId: widget.guideData['id'],
                  //     ),
                  //   ),
                  // );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.guideData['username']}'),
                  Text(
                    'LOCALIZE ${_guideUserRole.toUpperCase()}',
                    style: TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(137, 22, 1, 1)),
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading messages'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages yet'));
          }

          _messages = snapshot.data!;

          return chat_ui.Chat(
            messages: _messages,
            onAttachmentPressed: _handleAttachmentPressed,
            onMessageTap: (context, message) {
              print('Message tapped: ${message.id}');
            },
            onSendPressed: (message) {
              if (message is types.PartialText) {
                final textMessage = types.TextMessage(
                  author: _currentUser,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  text: message.text,
                );
                _addMessage(textMessage);
              }
            },
            user: _currentUser,
          );
        },
      ),
    );
  }
}

extension on types.Message {
  Map<String, dynamic> toJson() {
    if (this is types.TextMessage) {
      return {
        'type': 'text',
        'author': (this as types.TextMessage).author.toJson(),
        'createdAt': (this as types.TextMessage).createdAt,
        'id': (this as types.TextMessage).id,
        'text': (this as types.TextMessage).text,
      };
    } else if (this is types.ImageMessage) {
      return {
        'type': 'image',
        'author': (this as types.ImageMessage).author.toJson(),
        'createdAt': (this as types.ImageMessage).createdAt,
        'id': (this as types.ImageMessage).id,
        'name': (this as types.ImageMessage).name,
        'size': (this as types.ImageMessage).size,
        'uri': (this as types.ImageMessage).uri,
        'height': (this as types.ImageMessage).height,
        'width': (this as types.ImageMessage).width,
      };
    } else if (this is types.VideoMessage) {
      return {
        'type': 'video',
        'author': (this as types.VideoMessage).author.toJson(),
        'createdAt': (this as types.VideoMessage).createdAt,
        'id': (this as types.VideoMessage).id,
        'name': (this as types.VideoMessage).name,
        'size': (this as types.VideoMessage).size,
        'uri': (this as types.VideoMessage).uri,
      };
    }
    return {};
  }
}

extension on types.User {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
