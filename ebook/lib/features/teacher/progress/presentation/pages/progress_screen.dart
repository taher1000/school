import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/text/custom_text.dart';

class StudentsProgressScreen extends StatefulWidget {
  const StudentsProgressScreen({super.key});

  @override
  State<StudentsProgressScreen> createState() => _StudentsProgressScreenState();
}

const List<String> list = <String>[
  'الصف الاول',
  'الصف الثاني',
  'الصف الثالث',
  'الصف الرابع'
];

class _StudentsProgressScreenState extends State<StudentsProgressScreen> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "Students Progress",
      body: Column(
        children: [
          CustomDropDownFormButton<String>(
            selectItem: dropdownValue,
            hint: 'اختار الصف',
            items: list
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Wrap(
                      children: [
                        CustomText(
                          e,
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )))
                .toList(),
            onChanged: (data) {
              setState(() {
                dropdownValue = data;
              });
            },
          ),
          if (dropdownValue != null)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text(
                          "الطالب رقم $index",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "المستوي الاول",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          "90%",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        )),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class CustomDropDownFormButton<T> extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final String hint;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool? isExpanded;
  final List<DropdownMenuItem<T>> items;
  final T? selectItem;
  final void Function(T?)? onChanged;
  final FormFieldValidator<T>? validator;
  final BoxDecoration? decoration;
  final double? borderWidth;
  final String? label;
  const CustomDropDownFormButton(
      {this.borderWidth,
      this.decoration,
      Key? key,
      this.textStyle,
      required this.items,
      required this.selectItem,
      this.onChanged,
      this.borderColor,
      this.hint = "",
      this.color,
      this.width,
      this.height,
      this.margin,
      this.isExpanded,
      this.padding,
      this.validator,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          CustomText(
            AppLocalization.of(context).getTranslatedValues(label!) + ":",
            padding: const EdgeInsets.only(bottom: 5),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color ?? Colors.white10,
                border: Border.all(
                  width: borderWidth ?? 1,
                  color: color != null
                      ? borderColor ?? Colors.transparent
                      : Colors.black,
                ),
              ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonFormField<T>(
                decoration: const InputDecoration(border: InputBorder.none),
                isExpanded: isExpanded ?? false,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                value: selectItem,
                items: items,
                hint: Wrap(
                  children: [
                    CustomText(
                      hint,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                icon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 5.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                onChanged: onChanged,
                validator: validator,
              )),
        ),
      ],
    );
  }
}
