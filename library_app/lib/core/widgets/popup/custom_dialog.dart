import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../resources/app_localization.dart';
import '../../resources/color_manager.dart';
import '../buttons/cancel_button.dart';
import '../buttons/ok_button.dart';

void showCustomDialog(BuildContext context,
    {required String message,
    required String title,
    required String description,
    required VoidCallback btnOkOnPressed,
    required VoidCallback btnCancelOnPressed,
    Color? backgroundColor,
    DialogType? dialogType = DialogType.info}) {
  final localize = AppLocalization.of(context).getTranslatedValues;
  AwesomeDialog(
    context: context,
    dialogType: dialogType!,
    animType: AnimType.bottomSlide,
    btnOk: OKButton(
      onPressed: btnOkOnPressed,
    ),
    btnCancel: CancelButton(
      onPressed: btnCancelOnPressed,
    ),
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
