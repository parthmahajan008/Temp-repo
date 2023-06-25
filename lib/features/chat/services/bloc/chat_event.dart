part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatList extends ChatEvent {}

class AddMessage extends ChatEvent {
  final String receiverUserId;
  final String message;

  const AddMessage({
    required this.message,
    required this.receiverUserId,
  });
}

class LoadMessages extends ChatEvent {
  final String userId;
  
  const LoadMessages({required this.userId});
}