import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/styles_manager.dart';

class CircleChoice extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? containerColor;
  final Color? iconColor;

  const CircleChoice(
      {super.key,
      required this.icon,
      required this.title,
      this.onTap,
      this.containerColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor ?? ColorManager.white,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FaIcon(
                icon,
                color: iconColor ?? ColorManager.darkPrimary,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyleManager.getSemiBoldStyle(
                color: ColorManager.white, fontSize: FontSize.s14),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
