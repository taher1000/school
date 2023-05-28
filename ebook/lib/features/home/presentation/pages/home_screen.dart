import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_info_container.dart';
import '../../../../core/widgets/scaffolds/main_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              // color: Colors.red,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: [
                        const TextSpan(
                          text: 'Hi ',
                        ),
                        TextSpan(
                          text: 'Taher',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.s8.h),
                  Text('Class XI-B  |  Roll no: 04',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: ColorManager.greyTextColor,
                            fontSize: FontSize.s18,
                          )),
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
                        style: TextStyleManager.getMediumStyle(
                          color: ColorManager.darkPrimary,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSize.s16.h),
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.green,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainInfoContainer(
                    svgIcon: SvgAssets.levelIcon,
                    title: 'Level: 3',
                    desc: '90%',
                  ),
                  MainInfoContainer(
                    svgIcon: SvgAssets.gradeIcon,
                    title: 'Class: 1',
                    desc: '90%',
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoContainerWidget(
                          svgIcon: SvgAssets.readBook, title: "Statistics"),
                      InfoContainerWidget(
                          svgIcon: SvgAssets.readBook, title: "Statistics"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoContainerWidget(
                          svgIcon: SvgAssets.readBook, title: "Statistics"),
                      InfoContainerWidget(
                          svgIcon: SvgAssets.readBook, title: "Statistics"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
