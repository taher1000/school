import '../enums/user_role.dart';
import '../resources/app_localization.dart';
import '../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../features/main/data/enums/user_role_enum.dart';

class HeaderInfoWidget extends StatelessWidget {
  const HeaderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Expanded(
      flex: 1,
      child: SizedBox(
        // color: Colors.red,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: [
                      TextSpan(
                        text: localize('hi'),
                      ),
                      TextSpan(
                        text: localize(' '),
                      ),
                      TextSpan(
                        text: sharedPrefsClient.currentLanguage == 'en'
                            ? sharedPrefsClient.englishFullName
                            : sharedPrefsClient.arabicFullName,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: AppSize.s8.h),
                Text(
                    sharedPrefsClient.userRole == UserRole.teacher.value
                        ? UserRole.fromJson(4).userType.toString().toUpperCase()
                        : 'Class XI-B  |  Roll no: 04',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: ColorManager.greyTextColor,
                          fontSize: FontSize.s18,
                        )),
                if (sharedPrefsClient.userRole != UserRole.teacher.value)
                  SizedBox(height: AppSize.s8.h),
                Container(
                  height: AppSize.s40.h,
                  width: AppSize.s120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s32),
                    color:
                        ColorManager.white, // Replace with your desired color
                  ),
                  // padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "2022 - 2023",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: ColorManager.darkPrimary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 26, // Image radius
            )
          ],
        ),
      ),
    );
  }
}
