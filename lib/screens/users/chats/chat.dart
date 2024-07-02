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
  List<types.Message> _messages = [];
  late types.User _currentUser;
  late types.User _otherUser;

  @override
  void initState() {
    super.initState();
    _initializeUsers();
    _loadMessages();
  }

  void _initializeUsers() {
    _currentUser = types.User(
      id: FirebaseAuth.instance.currentUser!.uid,
    );

    // Add null and type checks for guideData['id']
    final guideId = widget.guideData['id'];
    if (guideId != null && guideId is String) {
      _otherUser = types.User(
        id: guideId,
      );
    } else {
      // Handle the case where guideData['id'] is null or not a string
      // For example, assign a default ID or handle gracefully
      _otherUser = types.User(
        id: 'default_user_id', // Replace with a default value or handle accordingly
      );
    }
  }

  void _addMessage(types.Message message) async {
    setState(() {
      _messages.insert(0, message);
    });

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .update({
      'messages': FieldValue.arrayUnion([message.toJson()])
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
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
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

  void _loadMessages() async {
    final chatDoc = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get();

    if (chatDoc.exists && chatDoc.data()!.containsKey('messages')) {
      final messagesData = chatDoc['messages'] as List<dynamic>;
      final messages = messagesData.map((messageData) {
        final messageMap = Map<String, dynamic>.from(messageData);
        return types.Message.fromJson(messageMap);
      }).toList();

      setState(() {
        _messages = messages.reversed.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.guideData['username']}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: chat_ui.Chat(
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
      ),
    );
  }
}

extension on types.Message {
  Map<String, dynamic> toJson() {
    if (this is types.TextMessage) {
      final textMessage = this as types.TextMessage;
      return {
        'id': textMessage.id,
        'author': {
          'id': textMessage.author.id,
        },
        'createdAt': textMessage.createdAt,
        'text': textMessage.text,
        'type': 'text',
      };
    } else if (this is types.ImageMessage) {
      final imageMessage = this as types.ImageMessage;
      return {
        'id': imageMessage.id,
        'author': {
          'id': imageMessage.author.id,
        },
        'createdAt': imageMessage.createdAt,
        'name': imageMessage.name,
        'size': imageMessage.size,
        'uri': imageMessage.uri,
        'height': imageMessage.height,
        'width': imageMessage.width,
        'type': 'image',
      };
    }
    return {};
  }

  static types.Message fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'text') {
      return types.TextMessage(
        id: json['id'],
        author: types.User(id: json['author']['id']),
        createdAt: json['createdAt'],
        text: json['text'],
      );
    } else if (json['type'] == 'image') {
      return types.ImageMessage(
        id: json['id'],
        author: types.User(id: json['author']['id']),
        createdAt: json['createdAt'],
        name: json['name'],
        size: json['size'],
        uri: json['uri'],
        height: json['height'],
        width: json['width'],
      );
    }
    throw UnsupportedError('Unsupported message type');
  }
}
