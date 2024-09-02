import 'package:flutter/material.dart';
import 'package:localize_sl/chat.dart';

Offset _fabPosition = const Offset(0, 140); // Initial position

class FloatingChatButton extends StatefulWidget {
  const FloatingChatButton({super.key});

  @override
  State<FloatingChatButton> createState() => _FloatingChatButtonState();
}

class _FloatingChatButtonState extends State<FloatingChatButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _fabPosition.dx,
      top: _fabPosition.dy,
      child: Material(
        elevation: 8.0, // Default shadow depth
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotPage()),
          ),
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
            onDragEnd: (details) {
              final screenWidth = MediaQuery.of(context).size.width;

              final newOffsetX = details.offset.dx < screenWidth / 2
                  ? 0.0
                  : screenWidth - 56.0; // 56.0 is the image's width

              setState(() {
                _fabPosition = Offset(newOffsetX, details.offset.dy);
              });
            },
            childWhenDragging: Container(), // Empty container when dragging
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
        ),
      ),
    );
  }
}
