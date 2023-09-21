import 'package:dio/dio.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../core/widgets/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/validation.dart';
import '../bloc/sign_in_bloc.dart';
import '../widgets/change_language_segment.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Scaffold(
        backgroundColor: Color(0xfffFAFAFA),
        body: SingleChildScrollView(
          child: BlocConsumer<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state is SignInLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              if (state is SignInFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is SignInSuccess) {
                context.read<AppBloc>().add(UpdateAuthAppEvent(
                    userAuthStatus: UserAuthStatus.signedIn));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().screenHeight * .45,
                    width: double.infinity,
                    child: Stack(children: [
                      Container(
                        padding: const EdgeInsets.only(top: 40),
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 15.w, top: 130.h),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            localize("hi"),
                            textDirection: Directionality.of(context),
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 15.w, top: 200.h),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            localize("sign_in_to_continue"),
                            style: Theme.of(context).textTheme.titleMedium,
                            textDirection: Directionality.of(context),
                            textAlign: TextAlign.center,
                          ),
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
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppSize.s8.h),
                              CustomTextField(
                                controller: emailController,
                                hintText: localize("email"),
                                validator: (value) {
                                  return Validation.isEmail(context, value!);
                                },
                              ),
                              SizedBox(height: AppSize.s8.h),
                              CustomTextField(
                                controller: passwordController,
                                hintText: localize("password"),
                                obscureText: true,
                                isPass: true,
                                maxLines: 1,
                                validator: (value) {
                                  return Validation.isPassword(context, value!);
                                },
                              ),
                              SizedBox(height: AppSize.s8.h),
                              Container(
                                padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.topRight,
                                child: Text(
                                  localize("forgot_password"),
                                  style: TextStyleManager.getBoldStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff9891bd),
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(height: AppSize.s32.h),
                              CustomRoundedButton(
                                text: localize("sign_in"),
                                onPressed: () async {
                                  BlocProvider.of<SignInBloc>(context).add(
                                    Authenticate(
                                      email: "taher@gmail.com",
                                      // emailController.text,
                                      password: "P@ssw0rd",
                                      // passwordController.text,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
