import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/values_manager.dart';
import 'package:library_app/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:library_app/core/widgets/textfield/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/injection_container.dart';

import '../../../../../core/blocs/app_theme_cubit/app_theme_cubit.dart';
import '../../../../../core/widgets/text/custom_text.dart';
import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../../core/blocs/language_cubit/language_cubit.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/profile/profile_component_settings_item.dart';
import '../../../../../core/widgets/profile/icon_style.dart';
import '../../../../../core/widgets/profile/profile_component_settings_group.dart';
import '../../core/enums/user_role.dart';
import '../main/presentation/bloc/user_data_bloc.dart';
import '../student_features/my_student_profile/presentation/pages/my_student_profile_screen.dart';
import '../teacher_features/my_teacher_profile/presentation/pages/my_teacher_profile_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    final changeLanguageItems = [
      DropdownMenuItem(
        value: "en",
        child: CustomText(
          'English',
          style: TextStyleManager.getMediumStyle(
              color: ColorManager.black, fontSize: FontSize.s12),
        ),
      ),
      DropdownMenuItem(
        value: "ar",
        child: CustomText(
          'العربية',
          style: TextStyleManager.getMediumStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
        ),
      ),
    ];

    return CustomScaffold(
      canPop: false,
      screenTitle: localize("my_profile"),
      body: Padding(
          padding: EdgeInsets.all(AppPadding.p8.r),
          child: BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (context, themeState) {
              return ListView(
                children: [
                  // User card
                  sharedPrefsClient.userRole == UserRole.teacher.value
                      ? MyProfileTeacherInfo(
                          themeMode: themeState.themeMode,
                        )
                      : MyProfileStudentInfoWidget(
                          themeMode: themeState.themeMode,
                        ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {
                          BlocProvider.of<AppThemeCubit>(context).changeTheme(
                              Theme.of(context).brightness == Brightness.dark
                                  ? ThemeMode.light
                                  : ThemeMode.dark);
                        },
                        icons: Icons.dark_mode_rounded,
                        iconStyle: iconStyle(themeState.themeMode),
                        title: localize("dark_mode"),
                        subtitle: localize("automatic"),
                        titleStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? ColorManager.darkGrey
                                      : ColorManager.darkPrimary,
                                  fontSize: FontSize.s16.sp,
                                ),
                        subtitleStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: FontSize.s10.sp,
                                ),
                        backgroundColor: themeState.themeMode == ThemeMode.dark
                            ? ColorManager.darkGrey
                            : ColorManager.greyTextColor,
                        cardBackgroundColor:
                            themeState.themeMode == ThemeMode.dark
                                ? ColorManager.greyDark
                                : null,
                        trailing: Switch.adaptive(
                          value: themeState.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            context.read<AppBloc>().toggleTheme(
                                value ? ThemeMode.dark : ThemeMode.light);
                          },
                        ),
                      ),
                    ],
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: Icons.info_rounded,
                        iconStyle: iconStyle(themeState.themeMode),
                        cardBackgroundColor:
                            themeState.themeMode == ThemeMode.dark
                                ? ColorManager.greyDark
                                : null,
                        title: localize("about_app"),
                        subtitle: localize("learn_more_about_app"),
                        titleStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? ColorManager.darkGrey
                                      : ColorManager.darkPrimary,
                                  fontSize: FontSize.s16.sp,
                                ),
                        subtitleStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: FontSize.s10.sp,
                                ),
                      ),
                    ],
                  ),
                  // You can add a settings title
                  SettingsGroup(
                    settingsGroupTitle: "Account",
                    settingsGroupTitleStyle: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(
                            fontSize: FontSize.s20.sp,
                            fontWeight: FontWeight.bold),
                    items: [
                      SettingsItem(
                        trailing: SizedBox(
                          width: 110.w,
                          // height: 70.h,
                          child: CustomDropDownFormButton<String>(
                            // borderColor: Colors.transparent,
                            color: themeState.themeMode == ThemeMode.dark
                                ? ColorManager.grey
                                : ColorManager.greyTextColor,
                            // padding: EdgeInsets.only(top: AppPadding.p4),
                            // borderWidth: 0,
                            selectItem: LanguageCubit.currentLanguage,
                            items: changeLanguageItems,
                            onChanged: (value) {
                              context
                                  .read<AppBloc>()
                                  .toggleLanguage(value as String);
                            },
                          ),
                        ),
                        onTap: () {},
                        iconStyle: iconStyle(themeState.themeMode),
                        icons: Icons.language,
                        title: localize("change_language"),
                        titleStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? ColorManager.darkGrey
                                      : ColorManager.darkPrimary,
                                  fontSize: FontSize.s16.sp,
                                ),
                        cardBackgroundColor:
                            themeState.themeMode == ThemeMode.dark
                                ? ColorManager.greyDark
                                : null,
                      ),
                      SettingsItem(
                        onTap: () {
                          context.read<UserDataBloc>().add(ClearUserData());
                          context.read<AppBloc>().add(UpdateAuthAppEvent(
                              userAuthStatus: UserAuthStatus.signedOut));
                        },
                        icons: Icons.exit_to_app_rounded,
                        iconStyle: iconStyle(themeState.themeMode),
                        title: localize("sign_out"),
                        titleStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? ColorManager.darkGrey
                                      : ColorManager.darkPrimary,
                                  fontSize: FontSize.s16.sp,
                                ),
                        cardBackgroundColor:
                            themeState.themeMode == ThemeMode.dark
                                ? ColorManager.greyDark
                                : null,
                      ),
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }

  IconStyle iconStyle(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      return IconStyle(
        iconsColor: ColorManager.grey,
        withBackground: true,
        backgroundColor: ColorManager.darkGrey,
      );
    } else {
      return IconStyle(
        iconsColor: Colors.white,
        withBackground: true,
        backgroundColor: ColorManager.darkPrimary,
      );
    }
  }
}
