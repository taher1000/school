import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  const EmptyWidget({Key? key, required this.text}) : super(key: key);

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
          Text(text,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 24)),
        ],
      ),
    );
  }
}
