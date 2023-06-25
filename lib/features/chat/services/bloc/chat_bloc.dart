import 'dart:async';
import 'package:creator_connect/features/chat/services/chat_repository.dart';
import 'package:creator_connect/models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/chat.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatList>(loadChatList);
    on<AddMessage>(addMessage);
    on<LoadMessages>(loadMessages);
  }

  FutureOr<void> loadChatList(
      LoadChatList event, Emitter<ChatState> emit) async {
    try {
      Stream<List<Chat>> chatListStream = chatRepository.getChats();
      emit(ChatListLoadedState(chatListStream: chatListStream));
    } catch (e) {
      emit(ChatListErrorState());
      throw Exception(e);
    }
  }

  FutureOr<void> addMessage(AddMessage event, Emitter<ChatState> emit) {
    try {
      String message = event.message;
      chatRepository.addMessage(
        receiverUserId: event.receiverUserId,
        message: message,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> loadMessages(LoadMessages event, Emitter<ChatState> emit) {
    try {
      Stream<List<Message>> messages =
          chatRepository.getMessages(userId: event.userId);
      emit(MessagesLoadedState(messages: messages));
    } catch (e) {
      emit(MessagesLoadingErrorState());
      throw Exception(e);
    }
  }
}
