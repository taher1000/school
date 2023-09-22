import 'package:flutter/material.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/styles_manager.dart';

class CustomTextButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;
  final Function()? onLongPress;
  final EdgeInsetsGeometry? margin;

  const CustomTextButton({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.onPressed,
    this.onLongPress,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: backgroundColor != null
              ? MaterialStateProperty.all<Color>(backgroundColor!)
              : null,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              padding ?? EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
      ),
    );
  }
}
