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
  final _lastResponse = ValueNotifier<OpenAIChatCompletionChoiceMessageModel?>(null);
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    _textController = TextEditingController();
    _scrollController = ScrollController();
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
    super.dispose();
  }

  OpenAIChatCompletionChoiceMessageModel _choiceModelFromText(String text, OpenAIChatMessageRole role) {
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
    _textController.clear();
    setState(() {
      _stream = OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: _chatMessages,
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
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        }
      },
      onDone: () {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _chatMessages.length + 1,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (index == _chatMessages.length) {
                      if (_stream != null) {
                        return ValueListenableBuilder<OpenAIChatCompletionChoiceMessageModel?>(
                          valueListenable: _lastResponse,
                          builder: (context, value, _) {
                            if (value == null) {
                              return BubbleNormal(
                                leading: const CircularProgressIndicator(),
                                text: '',
                                color: const Color(0xFFE8E8EE),
                                tail: false,
                                isSender: false,
                              );
                            }
                            final messageText = value.content!.first.text!;
                            return BubbleSpecialOne(
                              text: messageText,
                              color: const Color(0xFFE8E8EE),
                              isSender: false,
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
                      OpenAIChatMessageRole.user => BubbleSpecialThree(
                        text: message.content!.first.text!,
                        color: const Color(0xFF1B97F3),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                      OpenAIChatMessageRole.assistant => BubbleSpecialOne(
                        text: message.content!.first.text!,
                        color: const Color(0xFFE8E8EE),
                        isSender: false,
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
                        child: TextField(
                          controller: _textController,
                          readOnly: _isLoading,
                          decoration: const InputDecoration(
                            hintText: 'What are the best experiences nearby me?',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          onSubmitted: (_) => _onSubmitted(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
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
}
