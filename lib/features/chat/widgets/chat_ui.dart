import '../../../models/message.dart';
import 'package:flutter/material.dart';

import 'chat_bubble.dart';

class ChatUI extends StatefulWidget {
  final List<Message> messages;
  const ChatUI({super.key, required this.messages});

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  final ScrollController _scrollController = ScrollController();
  void _scrollDown() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollDown,
        backgroundColor: const Color.fromARGB(190, 255, 255, 255),
        child: const Icon(
          size: 24,
          Icons.arrow_downward,
          color: Colors.black,
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.messages.length,
            itemBuilder: (context, index) => ChatBubble(
              userId: widget.messages[index].senderId,
              text: widget.messages[index].text,
            ),
          ),
        ),
      ),
    );
  }
}
