
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/color_manager.dart';
import 'package:flutter/services.dart';
import '../../config/utils.dart';


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
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;

  CustomTextField(
      {Key? key,
      this.controller,
      this.suffixIcon,
      this.focusNode,
      this.borderRaduis,
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
      this.margin,
      this.padding,
      this.inputFormatters,
      this.initialValue,
      this.autovalidateMode})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 8.h),
      padding: widget.padding,
      child: TextFormField(
        initialValue: widget.initialValue,
        style: TextStyleManager.getRegularStyle(
            color: ColorManager.greyDark, fontSize: FontSize.s14.sp),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        autovalidateMode: widget.autovalidateMode,
        // style: TextStyle(color: Colors.ColorManager.black),
        decoration: InputDecoration(
          fillColor: widget.fillColor,
          filled: false,
          hintText: widget.hintText,

          label: widget.label,
          // labelStyle: TextStyleManager.getMediumStyle(
          //     color: ColorManager.black, fontSize: FontSize.s18),
          helperText: widget.helperText,
          contentPadding: widget.contentPadding ??
              (widget.icon != null
                  ? EdgeInsets.zero
                  : EdgeInsetsDirectional.symmetric(
                      horizontal: 10.w, vertical: 20.h)),
          // hintStyle: TextStyleManager.getMediumStyle(color: ColorManager.black),
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0.h),
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
                        size: 14.sp,
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
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(widget.borderRaduis ?? 12.sp),
          //   borderSide: BorderSide(
          //       color: ColorManager.black, width: widget.borderWidth ?? 1.sp),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(widget.borderRaduis ?? 12.sp),
          //   borderSide: BorderSide(
          //       color: ColorManager.black, width: widget.borderWidth ?? 1.sp),
          // ),
          // disabledBorder: UnderlineInputBorder(),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(widget.borderRaduis ?? 12.sp),
          //   borderSide: BorderSide(
          //       color: ColorManager.error, width: widget.borderWidth ?? 2.sp),
          // ),
          // focusedErrorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(widget.borderRaduis ?? 12.sp),
          //   borderSide: BorderSide(
          //       color: ColorManager.error, width: widget.borderWidth ?? 1.sp),
          // ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5.sp),
          // ),
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
