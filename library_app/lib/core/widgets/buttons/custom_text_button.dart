import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;
  final Function()? onLongPress;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  const CustomTextButton({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.onPressed,
    this.onLongPress,
    this.margin,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(elevation!),
          backgroundColor: backgroundColor != null
              ? MaterialStateProperty.all<Color>(backgroundColor!)
              : null,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              padding ?? const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
