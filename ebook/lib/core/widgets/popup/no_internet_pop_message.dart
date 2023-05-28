import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/app_localization.dart';
import '../text/custom_text.dart';

class NoInternetPopMessage extends StatelessWidget {
  const NoInternetPopMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          SvgAssets.noInternet,
          color: ColorManager.primary,
        ),
        CustomText(
          AppLocalization.of(context).getTranslatedValues("check_internet"),
          style: Theme.of(context).textTheme.bodyText1,
        )
      ]),
    );
  }
}
