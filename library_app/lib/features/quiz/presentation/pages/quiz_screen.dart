import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/scaffolds/scaffold_with_background.dart';
import '../widgets/quiz_body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldBG(
      screenTitle: "Quiz",
      actions: [
        SizedBox(
          width: 60.w,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Skip",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: ColorManager.white,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      body: const Body(),
    );
  }
}
