import 'package:creator_connect/constants/globalvariables.dart';
import 'package:flutter/material.dart';

import '../../../models/chat.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "/chat-screen";
  const ChatScreen({super.key});

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
            const SizedBox(width: 10,),
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
    );
  }
}
