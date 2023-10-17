import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/core/resources/assets_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/cards/expansile_tile_card_widget.dart';
import '../../domain/entities/response/follow_up_student.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FollowUpAssignmentItemWidget extends StatelessWidget {
  final FollowUpStudent item;
  const FollowUpAssignmentItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return CustomExpansileTileWidget(
      title: Column(
        children: [
          Text(
            item.englishName,
            style: TextStyleManager.getMediumStyle(
                color: ColorManager.darkPrimary, fontSize: FontSize.s14.sp),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * .55,
              animation: true,
              lineHeight: 20.0,
              barRadius: Radius.circular(12.r),
              animationDuration: 2500,
              leading: Text(
                localize("completed"),
                style: TextStyleManager.getRegularStyle(
                    color: ColorManager.darkPrimary, fontSize: FontSize.s14.sp),
              ),
              percent: item.assignmentCompleted / item.assignment,
              center: Text(
                  '${item.assignmentCompleted / item.assignment * 100}',
                  style: const TextStyle(color: Colors.white)),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: ColorManager.darkPrimary,
            ),
          ),
        ],
      ),
      children: [
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            localize("details"),
            style: TextStyleManager.getBoldStyle(
                color: ColorManager.darkPrimary, fontSize: FontSize.s18.sp),
          ),
        ),
        buildText(
          FontAwesomeIcons.bookOpen,
          "${localize('assignments')}: ${item.assignment} | ${localize('completed')}: ${item.assignmentCompleted} | ${localize('remaining')}: ${item.assignmentRemaining}",
        ),
        buildText(
          FontAwesomeIcons.listCheck,
          "${localize('tasks')}: ${item.task} | ${localize('completed')}: ${item.assignmentCompleted} | ${localize('remaining')}: ${item.assignmentRemaining}",
        ),
        buildText(
          FontAwesomeIcons.headphones,
          "${localize('listening')}: ${item.listening} | ${localize('completed')}: ${item.listeningCompleted} ",
        ),
        buildText(
          FontAwesomeIcons.bookOpenReader,
          "${localize('reading')}: ${item.reading} | ${localize('completed')}: ${item.readingCompleted} ",
        ),
        buildText(
          FontAwesomeIcons.circleQuestion,
          "${localize('test')}: ${item.test} | ${localize('completed')}: ${item.testCompleted} ",
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Padding buildText(IconData icon, String text) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16.w, vertical: AppPadding.p8.h),
        child: Row(
          children: [
            FaIcon(icon, color: ColorManager.darkPrimary, size: 20.sp),
            SizedBox(
              width: AppSize.s16.w,
            ),
            Text(
              text,
              style: TextStyleManager.getRegularStyle(
                  color: ColorManager.black, fontSize: FontSize.s14.sp),
            ),
          ],
        ));
  }
}
