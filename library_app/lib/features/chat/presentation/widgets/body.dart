import 'package:flutter/material.dart';

import '../../../../core/resources/values_manager.dart';
import '../../data/models/ChatMessage.dart';
import 'chat_input_fields.dart';
import 'message.dart';

class MessageScreenBody extends StatelessWidget {
  const MessageScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
          child: ListView.builder(
            itemCount: demeChatMessages.length,
            itemBuilder: (context, index) =>
                Message(message: demeChatMessages[index]),
          ),
        )),
        const ChatInputField()
      ],
    );
  }
}
