import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../core/blocs/language_cubit/language_cubit.dart';
import '../../../../core/resources/color_manager.dart';

class ChangeLanguageSegment extends StatelessWidget {
  const ChangeLanguageSegment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CupertinoSegmentedControl(
        unselectedColor: Colors.transparent,
        borderColor: ColorManager.darkGrey,
        onValueChanged: (value) {
          context.read<AppBloc>().toggleLanguage(value);
        },
        children: {
          'ar': Container(
            padding: EdgeInsets.all(6.w),
            child: Text(
              'AR',
              style: TextStyle(
                  fontSize: 12,
                  color: LanguageCubit.currentLanguage == "ar"
                      ? ColorManager.primary
                      : ColorManager.darkGrey),
            ),
          ),
          'en': Container(
            padding: EdgeInsets.all(6.w),
            child: Text(
              'EN',
              style: TextStyle(
                fontSize: 12,
                color: LanguageCubit.currentLanguage == "en"
                    ? ColorManager.primary
                    : ColorManager.darkGrey,
              ),
            ),
          ),
        },
      ),
    );
  }
}
