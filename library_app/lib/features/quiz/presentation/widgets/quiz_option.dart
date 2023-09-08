import '../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/values_manager.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key, required this.text, required this.index, required this.press})
      : super(key: key);

  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //  Color getRightColor() {
    //     final isCorrectAnwser = index == controller.correctAnswer;
    //     final isSelected = index == controller.selectedAnswer;
    //     final checkedAnswer = controller.selectedAnswer != controller.correctAnswer;
    //     final isNotCorrectAnswer = isSelected && checkedAnswer;

    //     if (controller.isAnswered) {
    //       if (isCorrectAnwser) return kGreenColor;
    //       if (isNotCorrectAnswer) return kRedColor;
    //     }

    //     return kGrayColor;
    //   }

    //   IconData getRightIcon() {
    //     return getRightColor() == kRedColor ? Icons.close : Icons.done;
    //   }

    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(top: AppPadding.p16),
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.grey),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index + 1}. $text",
              style: TextStyle(color: ColorManager.darkGrey, fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                  // color: ColorManager.darkGrey,
                  border: Border.all(color: ColorManager.grey),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                Icons.check,
                color: ColorManager.grey,
                size: 16,
              ),
              //  getRightIcon() == ColorManager.darkGrey
              //     ? null
              //     : Icon(
              //         getRightIcon(),
              //         size: 16,
              //       ),
            )
          ],
        ),
      ),
    );
  }
}
