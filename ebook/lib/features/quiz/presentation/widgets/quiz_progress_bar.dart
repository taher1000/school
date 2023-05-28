import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/values_manager.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF3F4768), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Stack(
        children: [
          // LayoutBuider provide the available space for the container
          // constraints.maxWidth need for animation
          LayoutBuilder(
              builder: (context, constraints) => Container(
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorManager.darkPrimary,
                            ColorManager.secondry
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.4, 0.8],
                        ),
                        borderRadius: BorderRadius.circular(50)),
                  )),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16 - 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${2} ${(2) > 1 ? "seconds" : "second"}"),
                SvgPicture.asset("assets/icons/clock.svg")
              ],
            ),
          ))
        ],
      ),
    );
  }
}
