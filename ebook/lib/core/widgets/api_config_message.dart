import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../navigation/custom_navigation.dart';
import '../resources/app_localization.dart';
import 'buttons/rounded_button.dart';
import 'text/custom_text.dart';

class ApiConfigMessage extends StatelessWidget {
  const ApiConfigMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no_internet.png",
            color: ColorManager.primary,
          ),
          CustomText(
            AppLocalization.of(context).getTranslatedValues(
                "Make sure you are connected to the internet"),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          CustomRoundedButton(
            text: AppLocalization.of(context).getTranslatedValues("tryAgain"),
            onPressed: () {
              CustomNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
