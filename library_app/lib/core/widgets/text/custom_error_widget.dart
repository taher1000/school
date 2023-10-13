import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/color_manager.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? text;
  const CustomErrorWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.darkPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            size: 50,
            color: ColorManager.error,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(text ?? "Error Occured,try again",
              maxLines: 5,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 24)),
        ],
      ),
    );
  }
}
