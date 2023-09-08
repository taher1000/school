import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/color_manager.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            size: 50,
            color: ColorManager.darkPrimary,
          ),
          const SizedBox(
            height: 30,
          ),
          Text("Error Occured,try again",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 24)),
        ],
      ),
    );
  }
}
