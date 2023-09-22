import 'dart:convert';

import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/values_manager.dart';
import 'package:library_app/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:library_app/core/widgets/textfield/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
import '../bloc/my_teacher_profile_bloc.dart';

class MyProfileTeacherScreen extends StatelessWidget {
  const MyProfileTeacherScreen({super.key});

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
    BlocProvider.of<MyTeacherProfileBloc>(context)
        .add(GetTeacherProfileInfoEvent());
    return CustomScaffold(
        canPop: false, screenTitle: localize("my_profile"), body: Container()
        //  Padding(
        //     padding: const EdgeInsets.all(AppPadding.p8),
        //     child: ListView(
        //       children: [
        //         // User card
        //         BlocBuilder<MyTeacherProfileBloc, MyTeacherProfileState>(
        //           builder: (context, state) {
        //             if (state is MyTeacherProfileLoading) {
        //               // context.loaderOverlay.show();
        //               return const SizedBox();
        //             } else if (state is MyTeacherProfileLoaded) {
        //               // context.loaderOverlay.hide();

        //               return BigUserProfileCard(
        //                 backgroundColor: ColorManager.darkPrimary,
        //                 userName: state.userData.englishFullName,
        //                 userMoreInfo: SizedBox(
        //                     height: 50,
        //                     child:
        //                         Column(children: [Text(state.userData.email)])),
        //                 userProfilePic: MemoryImage(
        //                   base64Decode(state.userData.profilePicture),
        //                 ),
        //                 cardActionWidget: SettingsItem(
        //                   cardBackgroundColor: ColorManager.white,
        //                   icons: Icons.edit,
        //                   iconStyle: IconStyle(
        //                     withBackground: true,
        //                     borderRadius: 50,
        //                     backgroundColor: ColorManager.darkPrimary,
        //                   ),
        //                   title: localize("modify"),
        //                   subtitle: localize("tap_to_change_your_data"),
        //                   onTap: () {},
        //                 ),
        //               );
        //             }
        //             return const SizedBox();
        //           },
        //         ),
        //         SettingsGroup(
        //           items: [
        //             SettingsItem(
        //               onTap: () {},
        //               icons: Icons.dark_mode_rounded,
        //               iconStyle: IconStyle(
        //                 iconsColor: Colors.white,
        //                 withBackground: true,
        //                 backgroundColor: ColorManager.darkPrimary,
        //               ),
        //               title: localize("dark_mode"),
        //               subtitle: localize("automatic"),
        //               backgroundColor: ColorManager.greyTextColor,
        //               trailing: Switch.adaptive(
        //                 value: false,
        //                 onChanged: (value) {
        //                   context.read<AppBloc>().toggleTheme(
        //                       value ? ThemeMode.dark : ThemeMode.light);
        //                 },
        //               ),
        //             ),
        //           ],
        //         ),
        //         SettingsGroup(
        //           items: [
        //             SettingsItem(
        //               onTap: () {},
        //               icons: Icons.info_rounded,
        //               iconStyle: IconStyle(
        //                 backgroundColor: ColorManager.darkPrimary,
        //               ),
        //               title: localize("about_app"),
        //               subtitle: localize("learn_more_about_app"),
        //             ),
        //           ],
        //         ),
        //         // You can add a settings title
        //         SettingsGroup(
        //           settingsGroupTitle: "Account",
        //           items: [
        //             SettingsItem(
        //               trailing: SizedBox(
        //                 width: 110.w,
        //                 // height: 70.h,
        //                 child: CustomDropDownFormButton<String>(
        //                   // borderColor: Colors.transparent,
        //                   color: ColorManager.greyTextColor,
        //                   // padding: EdgeInsets.only(top: AppPadding.p4),
        //                   // borderWidth: 0,
        //                   selectItem: LanguageCubit.currentLanguage,
        //                   items: changeLanguageItems,
        //                   onChanged: (value) {
        //                     context
        //                         .read<AppBloc>()
        //                         .toggleLanguage(value as String);
        //                   },
        //                 ),
        //               ),
        //               onTap: () {},
        //               iconStyle: IconStyle(
        //                 iconsColor: Colors.white,
        //                 withBackground: true,
        //                 backgroundColor: ColorManager.darkPrimary,
        //               ),
        //               icons: Icons.language,
        //               title: localize("change_language"),
        //             ),
        //             SettingsItem(
        //               onTap: () {
        //                 context.read<UserDataBloc>().add(ClearUserData());
        //                 context.read<AppBloc>().add(UpdateAuthAppEvent(
        //                     userAuthStatus: UserAuthStatus.signedOut));
        //               },
        //               icons: Icons.exit_to_app_rounded,
        //               iconStyle:
        //                   IconStyle(backgroundColor: ColorManager.darkPrimary),
        //               title: localize("sign_out"),
        //             ),
        //           ],
        //         ),
        //       ],
        //     )
        // ),
        );
  }
}
