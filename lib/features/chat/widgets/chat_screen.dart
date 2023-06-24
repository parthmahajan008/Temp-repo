import 'package:creator_connect/constants/globalvariables.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "/chat-screen";
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Justin Bieber",
          style: TextStyle(
            color: GlobalVariables.secondaryTextColor,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
