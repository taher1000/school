import '../../resources/styles_manager.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../config/validation.dart';
import '../../navigation/custom_navigation.dart';
import '../../resources/app_localization.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../text/custom_text.dart';
import 'custom_date_picker.dart';
import 'custom_textfield.dart';

class CustomDateTextField extends StatelessWidget {
  CustomDateTextField(
      {super.key,
      this.fillColor,
      this.margin,
      this.customTextButtonPadding,
      required this.controller,
      required this.label});
  final TextEditingController controller;
  final String label;
  final Color? fillColor;
  final EdgeInsetsGeometry? customTextButtonPadding;
  final EdgeInsetsGeometry? margin;

  DateTime _selectDate = DateTime.now();
  onTabField(TextEditingController controller) async {
    FocusScope.of(currentContext!).requestFocus(FocusNode());
    if (controller.text == "") {
      controller.text = intl.DateFormat('d/M/yyyy').format(DateTime.now());
    }
    cupertino.showCupertinoModalPopup(
      context: currentContext!,
      builder: (context) => Container(
        color: ColorManager.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 250,
              child: CustomCupertinoDatePicker(
                backgroundColor: ColorManager.grey,
                mode: CupertinoDatePickerMode.date,
                maximumYear: DateTime.now().year + 20,
                minimumYear: 1900,
                initialDateTime: _selectDate,
                dateOrder: cupertino.DatePickerDateOrder.dmy,
                onDateTimeChanged: (DateTime newDateTime) {
                  _selectDate = newDateTime;
                  controller.text =
                      intl.DateFormat('d/M/yyyy').format(newDateTime);
                },
              ),
            ),
            TextButton(
              child: Text(AppLocalization.of(context)
                  .getTranslatedValues("select_date")),
              onPressed: () {
                Navigator.of(context).pop();
              },
              onLongPress: null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      fillColor: fillColor,
      controller: controller,
      margin: margin,
      label: Text(AppLocalization.of(context).getTranslatedValues(label),
          style: TextStyleManager.getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s18)),
      onTap: () {
        onTabField(controller);
      },
      validator: (value) {
        return Validation.isValid(context, value!);
      },
    );
  }
}
