import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/values_manager.dart';
import 'scaffold_with_background.dart';
import 'scaffold_background.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final bool canPop;

  const MainScaffold({super.key, required this.body, this.canPop = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60.h),
      //   child: AppBar(
      //     backgroundColor: ColorManager.darkPrimary,
      //     elevation: 0,
      // leading: canPop
      //     ? IconButton(
      //         icon: const Icon(Icons.arrow_back_ios),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       )
      //     : null,
      //   ),
      // ),
      body: Stack(
        children: [
          ScaffoldBG(body: body, bodyHeight: .88),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p28, horizontal: AppPadding.p4),
            child: Align(
              alignment: Alignment.topLeft,
              child: canPop
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: ColorManager.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
            ),
          ),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: ScaffoldBody(
          //       body: body,
          //     )),
        ],
      ),
    );
  }
}

class ScaffoldBody extends StatelessWidget {
  final Widget body;

  const ScaffoldBody({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: SizedBox(
        // color: Colors.amber,
        height: double.infinity,
        width: double.infinity,
        child: body,
      ),
    );
  }
}
