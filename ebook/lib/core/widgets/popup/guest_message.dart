import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/app_bloc/app_bloc.dart';
import '../../resources/app_localization.dart';
import '../../resources/color_manager.dart';
import '../buttons/rounded_button.dart';

class GuestMessage extends StatelessWidget {
  const GuestMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          height: 404.h,
          width: 385.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SvgPicture.asset(kDigitalIdentitySvgAsset),
              Text(
                AppLocalization.of(context)
                    .getTranslatedValues("guest_message"),
                style: TextStyle(
                  fontSize: 28.sp,
                ),
              ),
              Text(
                AppLocalization.of(context)
                    .getTranslatedValues("guest_message_body"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorManager.greyDark, fontSize: 19.sp, height: 1.5),
              ),
              CustomRoundedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AppBloc>().add(UpdateAuthAppEvent(
                      userAuthStatus: UserAuthStatus.signedOut));
                },
                text: AppLocalization.of(context)
                    .getTranslatedValues("signInOrSignUp"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
