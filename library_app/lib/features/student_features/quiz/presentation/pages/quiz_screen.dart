import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/features/student_features/quiz/presentation/bloc/quiz_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widgets/scaffolds/scaffold_with_background.dart';
import '../../../../../core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/quiz_body.dart';

class QuizScreen extends StatefulWidget {
  final String bookID;
  const QuizScreen({super.key, required this.bookID});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    BlocProvider.of<QuizBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<QuizBloc>(context)
          .add(FetchQuestions(bookID: widget.bookID));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldBG(
      screenTitle: "Quiz",
      // actions: [
      //   SizedBox(
      //     width: 60.w,
      //     child: TextButton(
      //       onPressed: () {},
      //       child: Text(
      //         "Skip",
      //         style: Theme.of(context).textTheme.titleSmall!.copyWith(
      //             color: ColorManager.white,
      //             fontSize: FontSize.s16,
      //             fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //   ),
      // ],
      body: QuizScreenBody(bookID: widget.bookID),
    );
  }
}
