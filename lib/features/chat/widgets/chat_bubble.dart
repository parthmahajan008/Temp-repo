import 'package:creator_connect/features/chat/services/chat_repository.dart';
import 'package:flutter/material.dart';
import '../../../constants/globalvariables.dart';

class ChatBubble extends StatelessWidget {
  final String userId;
  const ChatBubble({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final sentByMe = chatRepository.auth.currentUser!.uid == userId;

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sentByMe ? Colors.black : GlobalVariables.greyBackgroundCOlor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          "Hi! how are you?",
          style: TextStyle(
              fontSize: 18, color: sentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
