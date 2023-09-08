import 'dart:convert';

import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/assets_manager.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/values_manager.dart';
import 'package:library_app/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:library_app/core/widgets/textfield/custom_dropdown.dart';
import 'package:library_app/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/widgets/text/custom_text.dart';
import '../../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../../core/blocs/language_cubit/language_cubit.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/profile/profile_component_settings_item.dart';
import '../../../../../core/widgets/profile/user_card.dart';
import '../../../../main/presentation/bloc/user_data_bloc.dart';
import '../../../../../core/widgets/profile/icon_style.dart';
import '../../../../../core/widgets/profile/profile_component_settings_group.dart';
import '../bloc/my_student_profile_bloc.dart';

class MyProfileStudentScreen extends StatelessWidget {
  const MyProfileStudentScreen({super.key});

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
    BlocProvider.of<MyStudentProfileBloc>(context)
        .add(GetStudentProfileInfoEvent());
    return CustomScaffold(
      canPop: false,
      screenTitle: localize("my_profile"),
      body: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: ListView(
            children: [
              // User card
              BlocBuilder<MyStudentProfileBloc, MyStudentProfileState>(
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
                          height: 50,
                          child: Column(
                              children: [Text(sharedPrefsClient.email)])),
                      userProfilePic: MemoryImage(
                        base64Decode(sharedPrefsClient.userImage),
                      ),
                      cardActionWidget: SettingsItem(
                        cardBackgroundColor: ColorManager.white,
                        icons: Icons.edit,
                        iconStyle: IconStyle(
                          withBackground: true,
                          borderRadius: 50,
                          backgroundColor: ColorManager.darkPrimary,
                        ),
                        title: localize("modify"),
                        subtitle: localize("tap_to_change_your_data"),
                        onTap: () {},
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: ColorManager.darkPrimary,
                    ),
                    title: localize("dark_mode"),
                    subtitle: localize("automatic"),
                    backgroundColor: ColorManager.greyTextColor,
                    trailing: Switch.adaptive(
                      value: false,
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
                    iconStyle: IconStyle(
                      backgroundColor: ColorManager.darkPrimary,
                    ),
                    title: localize("about_app"),
                    subtitle: localize("learn_more_about_app"),
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    trailing: SizedBox(
                      width: 110.w,
                      // height: 70.h,
                      child: CustomDropDownFormButton<String>(
                        // borderColor: Colors.transparent,
                        color: ColorManager.greyTextColor,
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
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: ColorManager.darkPrimary,
                    ),
                    icons: Icons.language,
                    title: localize("change_language"),
                  ),
                  SettingsItem(
                    onTap: () {
                      context.read<UserDataBloc>().add(ClearUserData());
                      context.read<AppBloc>().add(UpdateAuthAppEvent(
                          userAuthStatus: UserAuthStatus.signedOut));
                    },
                    icons: Icons.exit_to_app_rounded,
                    iconStyle:
                        IconStyle(backgroundColor: ColorManager.darkPrimary),
                    title: localize("sign_out"),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
