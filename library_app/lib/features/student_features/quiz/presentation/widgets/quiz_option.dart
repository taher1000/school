import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/question_choice.dart';
import '../bloc/question_bloc/question_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/values_manager.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget(
      {Key? key,
      required this.questionChoice,
      required this.index,
      required this.press,
      required this.questionID})
      : super(key: key);
  final String questionID;
  final QuestionChoice questionChoice;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        return InkWell(
          onTap: press,
          child: Container(
            margin: const EdgeInsets.only(top: AppPadding.p16),
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              color: questionChoice.questionChoiceId == questionID
                  ? ColorManager.green
                  : Colors.transparent,
              border: Border.all(color: ColorManager.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}. ${questionChoice.text}",
                  style: TextStyle(color: ColorManager.darkGrey, fontSize: 16),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: questionChoice.questionChoiceId == questionID
                          ? ColorManager.white
                          : Colors.transparent,
                      border: Border.all(color: ColorManager.grey),
                      borderRadius: BorderRadius.circular(50)),
                  child: questionChoice.questionChoiceId == questionID
                      ? Icon(
                          Icons.check,
                          color: ColorManager.green,
                          size: 16,
                        )
                      : null,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
