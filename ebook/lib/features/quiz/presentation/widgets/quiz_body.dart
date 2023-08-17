import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data/models/Questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'quiz_progress_bar.dart';
import 'quiz_question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access question controller
    final PageController _pageController = PageController();
    return Stack(
      children: [
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(),
              const SizedBox(height: AppSize.s32),
              Text.rich(TextSpan(
                  text: "Question",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: ColorManager.white),
                  children: [
                    TextSpan(
                        text: " 1/4",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: ColorManager.white))
                  ])),
              const SizedBox(height: AppSize.s16),
              Divider(
                thickness: 1,
                color: ColorManager.white,
              ),
              const SizedBox(height: AppSize.s16),
              Expanded(
                  child: PageView.builder(
                      // Block swipe
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: 4,
                      itemBuilder: (context, index) => QuestionCard(
                            question: Question(
                                id: sample_data[index]["id"],
                                question: sample_data[index]["question"],
                                answer: sample_data[index]["answer_index"],
                                options: sample_data[index]["options"]),
                          ))),
            ],
          ),
        ))
      ],
    );
  }
}
