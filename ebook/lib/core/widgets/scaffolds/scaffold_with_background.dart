import 'package:ebook/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/color_manager.dart';

class CustomScaffoldBG extends StatelessWidget {
  final String screenTitle;
  final Widget body;
  final List<Widget>? actions;

  const CustomScaffoldBG(
      {super.key, required this.screenTitle, required this.body, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 100.w,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: TextButton.icon(
            label: Text(
              screenTitle,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorManager.white,
                  ),
            ),
            icon: Icon(Icons.arrow_back_ios, color: ColorManager.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: actions,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: const DecorationImage(
              alignment: Alignment(-1, -.85),
              image: AssetImage(ImageAssets.starsBG),
              fit: BoxFit.fitWidth,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 1],
              tileMode: TileMode.mirror,
              colors: [
                ColorManager.darkPrimary,
                ColorManager.secondry,
              ],
            ),
          ),
          child: body,
        ));
  }
}
