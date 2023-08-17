import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/custom_text_button.dart';
import '../../../../../core/widgets/textfield/custom_textfield.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../core/config/validation.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../students/presentation/widgets/students_list.dart';

class AddStudentGroupScreen extends StatefulWidget {
  const AddStudentGroupScreen({super.key});

  @override
  State<AddStudentGroupScreen> createState() => _AddStudentGroupScreenState();
}

class _AddStudentGroupScreenState extends State<AddStudentGroupScreen> {
  TextEditingController date = TextEditingController();
  TextEditingController controller = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy', 'en');
  DateTime? deathDate;

  final deathDateController = TextEditingController();
  final deathDateController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "أنشاء مجموعات من الطلبة",
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: "اسم المجموعة",
              label: Text(AppLocalization.of(context)
                  .getTranslatedValues("اسم المجموعة")),
            ),
            const SizedBox(height: AppSize.s4),
            const StudentsListWidget(),
          ],
        ),
      ),
    );
  }
}
