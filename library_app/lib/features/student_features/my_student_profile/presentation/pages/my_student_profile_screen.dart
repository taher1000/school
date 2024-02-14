import 'dart:convert';

import 'package:library_app/core/widgets/text/custom_error_widget.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/widgets/profile/profile_component_settings_item.dart';
import '../../../../../core/widgets/profile/user_card.dart';
import '../../../../../core/widgets/profile/icon_style.dart';
import '../bloc/my_student_profile_bloc.dart';

class MyProfileStudentInfoWidget extends StatefulWidget {
  final ThemeMode themeMode;
  const MyProfileStudentInfoWidget({super.key, required this.themeMode});

  @override
  State<MyProfileStudentInfoWidget> createState() =>
      _MyProfileStudentInfoWidgetState();
}

class _MyProfileStudentInfoWidgetState
    extends State<MyProfileStudentInfoWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyStudentProfileBloc>(context)
        .add(GetStudentProfileInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return BlocBuilder<MyStudentProfileBloc, MyStudentProfileState>(
      builder: (context, state) {
        if (state is MyStudentProfileLoading) {
          context.loaderOverlay.show();
          return const SizedBox();
        } else if (state is MyStudentProfileError) {
          return CustomErrorWidget(text: state.message);
        } else if (state is MyStudentProfileLoaded) {
          context.loaderOverlay.hide();

          return BigUserProfileCard(
            backgroundColor: ColorManager.darkPrimary,
            userName: state.userData.englishFullName,
            userMoreInfo: SizedBox(
                height: 50.h,
                child: Column(children: [
                  Text(
                    sharedPrefsClient.email,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: widget.themeMode == ThemeMode.dark
                              ? ColorManager.darkGrey
                              : ColorManager.white,
                        ),
                  )
                ])),
            cardActionWidget: SettingsItem(
              cardBackgroundColor: widget.themeMode == ThemeMode.dark
                  ? ColorManager.grey
                  : ColorManager.white,
              icons: Icons.edit,
              iconStyle: IconStyle(
                withBackground: true,
                borderRadius: 50.r,
                backgroundColor: widget.themeMode == ThemeMode.dark
                    ? ColorManager.black
                    : ColorManager.darkPrimary,
              ),
              title: localize("modify"),
              titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: widget.themeMode == ThemeMode.dark
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
