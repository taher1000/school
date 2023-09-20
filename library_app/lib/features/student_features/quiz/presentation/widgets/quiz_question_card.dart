import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:library_app/core/resources/routes_manager.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/question_choice.dart';
import 'package:library_app/features/student_features/quiz/presentation/bloc/question_bloc/question_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../data/models/question_choice.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/request/question_answer.dart';
import 'quiz_option.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;
  final Question question;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  QuestionChoice? questionChoice;
  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (state is FinishQuizSuccessState) {
          context.loaderOverlay.hide();
          CustomNavigator.push(Routes.afterQuizResultRoute,
              replace: false,
              arguments: {
                "bookId": widget.question.bookId,
              });
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.message),
          //   ),
          // );
        } else if (state is FinishQuizLoadingState) {
          context.loaderOverlay.show();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p24),
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s32),
              topRight: Radius.circular(AppSize.s32),
            )),
        child: Column(
          children: [
            Text(
              widget.question.englishName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorManager.black,
                  ),
            ),
            const SizedBox(height: AppSize.s16),
            ...List.generate(
                widget.question.questionChoices.length,
                (index) => OptionWidget(
                      index: index,
                      questionID: questionChoice?.questionChoiceId ?? "",
                      questionChoice: widget.question.questionChoices[index],
                      press: () {
                        setState(() {
                          questionChoice =
                              widget.question.questionChoices[index];
                        });
                      },
                    )),
            const Spacer(),
            BlocBuilder<QuestionBloc, QuestionState>(
              builder: (context, state) {
                return CustomRoundedButton(
                    text: localize("next"),
                    onPressed: () {
                      setState(() {
                        isConfirmed = true;
                      });
                      if (isConfirmed) {
                        BlocProvider.of<QuestionBloc>(context).add(
                          AddQuestionAnswerEvent(
                            questionAnswer: QuestionAnswer(
                              questionId: widget.question.id,
                              questionChoiceId:
                                  questionChoice!.questionChoiceId,
                            ),
                          ),
                        );
                      }

                      if (state.questionNumber == 10) {
                        if (isConfirmed) {
                          BlocProvider.of<QuestionBloc>(context)
                              .add(const FinishQuizEvent());
                        }
                      }
                      setState(() {
                        isConfirmed = false;
                      });
                      widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease);
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
