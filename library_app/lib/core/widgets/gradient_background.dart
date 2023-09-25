import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/blocs/app_theme_cubit/app_theme_cubit.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';

class GradientBackgroundWidget extends StatelessWidget {
  const GradientBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * .4,
      width: double.infinity,
      child: Stack(children: [
        BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, state) {
            return Container(
              height: ScreenUtil().screenHeight * 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [.8, 1],
                  // tileMode: TileMode.mirror,
                  colors: state.themeMode == ThemeMode.light
                      ? [
                          ColorManager.darkPrimary,
                          ColorManager.primary,
                        ]
                      : [
                          ColorManager.grey1,
                          ColorManager.darkGrey,
                        ],
                ),
                image: const DecorationImage(
                  // alignment: Alignment(-1, -.85),
                  image: AssetImage(ImageAssets.starsBG),
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          },
        ),
        // This for shadow container
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenUtil().screenHeight * .06,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(58), topRight: Radius.circular(58)),
              color: Color.fromARGB(52, 245, 157, 155),
            ),
          ),
        ),
        BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, state) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().screenHeight * .045,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  color: state.themeMode == ThemeMode.light
                      ? Color(0xfffFAFAFA)
                      : ColorManager.darkGrey,

                  // Colors.green
                  //
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
