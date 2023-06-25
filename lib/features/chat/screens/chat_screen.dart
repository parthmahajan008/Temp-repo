import 'package:creator_connect/constants/globalvariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/chat.dart';
import '../../../models/message.dart';
import '../services/bloc/chat_bloc.dart';
import '../widgets/bottom_text_field.dart';
import '../widgets/chat_ui.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/chat-screen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatBloc chatBloc = ChatBloc();

  @override
  void didChangeDependencies() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Chat chat = arguments["chat"];
    chatBloc.add(LoadMessages(userId: chat.userId));
    super.didChangeDependencies();
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                  bloc: chatBloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case MessagesLoadedState:
                        var messagesState = state as MessagesLoadedState;
                        return StreamBuilder<List<Message>>(
                            stream: messagesState.messages,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ChatUI(messages: snapshot.data!);
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.black,
                                  ),
                                );
                              }
                            });
                      case MessagesLoadingErrorState:
                        return const Center(
                          child: Text("Error Occured"),
                        );
                      default:
                        return const SizedBox();
                    }
                  })
              ),
          BottomTextField(receiverUserId: chat.userId)
        ],
      ),
    );
  }
}
