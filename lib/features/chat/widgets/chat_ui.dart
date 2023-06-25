import '../../../models/message.dart';
import 'package:flutter/material.dart';

import 'chat_bubble.dart';

class ChatUI extends StatelessWidget {
  final List<Message> messages;
  const ChatUI({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) => ChatBubble(
            userId: messages[index].senderId,
            text: messages[index].text,
          ),
        ),
      ),
    );
  }
}
