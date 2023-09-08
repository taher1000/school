import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s20, vertical: AppSize.s10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: Colors.black,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.mic),
          const SizedBox(width: AppSize.s20),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.s20 * 0.75),
              decoration: BoxDecoration(
                color: ColorManager.darkGreyText.withOpacity(0.4),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: ColorManager.black,
                  ),
                  const SizedBox(width: AppSize.s10),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: ColorManager.greyDark),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type Message...'),
                    ),
                  ),
                  Icon(
                    Icons.attach_file,
                    color: ColorManager.black,
                  ),
                  const SizedBox(width: AppSize.s5),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: ColorManager.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
