import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const TwoSideRoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.25, 1.0],
            colors: [
              ColorManager.darkPrimary,
              ColorManager.secondry,
            ],
          ),
          // color: ColorManager.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.s32),
            bottomRight: Radius.circular(AppSize.s32),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
