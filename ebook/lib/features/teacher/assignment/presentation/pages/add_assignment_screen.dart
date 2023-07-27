import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/buttons/custom_text_button.dart';
import 'package:ebook/core/widgets/textfield/custom_textfield.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../core/config/validation.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/cards/student_card.dart';
import '../../../../../core/widgets/class_room_menu.dart';
import '../../../../../core/widgets/text/custom_text.dart';
import '../../../../../core/widgets/textfield/custom_date_textfield.dart';
import '../../../../../core/widgets/textfield/custom_dropdown.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  TextEditingController date = TextEditingController();
  TextEditingController controller = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy', 'en');
  DateTime? deathDate;

  final deathDateController = TextEditingController();
  final deathDateController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "أنشاء واجب قرائي",
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: "اسم الواجب",
              label: Text(AppLocalization.of(context)
                  .getTranslatedValues("اسم الواجب")),
            ),
            const SizedBox(height: AppSize.s4),
            CustomTextField(
              label: Text(
                AppLocalization.of(context).getTranslatedValues('يبدأ بتاريخ'),
                style: TextStyleManager.getMediumStyle(
                    color: ColorManager.black, fontSize: FontSize.s18),
              ),
              controller: deathDateController,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.number,
              validator: (value) => Validation.isValid(context, value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter
              ],
              suffixIcon: const Icon(Icons.date_range),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? initialDate;
                if (deathDateController.text.isNotEmpty) {
                  initialDate = dateFormat.parse(deathDateController.text);
                  deathDateController.text = dateFormat.format(initialDate);
                }
                showModalBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 3),
                  builder: (context) {
                    return CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.grey[200],
                        maximumDate:
                            DateTime.now().add(const Duration(seconds: 1)),
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime date) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            deathDateController.text = dateFormat.format(date);
                          });
                          // date.toUtc().toFormatedString()!;

                          setState(() {
                            deathDate = date;
                          });
                        });
                  },
                );
              },
            ),
            const SizedBox(height: AppSize.s4),

            CustomTextField(
              label: Text(
                AppLocalization.of(context).getTranslatedValues('ينتهي في'),
                style: TextStyleManager.getMediumStyle(
                    color: ColorManager.black, fontSize: FontSize.s18),
              ),
              controller: deathDateController2,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.number,
              validator: (value) => Validation.isValid(context, value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter
              ],
              suffixIcon: const Icon(Icons.date_range),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? initialDate;
                if (deathDateController2.text.isNotEmpty) {
                  initialDate = dateFormat.parse(deathDateController2.text);
                  deathDateController2.text = dateFormat.format(initialDate);
                }
                showModalBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 3),
                  builder: (context) {
                    return CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.grey[200],
                        maximumDate:
                            DateTime.now().add(const Duration(seconds: 1)),
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime date) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            deathDateController2.text = dateFormat.format(date);
                          });
                          // date.toUtc().toFormatedString()!;

                          setState(() {
                            deathDate = date;
                          });
                        });
                  },
                );
              },
            ),
            // CustomDateTextField(
            //   controller: date,
            //   label: AppLocalization.of(context)
            //       .getTranslatedValues("يبدأ بتاريخ"),
            // ),
            // const SizedBox(height: AppSize.s20),

            // CustomDateTextField(
            //   controller: date,
            //   label:
            //       AppLocalization.of(context).getTranslatedValues("ينتهي في"),
            // ),
            const SizedBox(height: AppSize.s12),
            const ClassRoomMenu(),
          ],
        ),
      ),
    );
  }
}
