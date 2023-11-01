import 'dart:developer';

import '../../resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injection_container.dart';
import '../../blocs/app_bloc/app_bloc.dart';
import '../../navigation/custom_navigation.dart';
import '../../resources/app_localization.dart';
import '../buttons/rounded_button.dart';
import '../text/custom_text.dart';

class PrivacyPopMessage extends StatefulWidget {
  const PrivacyPopMessage({Key? key}) : super(key: key);

  @override
  State<PrivacyPopMessage> createState() => _PrivacyPopMessageState();
}

class _PrivacyPopMessageState extends State<PrivacyPopMessage> {
  @override
  void initState() {
    super.initState();
    _read();
  }

  String text = "";
  _read() async {
    try {
      text = await rootBundle.loadString(
          sharedPrefsClient.currentLanguage == "ar"
              ? 'assets/files/Privacy Agreement - Arabic.txt'
              : 'assets/files/Privacy Agreement - English.txt');
      setState(() {});
    } catch (e) {
      log(e.toString());
      log("Couldn't read file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          height: 0.8.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons8-terms-and-conditions-50.png",
                      color: ColorManager.primary,
                      height: 0.04.sh,
                      width: 0.04.sh,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      AppLocalization.of(context).getTranslatedValues(
                        "terms_of_services",
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: CustomText(
                    text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(height: 1.7),
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomRoundedButton(
                      onPressed: () {
                        // context
                        //     .read<UserDataBloc>()
                        //     .add(SetUserTermsAgreement(false));
                      },
                      text: AppLocalization.of(context)
                          .getTranslatedValues("decline"),
                    ),
                    CustomRoundedButton(
                      onPressed: () {
                        // context
                        //     .read<UserDataBloc>()
                        //     .add(SetUserTermsAgreement(true));
                        currentContext!.read<AppBloc>().add(UpdateAuthAppEvent(
                            userAuthStatus:
                                UserAuthStatus.userAgreePrivacyMessage));
                      },
                      text: AppLocalization.of(context)
                          .getTranslatedValues("accept"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
