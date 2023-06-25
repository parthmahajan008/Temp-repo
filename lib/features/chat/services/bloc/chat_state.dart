part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

abstract class ChatActionState extends Equatable {
  const ChatActionState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatListLoadingState extends ChatState {}

class ChatListLoadedState extends ChatState {
  final Stream<List<Chat>> chatListStream;

  const ChatListLoadedState({required this.chatListStream});

  @override
  List<Object> get props => [chatListStream];
}

class ChatListErrorState extends ChatState {}

class MessagesLoadedState extends ChatState {
  final Stream<List<Message>> messages;

  const MessagesLoadedState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessagesLoadingErrorState extends ChatState {}