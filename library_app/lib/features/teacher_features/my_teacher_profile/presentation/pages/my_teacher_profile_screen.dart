import 'dart:convert';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/widgets/profile/profile_component_settings_item.dart';
import '../../../../../core/widgets/profile/user_card.dart';
import '../../../../../core/widgets/profile/icon_style.dart';
import '../bloc/my_teacher_profile_bloc.dart';

class MyProfileTeacherInfo extends StatelessWidget {
  final ThemeMode themeMode;
  const MyProfileTeacherInfo({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    BlocProvider.of<MyTeacherProfileBloc>(context)
        .add(GetTeacherProfileInfoEvent());
    return BlocBuilder<MyTeacherProfileBloc, MyTeacherProfileState>(
      builder: (context, state) {
        if (state is MyTeacherProfileLoading) {
          // context.loaderOverlay.show();
          return const SizedBox();
        } else if (state is MyTeacherProfileLoaded) {
          // context.loaderOverlay.hide();

          return BigUserProfileCard(
            // backgroundColor: ColorManager.darkPrimary,
            userName: state.userData.englishFullName,
            userMoreInfo: SizedBox(
                height: 50.h,
                child: Column(children: [
                  Text(
                    state.userData.email,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: themeMode == ThemeMode.dark
                              ? ColorManager.black
                              : ColorManager.white,
                        ),
                  )
                ])),

            cardActionWidget: SettingsItem(
              cardBackgroundColor: themeMode == ThemeMode.dark
                  ? ColorManager.grey
                  : ColorManager.white,
              icons: Icons.edit,
              iconStyle: IconStyle(
                withBackground: true,
                borderRadius: 50.r,
                backgroundColor: themeMode == ThemeMode.dark
                    ? ColorManager.black
                    : ColorManager.darkPrimary,
              ),
              title: localize("modify"),
              titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: themeMode == ThemeMode.dark
                        ? ColorManager.darkGrey
                        : ColorManager.darkPrimary,
                    fontSize: FontSize.s16.sp,
                  ),
              subtitle: localize("tap_to_change_your_data"),
              subtitleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: FontSize.s10.sp,
                  ),
              onTap: () {},
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
