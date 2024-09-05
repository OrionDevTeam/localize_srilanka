import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:localize_sl/secrets.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<OpenAIChatCompletionChoiceMessageModel> _chatMessages = [];
  Stream<OpenAIStreamChatCompletionModel>? _stream;
  final _lastResponse =
      ValueNotifier<OpenAIChatCompletionChoiceMessageModel?>(null);
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _chatMessages.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            systemPrompt,
          ),
        ],
        role: OpenAIChatMessageRole.system,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  OpenAIChatCompletionChoiceMessageModel _choiceModelFromText(
      String text, OpenAIChatMessageRole role) {
    return OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(text),
      ],
      role: role,
    );
  }

  void _onSubmitted() async {
    final text = _textController.text;
    if (text.isEmpty || _isLoading) {
      return;
    }
    setState(() {
      if (_lastResponse.value != null) {
        _chatMessages.add(_lastResponse.value!);
      }
      _lastResponse.value = null;
      _stream = null;
      _chatMessages.add(_choiceModelFromText(text, OpenAIChatMessageRole.user));
      _isLoading = true;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    _textController.clear();
    setState(() {
      _stream = OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: _chatMessages,
        maxTokens: 500,
      );
      _stream!.listen((data) {
        if (data.choices.first.delta.content != null) {
          if (_lastResponse.value == null) {
            _lastResponse.value = _choiceModelFromText(
              data.choices.first.delta.content!.first!.text!,
              OpenAIChatMessageRole.assistant,
            );
          } else {
            final message = _lastResponse.value!.content!.first.text! +
                data.choices.first.delta.content!.first!.text!;
            _lastResponse.value = _choiceModelFromText(
              message,
              OpenAIChatMessageRole.assistant,
            );
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          }
        }
      }, onDone: () {
        setState(() {
          _isLoading = false;
        });
        _focusNode.requestFocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Vidara'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Expanded(
                child: _chatMessages.length == 1
                    ? _conversationStartSection()
                    : ListView.separated(
                        controller: _scrollController,
                        itemCount: _chatMessages.length + 1,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (index == _chatMessages.length) {
                            if (_stream != null) {
                              return ValueListenableBuilder<
                                  OpenAIChatCompletionChoiceMessageModel?>(
                                valueListenable: _lastResponse,
                                builder: (context, value, _) {
                                  if (value == null) {
                                    return BubbleNormal(
                                      leading:
                                          const CircularProgressIndicator(),
                                      text: '',
                                      color: const Color(0xFFE8E8EE),
                                      tail: false,
                                      isSender: false,
                                    );
                                  }
                                  final messageText =
                                      value.content!.first.text!;
                                  return _assistantChatBubble(
                                    messageText,
                                  );
                                },
                              );
                            } else if (_isLoading) {
                              return BubbleNormal(
                                leading: const CircularProgressIndicator(),
                                text: '',
                                color: const Color(0xFFE8E8EE),
                                tail: false,
                                isSender: false,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }
                          final message = _chatMessages[index];
                          return switch (message.role) {
                            OpenAIChatMessageRole.user => _userChatBubble(
                                message.content!.first.text!,
                              ),
                            OpenAIChatMessageRole.assistant =>
                              _assistantChatBubble(
                                message.content!.first.text!,
                              ),
                            _ => const SizedBox()
                          };
                        },
                      ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set input field background to white
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Colors.green), // Adjust border color
                          ),
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            autofocus: true,
                            readOnly: _isLoading,
                            decoration: const InputDecoration(
                              hintText: 'Ask me anything!',
                              border: InputBorder.none, // Remove default border
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                            ),
                            onSubmitted: (_) => _onSubmitted(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                              0xFF2A966C), // Set send button color to green
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.white,
                          onPressed: _isLoading ? null : _onSubmitted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _assistantChatBubble(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFE8E8EE),
          child: Icon(
            Icons.support_agent,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: BubbleSpecialOne(
            text: text,
            color: const Color(0xFFE8E8EE),
            isSender: false,
          ),
        ),
      ],
    );
  }

  Widget _userChatBubble(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: BubbleSpecialThree(
            text: text,
            color: const Color(0xFF2A966C),
            textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        const CircleAvatar(
          backgroundColor: Color(0xFF2A966C),
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _conversationStartSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Chat with Vidara \nYour AI Travel Assistant!',
          style: TextStyle(
            color: Color(0xFF2A966C), // Text color set to green
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Ask me anything about your travel plans and I will help you out!',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _textController.text = 'What are the best experiences nearby me?';
            _onSubmitted();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: const Color(0xFF2A966C), // Button color set to green
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Sharper edges
            ),
          ),
          child: const Text(
            'What are the best experiences nearby me?',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Text color set to white
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _textController.text =
                'I need to vlog my trip, how can I get help?';
            _onSubmitted();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: const Color(0xFF2A966C), // Button color set to green
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Sharper edges
            ),
          ),
          child: const Text(
            'I need to vlog my trip, how can I get help?',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Text color set to white
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _textController.text =
                'Help me find the best place to visit nearby and have a nice meal.';
            _onSubmitted();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: const Color(0xFF2A966C), // Button color set to green
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Sharper edges
            ),
          ),
          child: const Text(
            'Help me find the best place to visit nearby and have a nice meal.',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Text color set to white
            ),
          ),
        ),
      ],
    );
  }
}
