import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:ebook/injection_container.dart';

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
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      height: 15.0,
      width: 30,
      decoration: BoxDecoration(
          color: !isActive ? Colors.transparent : ColorManager.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          border: !isActive ? Border.all(width: 1) : null),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  children: const [
                    OnboardingPageWidget(
                      image: SvgAssets.onboardingLogo1,
                      title: AppStrings.onBoardingTitle1,
                      subTitle: AppStrings.onBoardingSubTitle1,
                    ),
                    OnboardingPageWidget(
                      image: SvgAssets.onboardingLogo2,
                      title: AppStrings.onBoardingTitle2,
                      subTitle: AppStrings.onBoardingSubTitle2,
                    ),
                    OnboardingPageWidget(
                      image: SvgAssets.onboardingLogo3,
                      title: AppStrings.onBoardingTitle3,
                      subTitle: AppStrings.onBoardingSubTitle3,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
              // _currentPage != _numPages - 1
              //     ?
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          AppStrings.next,
                          style: TextStyle(
                            backgroundColor: Colors.red,
                            color: Colors.black,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              // : const Text(''),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => print('Get started'),
                child: Center(
                  child: CustomRoundedButton(
                    text: "Get Started",
                    onPressed: () {
                      CustomNavigator.push(
                        Routes.loginRoute,
                      );
                    },
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
