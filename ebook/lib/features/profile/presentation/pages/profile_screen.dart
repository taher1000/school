import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "My Profile",
      body: Container(
        color: Colors.red,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/boy.svg',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyleManager.getMediumStyle(
                            color: ColorManager.black, fontSize: AppSize.s40),
                      ),
                      Text(
                        'Class XI-B  |  Roll no: 04',
                        style: TextStyleManager.getMediumStyle(
                            color: ColorManager.black),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
