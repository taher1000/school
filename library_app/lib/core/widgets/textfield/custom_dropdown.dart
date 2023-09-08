import 'package:flutter/material.dart';

import '../../resources/app_localization.dart';
import '../../resources/color_manager.dart';

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
          Text(
            AppLocalization.of(context).getTranslatedValues(label!) + ":",
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
                color: color ?? ColorManager.white,
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
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),
                isExpanded: isExpanded ?? false,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                value: selectItem,
                items: items,
                hint: Wrap(
                  children: [
                    Text(
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
