import 'dart:async';
import 'package:creator_connect/features/chat/services/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/chat.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatList>(loadChatList);
  }

  FutureOr<void> loadChatList(LoadChatList event, Emitter<ChatState> emit) async {
    try {
    emit(ChatListLoadingState());
    List<Chat> chats = await ChatRepository.getChats();
    emit(ChatListLoadedState(chats: chats));
    } catch(e) {
      emit(ChatListErrorState());
      throw Exception(e.toString());
    }
  }
}
