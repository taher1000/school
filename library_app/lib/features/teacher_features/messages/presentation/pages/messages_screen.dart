import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/dotted_button.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../core/widgets/text/custom_text.dart';
import '../../../../../core/widgets/textfield/custom_dropdown.dart';

class TeacherMessagesScreen extends StatefulWidget {
  const TeacherMessagesScreen({super.key});

  @override
  State<TeacherMessagesScreen> createState() => _TeacherMessagesScreenState();
}

class _TeacherMessagesScreenState extends State<TeacherMessagesScreen> {
  String? messageOption;
  String? selectedStudent;
  final List<String> messageOptions = <String>[
    'الطالب',
    'كل الطلبة',
    'اهل الطالب',
  ];
  final List<String> studentNameList = <String>[
    'محمد احمد',
    'علي احمد محمد',
    'محمد احمد ابراهيم',
    'احمد محمد اسماعيل',
    'محمد احمد خالد',
    'احمد محمد حسن',
    'محمد احمد محمد',
    'احمد محمد نعيم',
    'محمد احمد سعيد',
    'احمد محمد اسعد',
    'محمد احمد طلال',
    'احمد محمد فزاع',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        screenTitle: "رسائلي",
        body: Column(
          children: [
            const Spacer(flex: 1),
            Image.asset(ImageAssets.emptyMail, width: 200),
            Text("لا يوجد رسائل",
                style: TextStyleManager.getBoldStyle(
                    color: Colors.black, fontSize: 20)),
            const Spacer(flex: 1),
            DottedButton(
              icon: FontAwesomeIcons.envelopeOpenText,
              text: 'أرسل رسالة',
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.question,
                  btnOk: CustomRoundedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Fluttertoast.showToast(
                          msg: AppLocalization.of(context).getTranslatedValues(
                              "لقد تم أرسال الرسالة بنجاح"),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorManager.darkPrimary,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    text: 'ارسال',
                  ),
                  body: StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: Column(children: [
                          CustomDropDownFormButton<String>(
                            selectItem: messageOption,
                            hint: 'أرسال الى',
                            items: messageOptions
                                .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Wrap(
                                      children: [
                                        CustomText(
                                          e,
                                          style: const TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    )))
                                .toList(),
                            onChanged: (data) {
                              setState(() {
                                messageOption = data;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          if (messageOption != null &&
                              messageOption != messageOptions[1])
                            CustomDropDownFormButton<String>(
                              selectItem: selectedStudent,
                              hint: 'اسم الطالب',
                              items: studentNameList
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Wrap(
                                        children: [
                                          CustomText(
                                            e,
                                            style:
                                                const TextStyle(color: Colors.black),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      )))
                                  .toList(),
                              onChanged: (data) {
                                setState(() {
                                  selectedStudent = data;
                                });
                              },
                            ),
                        ]),
                      );
                    },
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkOnPress: () {},
                ).show();
              },
            ),
            const Spacer(flex: 4),
          ],
        ));
  }
}
