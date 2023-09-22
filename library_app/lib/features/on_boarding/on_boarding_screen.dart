import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/widgets/buttons/custom_text_button.dart';

import '../../core/navigation/custom_navigation.dart';
import '../../core/resources/routes_manager.dart';
import '../../core/widgets/buttons/outline_button.dart';
import '../../injection_container.dart';

import '../../core/resources/assets_manager.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../../core/resources/values_manager.dart';
import '../../core/widgets/buttons/rounded_button.dart';
import 'widgets/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      constraints: BoxConstraints(maxHeight: 30.h),
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 15.0.h,
      width: 10.w,
      decoration: BoxDecoration(
          color: !isActive ? Colors.transparent : ColorManager.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
          border: !isActive ? Border.all(width: 1.w) : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    sharedPrefsClient.setFirstTimeLogin = false;

                    CustomNavigator.push(
                      Routes.loginRoute,
                    );
                  },
                  child: Text(
                    AppStrings.skip,
                    style: TextStyleManager.getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 590.0,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    OnboardingPageWidget(
                      image: SvgAssets.onboardingLogo1,
                      title: localize(AppStrings.onBoardingTitle1),
                      subTitle: localize(AppStrings.onBoardingSubTitle1),
                    ),
                    OnboardingPageWidget(
                      image: SvgAssets.onboardingLogo2,
                      title: localize(AppStrings.onBoardingTitle2),
                      subTitle: localize(AppStrings.onBoardingSubTitle2),
                    ),
                    OnboardingPageWidget(
                      image: SvgAssets.onboardingLogo3,
                      title: localize(AppStrings.onBoardingTitle3),
                      subTitle: localize(AppStrings.onBoardingSubTitle3),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage == _numPages - 1
                  ? Container(
                      height: 50.0.h,
                      margin: EdgeInsets.symmetric(
                          horizontal: AppPadding.p40.w,
                          vertical: AppPadding.p16.h),
                      width: double.infinity,
                      color: Colors.white,
                      child: Center(
                        child: CustomRoundedButton(
                          text: localize("get_started"),
                          onPressed: () {
                            CustomNavigator.push(
                              Routes.loginRoute,
                            );
                          },
                        ),
                      ),
                    )
                  : CustomTextButton(
                      child: Text(localize(AppStrings.next),
                          style: TextStyleManager.getSemiBoldStyle(
                              color: ColorManager.darkPrimary,
                              fontSize: FontSize.s16.sp)),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
