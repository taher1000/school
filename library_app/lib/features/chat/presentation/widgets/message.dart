import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data/models/ChatMessage.dart';
import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    Widget messageContent(
      ChatMessage message,
      bool sentByMe,
    ) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(
            message: message,
            sentByMe: sentByMe,
          );
        case ChatMessageType.audio:
          return AudioMessage(
            message: message,
            sentByMe: sentByMe,
          );
        case ChatMessageType.video:
          return VideoMessage(message: message);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s20),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            const CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            const SizedBox(
              width: AppSize.s20 / 2,
            )
          ],
          messageContent(message, message.isSender),
          if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return ColorManager.error;
        case MessageStatus.not_view:
          return Colors.grey;
        case MessageStatus.viewed:
          return ColorManager.darkPrimary;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: AppSize.s10),
      height: 15,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 11,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
