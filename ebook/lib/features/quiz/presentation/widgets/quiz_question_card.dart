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
      // margin: EdgeInsets.symmetric(
      //     horizontal: AppPadding.p16, vertical: AppPadding.p16 * 2),
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: ColorManager.black),
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
