import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ebook/core/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import 'scaffold_background.dart';
import 'scaffold_with_background.dart';

class CustomScaffold extends StatelessWidget {
  final String screenTitle;
  final Widget body;
  final double height;
  final bool canPop;
  final List<Widget>? actions;
  const CustomScaffold({
    Key? key,
    required this.screenTitle,
    required this.body,
    this.height = 750,
    this.canPop = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: canPop ? false : true,
        title: Text(
          screenTitle,
          style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s22, color: ColorManager.white),
        ),
        backgroundColor: ColorManager.darkPrimary,
        elevation: 0,
        leading: canPop
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        actions: actions,
      ),
      body: ScaffoldBG(
          body: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p16, left: AppPadding.p16, right: AppPadding.p16),
        child: body,
      )),
    );
  }
}
