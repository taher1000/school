import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data/models/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  final bool sentByMe;

  const TextMessage({
    Key? key,
    required this.message,
    required this.sentByMe,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s20 * 0.75, vertical: AppSize.s20 / 2),
      decoration: BoxDecoration(
          borderRadius: sentByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          gradient: sentByMe
              ? LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: const [-.5, 1],
                  colors: [
                    ColorManager.primary,
                    ColorManager.darkPrimary,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [-.5, 1],
                  colors: [
                    ColorManager.primary,
                    ColorManager.darkPrimary,
                  ],
                )),
      // color: sentByMe ? colorman : Colors.grey[700]),
      child: Text(
        message.text,
        style: TextStyle(
            color: message.isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1?.color),
      ),
    );
  }
}
