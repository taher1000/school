import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../resources/app_localization.dart';
import '../../resources/color_manager.dart';
import '../buttons/cancel_button.dart';
import '../buttons/ok_button.dart';

void showCustomDialog(BuildContext context,
    {required String title,
    required String description,
    required VoidCallback btnOkOnPressed,
    required VoidCallback btnCancelOnPressed,
    bool haveCancelBtn = true,
    Color? backgroundColor,
    DialogType? dialogType = DialogType.noHeader}) {
  final localize = AppLocalization.of(context).getTranslatedValues;
  AwesomeDialog(
    context: context,
    dialogType: dialogType!,
    animType: AnimType.bottomSlide,
    btnOk: OKButton(
      onPressed: btnOkOnPressed,
    ),
    btnCancel: haveCancelBtn
        ? CancelButton(
            onPressed: btnCancelOnPressed,
          )
        : null,
    titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: ColorManager.darkPrimary,
          fontWeight: FontWeight.bold,
        ),
    descTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: ColorManager.black,
          fontWeight: FontWeight.bold,
        ),
    title: localize(title),
    desc: localize(description),
  ).show();
}
