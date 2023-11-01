import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/routes_manager.dart';
import 'package:library_app/core/widgets/popup/custom_dialog.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/request/choice_answer.dart';
import 'package:library_app/features/student_features/quiz/presentation/bloc/answering_quiz_bloc/answering_quiz_bloc.dart';
import 'package:library_app/features/student_features/quiz/presentation/bloc/get_all_questions_cubit/get_all_questions_cubit.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import 'quiz_option.dart';

class QuestionCard extends StatefulWidget {
  final String assignmentId;
  const QuestionCard({
    Key? key,
    required this.assignmentId,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  ChoiceAnswer? questionChoice;
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return BlocBuilder<GetAllQuestionsCubit, GetAllQuestionsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(AppPadding.p24),
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.s32),
                topRight: Radius.circular(AppSize.s32),
              )),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: state.questions.length,
                  itemBuilder: (context, index) => Center(
                      child: Column(
                    children: [
                      Text(
                        state.questions[index].englishName,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: ColorManager.black,
                            ),
                      ),
                      const SizedBox(height: AppSize.s16),
                      ...List.generate(
                          state.questions[index].questionChoices.length,
                          (number) => OptionWidget(
                                questionID:
                                    questionChoice?.questionChoiceId ?? "",
                                index: number,
                                questionChoice: state
                                    .questions[index].questionChoices[number],
                                press: () {
                                  questionChoice = ChoiceAnswer(
                                    questionId: state.questions[index].id,
                                    questionChoiceId: state
                                        .questions[index]
                                        .questionChoices[number]
                                        .questionChoiceId,
                                  );

                                  setState(() {});
                                },
                              )),
                      BlocConsumer<AnsweringQuizBloc, AnsweringQuizState>(
                        listener: (context, answer) {
                          if (answer.requestStatus == RequestStatus.success) {
                            showCustomDialog(context,
                                haveCancelBtn: false,
                                description: answer.successMessage,
                                title: 'welcome', btnOkOnPressed: () {
                              CustomNavigator.push(Routes.mainRoute,
                                  replace: true, clean: true);
                            }, btnCancelOnPressed: () {});
                          }
                        },
                        builder: (context, answer) {
                          return CustomRoundedButton(
                            text: localize("next"),
                            requestStatus: answer.requestStatus,
                            onPressed: () {
                              BlocProvider.of<AnsweringQuizBloc>(context).add(
                                AnswerQuestionEvent(
                                  choice: questionChoice!,
                                ),
                              );
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.ease);

                              if ((answer.currentQuestionNumber + 1) ==
                                  state.questions.length) {
                                BlocProvider.of<AnsweringQuizBloc>(context)
                                    .add(FinishQuizEvent(
                                  assignmentId: widget.assignmentId,
                                  bookId: state.questions.first.bookId,
                                  questionCategoryId:
                                      state.questions.first.questionCategory,
                                ));
                              }
                            },
                          );
                        },
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
