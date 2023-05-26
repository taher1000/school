import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDirection? textDirection;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const CustomText(
    this.text, {
    Key? key,
    this.style,
    this.overflow = TextOverflow.clip,
    this.textAlign,
    this.maxLines,
    this.textDirection,
    this.margin,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      color: backgroundColor,
      child: Text(
        text,
        style: style ?? Theme.of(context).textTheme.bodyText2,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        textDirection: textDirection,
      ),
    );
  }
}
