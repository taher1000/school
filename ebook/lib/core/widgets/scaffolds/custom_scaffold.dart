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

  const CustomScaffold(
      {super.key, required this.body, required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          screenTitle,
          style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s22, color: ColorManager.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          const ScaffoldBG(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              // color: Colors.amber,
              height: 750.h,
              width: 400.w,
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
