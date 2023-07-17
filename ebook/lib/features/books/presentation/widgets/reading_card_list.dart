import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'two_side_rounded_button.dart';

class ReadingListItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String auth;
  final double rating;
  final VoidCallback pressDetails;
  final VoidCallback pressRead;

  const ReadingListItemCard({
    Key? key,
    required this.image,
    required this.title,
    required this.auth,
    required this.rating,
    required this.pressDetails,
    required this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: AppSize.s275.h,
            decoration: BoxDecoration(
              color: ColorManager.secondryLight,
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(10, -5),
                  blurRadius: 22,
                  color: ColorManager.darkPrimary.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          image,
          width: AppSize.s160.w,
        ),
        Positioned(
          top: AppSize.s200.h,
          child: SizedBox(
            height: AppSize.s100.h,
            width: AppSize.s200.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p24),
                  child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                      style: TextStyle(color: ColorManager.black),
                      children: [
                        TextSpan(
                          text: "$title\n",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextSpan(
                          text: auth,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorManager.grey1,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: pressDetails,
                      child: Container(
                        width: 101,
                        padding:
                            const EdgeInsets.symmetric(vertical: AppPadding.p8),
                        alignment: Alignment.center,
                        child: Text("Details",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                    ),
                    Expanded(
                      child: TwoSideRoundedButton(
                        text: "Read",
                        press: pressRead,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
