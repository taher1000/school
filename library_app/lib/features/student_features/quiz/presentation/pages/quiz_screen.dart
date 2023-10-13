import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/scaffold_with_background.dart';
import '../../data/enums/quiz_type_enum.dart';
import '../bloc/get_all_questions_cubit/get_all_questions_cubit.dart';
import '../widgets/quiz_screen_body.dart';

class QuizScreen extends StatelessWidget {
  final String assignmentId;
  final String bookId;
  final QuizTypeEnum quizType;
  const QuizScreen(
      {super.key,
      required this.assignmentId,
      required this.bookId,
      required this.quizType});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetAllQuestionsCubit>(context)
        .getAllQuestions(bookId, assignmentId, quizType);
    return CustomScaffoldBG(
        canPop: true,
        screenTitle: "Quiz",
        body: BlocBuilder<GetAllQuestionsCubit, GetAllQuestionsState>(
          builder: (context, state) {
            return LoadingStatusWidget(
                requestStatus: state.requestStatus,
                errorMessage: state.errorMessage,
                widget: QuizScreenBody(assignmentId: assignmentId));
          },
        ));
  }
}
