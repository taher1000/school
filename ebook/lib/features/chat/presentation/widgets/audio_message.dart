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
        horizontal: AppSize.s16,
        vertical: AppSize.s10,
      ),
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
        color: ColorManager.darkGrey.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Icon(Icons.play_arrow,
              color:
                  message.isSender ? Colors.white : ColorManager.darkPrimary),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
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
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black))
        ],
      ),
    );
  }
}
