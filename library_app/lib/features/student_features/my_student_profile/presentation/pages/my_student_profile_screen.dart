import 'dart:convert';

import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/widgets/profile/profile_component_settings_item.dart';
import '../../../../../core/widgets/profile/user_card.dart';
import '../../../../../core/widgets/profile/icon_style.dart';
import '../bloc/my_student_profile_bloc.dart';

class MyProfileStudentInfoWidget extends StatelessWidget {
  final ThemeMode themeMode;
  const MyProfileStudentInfoWidget({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    BlocProvider.of<MyStudentProfileBloc>(context)
        .add(GetStudentProfileInfoEvent());
    return BlocBuilder<MyStudentProfileBloc, MyStudentProfileState>(
      builder: (context, state) {
        if (state is MyStudentProfileLoading) {
          context.loaderOverlay.show();
          return const SizedBox();
        } else if (state is MyStudentProfileLoaded) {
          context.loaderOverlay.hide();

          return BigUserProfileCard(
            backgroundColor: ColorManager.darkPrimary,
            userName: state.userData.englishName,
            userMoreInfo: SizedBox(
                height: 50.h,
                child: Column(children: [
                  Text(
                    sharedPrefsClient.email,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: themeMode == ThemeMode.dark
                              ? ColorManager.darkGrey
                              : ColorManager.white,
                        ),
                  )
                ])),
            userProfilePic: MemoryImage(
              base64Decode(sharedPrefsClient.userImage),
            ),
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
                  ),
              subtitle: localize("tap_to_change_your_data"),
              subtitleStyle: Theme.of(context).textTheme.bodyMedium,
              onTap: () {},
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
