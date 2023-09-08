import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../text/custom_text.dart';

class MaximumCallsMessage extends StatelessWidget {
  final String message;
  const MaximumCallsMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            SvgAssets.empty,
          ),
          CustomText(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ]),
      ),
    );
  }
}
