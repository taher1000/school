import 'package:library_app/core/widgets/popup/custom_dialog.dart';
import 'package:library_app/features/student_features/quiz/data/enums/quiz_type_enum.dart';

import '../../../../../core/entities/assignment/student_assignment.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../books/presentation/widgets/circle_choice.dart';

class AssignmentCircleChoicesList extends StatelessWidget {
  final StudentAssignment assignment;
  const AssignmentCircleChoicesList({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleChoice(
                title: "${localize('level')} ${localize('general')}",
                icon: assignment.hasGeneralLevelPass
                    ? FontAwesomeIcons.circleCheck
                    : FontAwesomeIcons.circleQuestion,
                iconColor:
                    assignment.hasGeneralLevelPass ? ColorManager.green : null,
                onTap: assignment.hasGeneralLevelPass
                    ? null
                    : () {
                        showQuizDialog(QuizTypeEnum.general, context);
                      },
              ),
              if (assignment.showAdvanceQuestion)
                CircleChoice(
                  title: "${localize('level')} ${localize('deductive')}",
                  icon: assignment.hasDeductiveLevelPass
                      ? FontAwesomeIcons.circleCheck
                      : FontAwesomeIcons.circleQuestion,
                  iconColor: assignment.hasDeductiveLevelPass
                      ? ColorManager.green
                      : null,
                  onTap: assignment.hasDeductiveLevelPass
                      ? null
                      : () {
                          showQuizDialog(QuizTypeEnum.deductive, context);
                        },
                ),
              if (assignment.showAdvanceQuestion)
                CircleChoice(
                  title: "${localize('level')} ${localize('evaluative')}",
                  icon: assignment.hasEvaluativeLevelPass
                      ? FontAwesomeIcons.circleCheck
                      : FontAwesomeIcons.circleQuestion,
                  iconColor: assignment.hasEvaluativeLevelPass
                      ? ColorManager.green
                      : null,
                  onTap: assignment.hasEvaluativeLevelPass
                      ? null
                      : () {
                          showQuizDialog(QuizTypeEnum.evaluative, context);
                        },
                ),
              if (assignment.hasListening)
                CircleChoice(
                  title: localize("listening"),
                  icon: FontAwesomeIcons.headphones,
                  onTap: () {},
                ),
              if (assignment.hasReading)
                CircleChoice(
                  title: localize("reading"),
                  iconColor: assignment.hasReading ? ColorManager.green : null,
                  icon: FontAwesomeIcons.bookOpen,
                  onTap: () {
                    CustomNavigator.push(
                      Routes.readerRoute,
                      // replace: true,
                      arguments: {
                        "bookId": assignment.id,
                        "pagesCount": assignment.pageCount,
                      },
                    );
                  },
                ),
            ],
          ),
        ));
  }

  void showQuizDialog(QuizTypeEnum quizType, BuildContext context) {
    showCustomDialog(
      context,
      btnOkOnPressed: () {
        CustomNavigator.push(
          Routes.quizRoute,
          arguments: {
            "bookId": assignment.id,
            "assignmentId": assignment.assignmentId,
            "quizType": quizType,
          },
        );
      },
      btnCancelOnPressed: () {
        Navigator.pop(context);
      },
      description: "exam_desc",
      title: "exam",
    );
  }
}
