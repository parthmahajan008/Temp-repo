import 'package:creator_connect/features/chat/widgets/chat_list_tile.dart';
import 'package:creator_connect/models/chat.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return chats.isEmpty
        ? const Center(
            child: Text("No messages yet"),
          )
        : ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) => ChatListTile(
              chat: chats[index],
            ),
          );
  }
}
