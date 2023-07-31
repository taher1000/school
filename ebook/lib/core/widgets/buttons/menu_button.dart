import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class MenuButton extends StatelessWidget {
  final IconData iconPath;
  final String title;
  final String route;
  const MenuButton(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1.0,
              color: ColorManager.darkGrey,
            )),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 55,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: ColorManager.secondryLight,
                    borderRadius: BorderRadius.circular(8.0)),
                width: boxConstraints.maxWidth * (0.2),
                child:
                    FaIcon(iconPath, color: ColorManager.darkPrimary, size: 26),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                title,
                style: TextStyleManager.getSemiBoldStyle(
                    color: ColorManager.darkPrimary, fontSize: FontSize.s16),
              ),
              const Spacer(),
              CircleAvatar(
                backgroundColor: ColorManager.darkPrimary,
                radius: 17.5,
                child: Icon(
                  Icons.arrow_forward,
                  size: 22.5,
                  color: ColorManager.white,
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
          );
        }),
      ),
    );
  }
}
