import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/values_manager.dart';
import '../../data/models/ChatMessage.dart';

class AudioMessage extends StatelessWidget {
  final bool sentByMe;

  const AudioMessage(
      {super.key, required this.message, required this.sentByMe});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s20 * 0.75,
        vertical: AppSize.s20 / 2.5,
      ),
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
        color: ColorManager.darkGrey.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Icon(Icons.play_arrow,
              color:
                  message.isSender ? Colors.white : ColorManager.darkPrimary),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s20 / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message.isSender
                        ? Colors.white
                        : ColorManager.darkPrimary.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message.isSender
                            ? Colors.white
                            : ColorManager.darkPrimary.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text('0.37',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
