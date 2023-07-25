import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/header_info_widget.dart';
import '../../../../core/widgets/info_container.dart';
import '../../../../core/widgets/main_info_container.dart';

class StudentBodyComponent extends StatelessWidget {
  const StudentBodyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const HeaderInfoWidget(),
        SizedBox(height: AppSize.s16.h),
        const Expanded(
          flex: 2,
          child: SizedBox(
            // color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainInfoContainer(
                  svgIcon: SvgAssets.levelIcon,
                  title: 'Level: 3',
                  desc: '90%',
                ),
                MainInfoContainer(
                  svgIcon: SvgAssets.gradeIcon,
                  title: 'Grade: 1',
                  desc: '90%',
                )
              ],
            ),
          ),
        ),
        SizedBox(height: AppSize.s16.h),
        Expanded(
          flex: 3,
          child: SizedBox(
            // color: Colors.blue,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoContainerWidget(
                        svgIcon: SvgAssets.readBook,
                        title: "Assignments",
                        onTap: () {},
                      ),
                      InfoContainerWidget(
                        svgIcon: SvgAssets.readBook,
                        title: "Messages",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoContainerWidget(
                        svgIcon: SvgAssets.readBook,
                        title: "Training",
                        onTap: () {},
                      ),
                      InfoContainerWidget(
                        svgIcon: SvgAssets.readBook,
                        title: "Statistics",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
