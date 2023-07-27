import 'package:flutter/material.dart';

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
        style: TextButton.styleFrom(
          primary: backgroundColor,
          padding: padding,
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
      ),
    );
  }
}
