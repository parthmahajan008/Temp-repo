import 'package:creator_connect/constants/globalvariables.dart';
import 'package:flutter/material.dart';

import '../services/bloc/chat_bloc.dart';

class BottomTextField extends StatefulWidget {
  final String receiverUserId;
  const BottomTextField({super.key, required this.receiverUserId});

  @override
  State<BottomTextField> createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField> {
  final chatBloc = ChatBloc();
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void addMessage() {
    if (_textController.text == "") return;

    chatBloc.add(AddMessage(
      receiverUserId: widget.receiverUserId,
      message: _textController.text,
    ));
    setState(() => _textController.text = "");
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: Scrollbar(
              child: TextFormField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: "Type a message",
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  isDense: true,
                  fillColor: GlobalVariables.greyBackgroundCOlor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.black,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.send),
            color: Colors.white,
            onPressed: addMessage,
          ),
        ),
      ],
    );
  }
}
