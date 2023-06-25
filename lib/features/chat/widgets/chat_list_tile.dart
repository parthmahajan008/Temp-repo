import 'package:creator_connect/features/chat/screens/chat_screen.dart';
import 'package:creator_connect/features/chat/services/chat_repository.dart';
import 'package:flutter/material.dart';

import '../../../models/chat.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;
  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          chat.imageUrl,
        ),
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        (chat.sentById == chatRepository.auth.currentUser!.uid
                ? "You : "
                : chat.name) +
            chat.lastMessage,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(ChatScreen.routeName, arguments: {"chat": chat});
      },
    );
  }
}
