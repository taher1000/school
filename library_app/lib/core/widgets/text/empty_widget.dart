import 'package:cached_network_image/cached_network_image.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  const EmptyWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(SvgAssets.noDataImage,
              height: MediaQuery.of(context).size.height * 0.5),
          // Image.asset(
          //   ImageAssets.emptyMail,
          //   height: 200,
          // ),
          const SizedBox(
            height: 30,
          ),
          Text(
              text ??
                  AppLocalization.of(context)
                      .getTranslatedValues("no_data_found"),
              style: TextStyle(color: Colors.grey.shade500, fontSize: 24)),
        ],
      ),
    );
  }
}
