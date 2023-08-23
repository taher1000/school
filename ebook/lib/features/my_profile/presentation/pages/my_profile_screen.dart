import 'dart:convert';

import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:ebook/core/widgets/textfield/custom_dropdown.dart';
import 'package:ebook/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../core/blocs/language_cubit/language_cubit.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widgets/text/custom_text.dart';
import '../../../main/presentation/bloc/user_data_bloc.dart';
import '../widgets/icon_style.dart';
import '../widgets/profile_component_big_user_card.dart';
import '../widgets/profile_component_settings_group.dart';
import '../widgets/profile_component_settings_item.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    BlocProvider.of<MyProfileBloc>(context).add(GetProfileInfoEvent());
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      canPop: false,
      screenTitle: "My Profile",
      body: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: ListView(
            children: [
              // User card
              BlocBuilder<MyProfileBloc, MyProfileState>(
                builder: (context, state) {
                  if (state is MyProfileLoading) {
                    // context.loaderOverlay.show();
                    return const SizedBox();
                  } else if (state is MyProfileLoaded) {
                    // context.loaderOverlay.hide();

                    return BigUserCard(
                      backgroundColor: ColorManager.darkPrimary,
                      userName: state.userData.englishFullName,
                      userMoreInfo: SizedBox(
                          height: 50,
                          child:
                              Column(children: [Text(state.userData.email)])),
                      userProfilePic: MemoryImage(
                        base64Decode(state.userData.profilePicture),
                      ),
                      cardActionWidget: SettingsItem(
                        cardBackgroundColor: ColorManager.white,
                        icons: Icons.edit,
                        iconStyle: IconStyle(
                          withBackground: true,
                          borderRadius: 50,
                          backgroundColor: ColorManager.darkPrimary,
                        ),
                        title: "Modify",
                        subtitle: "Tap to change your data",
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
                    title: 'Dark mode',
                    subtitle: "Automatic",
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
                    title: 'About',
                    subtitle: "Learn more about Ebook App",
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
                    title: "Sign Out",
                  ),
                ],
              ),
            ],
          )),
    );
  }
}