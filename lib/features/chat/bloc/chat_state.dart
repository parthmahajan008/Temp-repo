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

class ChatListLoadedState extends ChatState {}

class ChatListErrorState extends ChatState {}