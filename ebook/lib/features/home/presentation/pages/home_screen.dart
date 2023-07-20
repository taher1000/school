import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_info_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: ScreenUtil().screenHeight * .4,
          width: double.infinity,
          child: Stack(children: [
            Container(
              height: ScreenUtil().screenHeight * 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [.8, 1],
                  // tileMode: TileMode.mirror,
                  colors: [
                    ColorManager.darkPrimary,
                    ColorManager.primary,
                  ],
                ),
                image: const DecorationImage(
                  // alignment: Alignment(-1, -.85),
                  image: AssetImage(ImageAssets.starsBG),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // This for shadow container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().screenHeight * .06,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(58),
                      topRight: Radius.circular(58)),
                  color: Color.fromARGB(52, 245, 157, 155),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().screenHeight * .045,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  color: Color(0xfffFAFAFA),

                  // Colors.green
                  //
                ),
              ),
            ),
          ]),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: AppPadding.p40,
                  left: AppPadding.p16,
                  right: AppPadding.p16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
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
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
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
                              // SizedBox(height: AppSize.s8.h),
                              Text('Class XI-B  |  Roll no: 04',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: ColorManager.greyTextColor,
                                        fontSize: FontSize.s18,
                                      )),
                              SizedBox(height: AppSize.s8.h),
                              Container(
                                height: AppSize.s40.h,
                                width: AppSize.s120.w,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s32),
                                  color: ColorManager
                                      .white, // Replace with your desired color
                                ),
                                // padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    "2022 - 2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: ColorManager.darkPrimary,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 26, // Image radius
                            backgroundImage: NetworkImage('imageUrl'),
                          )
                        ],
                      ),
                    ),
                  ),
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
                            title: 'Class: 1',
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InfoContainerWidget(
                                    svgIcon: SvgAssets.readBook,
                                    title: "Statistics"),
                                InfoContainerWidget(
                                    svgIcon: SvgAssets.readBook,
                                    title: "Statistics"),
                              ],
                            ),
                            SizedBox(height: AppSize.s16.h),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InfoContainerWidget(
                                    svgIcon: SvgAssets.readBook,
                                    title: "Statistics"),
                                InfoContainerWidget(
                                    svgIcon: SvgAssets.readBook,
                                    title: "Statistics"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
