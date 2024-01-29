/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=a748246508b1af2fd6007b0f0c05d31b

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

const profile = 'https://avatars.githubusercontent.com/u/82999715?v=4';
const chatGpt =
    'https://cdn.oaistatic.com/_next/static/media/favicon-32x32.be48395e.png';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF10A37F)),
        useMaterial3: true,
      ),
      home: const MyChatGPT(),
    );
  }
}

class MyChatGPT extends StatefulWidget {
  const MyChatGPT({super.key});

  @override
  State<MyChatGPT> createState() => _MyChatGPTState();
}

class _MyChatGPTState extends State<MyChatGPT> {
  List<ChatMessage> messages = [];
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    messages = [ChatMessage(content: 'Hello, how can I help you?')];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'MyChatGPT',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                text: '3.5',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: messages.map(buildChatMessage).toList()),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Message',
                filled: true,
                iconColor: Color(0xFF49454E),
                fillColor: Color(0xFFE7E2E9),
                suffixIcon: Icon(Icons.keyboard_voice),
                suffixIconConstraints: BoxConstraints(minWidth: 50),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
              ),
              onFieldSubmitted: (value) {
                messages.add(
                  ChatMessage(
                    isMine: true,
                    name: 'AndrewDongminYoo',
                    content: value,
                  ),
                );
                messages.add(ChatMessage());
                controller.clear();
                focusNode.requestFocus();
                setState(() {});
              },
            ),
          ),
          Container(
            width: 258,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              'ChatGPT can make mistakes. Consider checking important information.',
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChatMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: message.isMine
                ? const NetworkImage(profile)
                : const NetworkImage(chatGpt),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.name),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 90,
                child: Text(
                  message.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  ChatMessage({
    this.isMine = false,
    this.name = 'My GPT',
    this.content =
        "Actually, I don't have any features, but one day I'll grow up and become ChatGPT!",
  });

  bool isMine;
  String name;
  String content;
}
