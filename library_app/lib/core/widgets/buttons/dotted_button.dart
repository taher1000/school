import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/color_manager.dart';

class DottedButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const DottedButton(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        color: ColorManager.darkPrimary,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: ColorManager.darkPrimary.withOpacity(.1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(flex: 1),
              FaIcon(
                icon,
                color: ColorManager.darkPrimary,
                size: 40,
              ),
              const Spacer(flex: 1),
              Text(
                text,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
