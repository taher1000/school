import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class ScaffoldBG extends StatelessWidget {
  final double scaffoldHeight;
  final Widget body;
  const ScaffoldBG({super.key, this.scaffoldHeight = .2, required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: ScreenUtil().screenHeight * scaffoldHeight,
      width: double.infinity,
      child: Stack(children: [
        Container(
          height: ScreenUtil().screenHeight * 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [.8, 1],
              // tileMode: TileMode.mirror,
              colors: [
                ColorManager.darkPrimary,
                ColorManager.primary,
              ],
            ),
            image: const DecorationImage(
              // alignment: Alignment(-1, -.85),
              image: AssetImage(ImageAssets.starsBG),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        // This for shadow container
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenUtil().screenHeight * .06,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(58), topRight: Radius.circular(58)),
              color: Color.fromARGB(52, 245, 157, 155),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenUtil().screenHeight * .88,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              color: Colors.white,

              // Colors.green
              //
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 24.h,
              ),
              child: body,
            ),
          ),
        ),
      ]),
    );
  }
}
