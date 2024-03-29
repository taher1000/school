import '../../../../core/constants.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/resources/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/header_info_widget.dart';
import '../../../../core/widgets/info_container.dart';

class TeacherBodyComponent extends StatelessWidget {
  const TeacherBodyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(flex: 1, child: HeaderInfoWidget()),
        Expanded(
          flex: 3,
          child: SizedBox(
            // color: Colors.blue,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 160.h,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: AppMargin.m12,
                ),
                itemCount: AppConstants.homeTitlesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InfoContainerWidget(
                    svgIcon: AppConstants.homeImagesList[index],
                    title: localize(AppConstants.homeTitlesList[index]),
                    onTap: () {
                      CustomNavigator.pushInSubNavigator(
                          AppConstants.homeScreensList[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
