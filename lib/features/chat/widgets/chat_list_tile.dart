import 'package:creator_connect/features/chat/widgets/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final String chat;
  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          'https://c4.wallpaperflare.com/wallpaper/936/54/339/justin-bieber-pretty-picture-background-wallpaper-preview.jpg',
        ),
      ),
      title: const Text(
        "Justin Bieber",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        "Hey shawty ;)",
        style: TextStyle(fontSize: 16),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName);
      },
    );
  }
}
