import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/utils.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final String? hintText;
  final String? helperText;
  final Widget? icon;
  final bool enabled;
  final Widget? label;
  final bool enableInteractiveSelection;
  bool obscureText;
  final bool isPass;
  final TextDirection? textDirection;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? onSaved;
  final String? Function(String? value)? onFieldSubmitted;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final double? borderRaduis;
  final double? borderWidth;
  final String? initialValue;
  final String? labelText;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;

  CustomTextField(
      {Key? key,
      this.controller,
      this.suffixIcon,
      this.focusNode,
      this.borderRaduis,
      this.labelText,
      this.borderWidth,
      this.textColor,
      this.fillColor,
      this.keyboardType,
      this.maxLines,
      this.label,
      this.maxLength,
      this.textAlign = TextAlign.start,
      this.icon,
      this.hintText,
      this.helperText,
      this.contentPadding,
      this.enabled = true,
      this.enableInteractiveSelection = true,
      this.obscureText = false,
      this.isPass = false,
      this.textDirection,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.onFieldSubmitted,
      this.onTap,
      this.margin = const EdgeInsets.symmetric(vertical: 8),
      this.padding,
      this.inputFormatters,
      this.initialValue,
      this.autoValidateMode})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: TextFormField(
        initialValue: widget.initialValue,
        style: Theme.of(context).textTheme.labelLarge,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        autovalidateMode: widget.autoValidateMode,
        // style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // fillColor: widget.fillColor ??
          //     selectColor(context, Colors.transparent, textFieldDark),
          hintText: widget.hintText,
          label: widget.label, labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.labelLarge,
          helperText: widget.helperText,

          hintStyle: Theme.of(context).textTheme.labelMedium,
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: widget.icon,
                )
              : null,
          suffixIcon: widget.suffixIcon ??
              (widget.isPass
                  ? InkWell(
                      child: Icon(
                        _visiblePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: ColorManager.black,
                        size: AppSize.s14,
                      ),
                      onTap: () {
                        setState(() {
                          _visiblePassword = !_visiblePassword;
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                    )
                  : null),
          counterStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
          // suffixIcon: Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: icon,
          // ),
          errorMaxLines: 3,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.error, width: 2),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.error, width: 1),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        enabled: widget.enabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        focusNode: widget.focusNode ??
            (widget.enableInteractiveSelection
                ? null
                : AlwaysDisabledFocusNode()),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText,
        textDirection: widget.textDirection,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: widget.onTap,
      ),
    );
  }
}
