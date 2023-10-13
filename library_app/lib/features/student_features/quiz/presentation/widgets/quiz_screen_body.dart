import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/features/student_features/quiz/presentation/bloc/get_all_questions_cubit/get_all_questions_cubit.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'quiz_progress_bar.dart';
import 'quiz_question_card.dart';

class QuizScreenBody extends StatelessWidget {
  final String assignmentId;
  const QuizScreenBody({
    Key? key,
    required this.assignmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
          child: const ProgressBar(),
        ),
        SizedBox(height: AppPadding.p16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
          child: Text.rich(
            TextSpan(
              text: "Question",
              // ${q.currentQuestionNumber + 1}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: ColorManager.white),
              children: [
                TextSpan(
                  text:
                      "/${context.watch<GetAllQuestionsCubit>().state.questions.length}",
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 1.5, color: ColorManager.white),
        SizedBox(height: AppPadding.p16.h),
        SizedBox(
          // width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: QuestionCard(assignmentId: assignmentId),
        ),
      ],
    );
  }
}
