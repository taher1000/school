import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../injection_container.dart';
import '../blocs/app_theme_cubit/app_theme_cubit.dart';
import '../resources/assets_manager.dart';

class AppLogo extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const AppLogo({this.width, this.height, this.padding, this.margin, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(builder: (_, themeState) {
      return Center(
        child: Container(
          padding: padding,
          margin: margin,
          child: Image(
            image: AssetImage(
              sharedPrefsClient.theme != null &&
                      sharedPrefsClient.theme != ThemeMode.system
                  ? sharedPrefsClient.theme == ThemeMode.dark
                      ? ImageAssets.logo
                      : ImageAssets.logoBackground
                  : MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? ImageAssets.logo
                      : ImageAssets.logoBackground,
            ),
            width: width ?? 203.48.sp,
            height: height ?? 112.09.sp,
          ),
        ),
      );
    });
  }
}
