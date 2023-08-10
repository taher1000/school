import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.emptyMail,
            height: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          Text("No Books available",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 24)),
        ],
      ),
    );
  }
}
