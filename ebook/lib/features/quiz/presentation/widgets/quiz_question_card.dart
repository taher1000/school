import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/values_manager.dart';
import '../../data/models/Questions.dart';
import 'quiz_option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s32)),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.black,
                ),
          ),
          const SizedBox(height: AppSize.s16),
          ...List.generate(
              question.options.length,
              (index) => Option(
                    index: index,
                    text: question.options[index],
                    press: () {},
                  ))
        ],
      ),
    );
  }
}
