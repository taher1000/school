import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/widgets/scaffolds/scaffold_with_background.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../bloc/quiz_score_cubit/quiz_score_cubit.dart';

class AfterQuizScreen extends StatefulWidget {
  final String bookID;
  const AfterQuizScreen({Key? key, required this.bookID}) : super(key: key);

  @override
  State<AfterQuizScreen> createState() => _AfterQuizScreenState();
}

class _AfterQuizScreenState extends State<AfterQuizScreen> {
  bool isPlaying = false;
  late ConfettiController _controllerTopCenter;

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  int score = 20;
  @override
  void initState() {
    BlocProvider.of<QuizScoreCubit>(context).getQuizScore(widget.bookID);
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    setState(() {
      _controllerTopCenter.play();
    });

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CustomScaffoldBG(
            screenTitle: localize("result"),
            body: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      Text(
                        localize("congratulations"),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                color: ColorManager.secondry,
                                fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(0.05)),
                        child: CircleAvatar(
                          backgroundColor: Color(0xff5A88B0),
                          radius: 120.r,
                          child: Image.asset(ImageAssets.cup),
                        ),
                      ),
                      BlocBuilder<QuizScoreCubit, QuizScoreState>(
                        builder: (context, state) {
                          if (state is QuizScoreLoadedState) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Card(
                                      elevation: 0,
                                      color: ColorManager.secondry,
                                      // Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                              color: ColorManager.darkPrimary,
                                              width: 3)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.quizScore[0].totalAnswerPoint
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    color: ColorManager
                                                        .darkPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            "درجه",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    color: ColorManager
                                                        .darkPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    // height: 150,
                                    child: Card(
                                      color: ColorManager.greyTextColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                              color: ColorManager.darkPrimary,
                                              width: 3)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${state.quizScore[0].answerPercentage.toString()} % ${state.quizScore[0].totalQuizPoint.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    color: ColorManager
                                                        .darkPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            "النسبه",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    color: ColorManager
                                                        .darkPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: 120.h,
                          width: 160.w,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Card(
                              color: ColorManager.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "رجوع",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            )),
        ConfettiWidget(
          numberOfParticles: 50,
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: _controllerTopCenter,
        )
      ],
    );
  }
}
