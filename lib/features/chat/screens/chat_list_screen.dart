import 'package:creator_connect/constants/globalvariables.dart';
import 'package:creator_connect/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/chat.dart';
import '../services/bloc/chat_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatBloc chatBloc = ChatBloc();

  @override
  void initState() {
    chatBloc.add(LoadChatList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(color: GlobalVariables.secondaryTextColor),
        ),
        centerTitle: true,
        backgroundColor: GlobalVariables.backgroundColor,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        bloc: chatBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatListLoadedState:
              var chatState = state as ChatListLoadedState;
              return StreamBuilder<List<Chat>>(
                  stream: chatState.chatListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ChatList(chats: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.black,
                        ),
                      );
                    }
                  });
            case ChatListErrorState:
              return const Center(
                child: Text("Error Occured"),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
