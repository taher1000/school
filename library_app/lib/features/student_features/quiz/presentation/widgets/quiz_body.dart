import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/widgets/buttons/rounded_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../data/models/question_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/question.dart';
import '../bloc/question_bloc/question_bloc.dart';
import '../bloc/quiz_bloc.dart';
import 'quiz_progress_bar.dart';
import 'quiz_question_card.dart';

class QuizScreenBody extends StatelessWidget {
  final String bookID;

  const QuizScreenBody({
    Key? key,
    required this.bookID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    BlocProvider.of<QuizBloc>(context).add(FetchQuestions(bookID: bookID));
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is GetQuizLoading) {
          context.loaderOverlay.show();
        }
        if (state is GetQuizError) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is GetQuizLoaded) {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        if (state is GetQuizLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
                child: const ProgressBar(),
              ),
              SizedBox(height: AppPadding.p16.h),
              BlocBuilder<QuestionBloc, QuestionState>(
                builder: (context, q) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
                    child: Text.rich(
                      TextSpan(
                        text: "Question ${q.questionNumber}",
                        children: [
                          TextSpan(
                            text: "/${state.questionsSummary.data.length}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Divider(thickness: 1.5, color: ColorManager.white),
              SizedBox(height: AppPadding.p16.h),
              SizedBox(
                // width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: state.questionsSummary.data.length,
                  itemBuilder: (context, index) => Center(
                    child: QuestionCard(
                      question: state.questionsSummary.data[index],
                      pageController: _pageController,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

//     // Access question controller
//     final PageController _pageController = PageController();
//     return Stack(
//       children: [
//         SafeArea(
//             child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: AppPadding.p16, vertical: AppPadding.p24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const ProgressBar(),
//               const SizedBox(height: AppSize.s32),
//               Text.rich(TextSpan(
//                   text: "Question",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline5!
//                       .copyWith(color: ColorManager.white),
//                   children: [
//                     TextSpan(
//                         text: " 1/4",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline5!
//                             .copyWith(color: ColorManager.white))
//                   ])),
//               const SizedBox(height: AppSize.s16),
//               Divider(
//                 thickness: 1,
//                 color: ColorManager.white,
//               ),
//               const SizedBox(height: AppSize.s16),
              
//               Expanded(
                  // child: PageView.builder(
                  //     // Block swipe
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     controller: _pageController,
                  //     itemCount: 4,
                  //     itemBuilder: (context, index) => QuestionCard(
                  //           question: Question(
                  //               id: sample_data[index]["id"],
                  //               question: sample_data[index]["question"],
                  //               answer: sample_data[index]["answer_index"],
                  //               options: sample_data[index]["options"]),
                  //         ))),
//             ],
//           ),
//         ))
//       ],
//     );
//   }
// }
