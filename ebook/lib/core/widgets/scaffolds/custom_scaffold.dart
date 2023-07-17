import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import 'scaffold_with_background.dart';
import 'scaffold_background.dart';

class CustomScaffold extends StatelessWidget {
  final String screenTitle;
  final Widget body;
  final double height;

  const CustomScaffold({
    super.key,
    required this.body,
    required this.screenTitle,
    this.height = 750,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          screenTitle,
          style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s22, color: ColorManager.white),
        ),
        backgroundColor: ColorManager.darkPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ScaffoldBG(body: body),
    );
  }
}
