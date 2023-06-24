import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatList>(loadChatList);
  }

  FutureOr<void> loadChatList(LoadChatList event, Emitter<ChatState> emit) async {
    try {
    emit(ChatListLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(ChatListLoadedState());
    } catch(e) {
      emit(ChatListErrorState());
      throw Exception(e.toString());
    }
  }
}
