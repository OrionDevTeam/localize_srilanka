import 'dart:io';
import 'dart:typed_data';

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
  final _otherUser = types.User(
    id: '',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
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
        author: _otherUser,
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

  void _loadMessages() {
    // Simulating loading messages from a database or other source
    setState(() {
      // Replace with your actual messages loading logic
      _messages = [
        types.TextMessage(
          author: _otherUser,
          createdAt: DateTime.now().millisecondsSinceEpoch - 100000,
          id: '1',
          text: 'Hello!',
        ),
        types.TextMessage(
          author: _otherUser,
          createdAt: DateTime.now().millisecondsSinceEpoch - 200000,
          id: '2',
          text: 'How are you?',
        ),
      ];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.guideData['user_name']}'),
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
          // Handle tap on the message here
          print('Message tapped: ${message.id}');
        },
        onSendPressed: (message) {
          if (message is types.PartialText) {
            final textMessage = types.TextMessage(
              author: _otherUser,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              text: message.text,
            );
            _addMessage(textMessage);
          }
        },
        user: _otherUser,
      ),
    );
  }
}
