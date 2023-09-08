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
          horizontal: AppSize.s16, vertical: AppSize.s10),
      decoration: BoxDecoration(
          borderRadius: sentByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s20),
                  topRight: Radius.circular(AppSize.s20),
                  bottomLeft: Radius.circular(AppSize.s20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s20),
                  topRight: Radius.circular(AppSize.s20),
                  bottomRight: Radius.circular(AppSize.s20),
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
      child: Text(
        message.text,
      ),
    );
  }
}
