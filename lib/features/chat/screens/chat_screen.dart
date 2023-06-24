import 'package:creator_connect/constants/globalvariables.dart';
import 'package:creator_connect/features/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import '../../../models/chat.dart';
import '../widgets/bottom_text_field.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/chat-screen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Chat chat = arguments["chat"];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                chat.imageUrl,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              chat.name,
              style: const TextStyle(
                color: GlobalVariables.secondaryTextColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                children: [
                  ChatBubble(userId: "1"),
                  ChatBubble(userId: "KQ8xN0Zwt8eeghy6UBD57G3ZuQ82"),
                  ChatBubble(userId: "1"),
                  ChatBubble(userId: "1"),
                  ChatBubble(userId: "KQ8xN0Zwt8eeghy6UBD57G3ZuQ82"),
                ],
              ),
            ),
            BottomTextField(receiverUserId: chat.userId)
          ],
        ),
      ),
    );
  }
}
