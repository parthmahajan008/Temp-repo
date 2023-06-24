import 'package:creator_connect/constants/globalvariables.dart';
import 'package:creator_connect/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';

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
    final chats = ["HI", "YO"] + ["HI", "YO"] + ["HI", "YO"] + ["HI", "YO"];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(color: GlobalVariables.secondaryTextColor),
        ),
        centerTitle: true,
        backgroundColor: GlobalVariables.backgroundColor,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listenWhen: (previous, current) => current is ChatActionState,
        buildWhen: (previous, current) => current is! ChatActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatListLoadingState:
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.black,
                ),
              );
            case ChatListLoadedState:
              return ChatList(chats: chats);
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
