import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/book.dart';
import 'two_side_rounded_button.dart';

class ReadingListItemCard extends StatelessWidget {
  final Book book;

  const ReadingListItemCard({
    Key? key,
    required this.book,
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
          book.image,
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
                          text: "${book.title}\n",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextSpan(
                          text: "Level: ${book.level}",
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
                      onTap: () {
                        CustomNavigator.pushInSubNavigator(
                          Routes.bookDetailsRoute,
                          arguments: {"book": book},
                        );
                      },
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
                        press: () {},
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
