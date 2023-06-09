import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../core/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/validation.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffFAFAFA),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().screenHeight * .45,
                width: double.infinity,
                child: Stack(children: [
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    height: ScreenUtil().screenHeight * 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [.5, 1],
                        tileMode: TileMode.mirror,
                        colors: [
                          ColorManager.darkPrimary,
                          ColorManager.secondry,
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        SvgAssets.boyImage,
                        height: ScreenUtil().screenHeight * .25,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: ScreenUtil().screenHeight * .06,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(58),
                            topRight: Radius.circular(58)),
                        color:
                            // Colors.green
                            Color.fromARGB(52, 245, 157, 155),
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
                        color:
                            // Colors.green
                            Color(0xfffFAFAFA),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.95, .4),
                    child: Text(
                      "Hi !",
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.93, .6),
                    child: Text(
                      "Sign in to continue",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppSize.s8.h),
                          CustomTextField(
                            labelText: 'Email Address',
                          ),
                          SizedBox(height: AppSize.s8.h),
                          CustomTextField(
                            labelText: 'Password',
                            obscureText: true,
                            maxLines: 1,
                            isPass: true,
                            suffixIcon: Icon(Icons.visibility),
                            validator: (value) {
                              return Validation.isPassword(context, value!);
                            },
                          ),
                          SizedBox(height: AppSize.s8.h),
                          Container(
                            padding: const EdgeInsets.only(right: 20),
                            alignment: Alignment.topRight,
                            child: Text(
                              "*Forget password?",
                              style: TextStyleManager.getBoldStyle(
                                fontSize: 14,
                                color: const Color(0xff9891bd),
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(height: AppSize.s32.h),
                          CustomRoundedButton(
                            text: "Sign In",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
