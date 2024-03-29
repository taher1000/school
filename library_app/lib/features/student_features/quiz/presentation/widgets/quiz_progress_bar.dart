import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resources/font_manager.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../bloc/answering_quiz_bloc/answering_quiz_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: ColorManager.darkPrimary,
      elevation: AppSize.s4,
      borderRadius: BorderRadius.circular(AppSize.s50),
      child: BlocBuilder<AnsweringQuizBloc, AnsweringQuizState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
                color: ColorManager.darkPrimary,
                border: Border.all(
                  color: ColorManager.darkPrimary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(AppSize.s50)),
            child: Stack(
              children: [
                // LayoutBuider provide the available space for the container
                // constraints.maxWidth need for animation
                LayoutBuilder(
                    builder: (context, constraints) => Container(
                          width: state.currentQuestionNumber * 45.w,
                          decoration: BoxDecoration(
                              color: state.currentQuestionNumber == 10
                                  ? ColorManager.primary
                                  : null,
                              gradient: state.currentQuestionNumber == 10
                                  ? null
                                  : LinearGradient(
                                      colors: [
                                        ColorManager.darkPrimary,
                                        ColorManager.primary
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: const [0, 1],
                                    ),
                              borderRadius: BorderRadius.circular(50)),
                        )),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16 - 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Question ${state.currentQuestionNumber}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s12.sp),
                        ),
                        SvgPicture.asset("assets/images/clock.svg")
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: AppPadding.p8),
                //   child: Align(
                //       alignment: Alignment.centerRight,
                //       child: SvgPicture.asset(SvgAssets.clock)),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
