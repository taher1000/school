import 'package:flutter/material.dart';

import '../../data/models/Chat.dart';
import '../pages/message_screen.dart';
import 'chat_card.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: ColorManager.green,
      child: ListView.builder(
        itemCount: chatsData.length,
        itemBuilder: ((context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MessagesScreen())),
            )),
      ),
    );
  }
}
