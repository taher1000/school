import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/features/teacher_features/assignment/domain/entities/response/assignment_details.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class AssignmentInfo extends StatelessWidget {
  final AssignmentDetails assignmentDetails;
  const AssignmentInfo({
    super.key,
    required this.assignmentDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          assignmentDetails.assignment.englishName,
          style: TextStyleManager.getBlackStyle(color: ColorManager.black),
        ),
        Text(
          "From ${assignmentDetails.assignment.startDate} to ${assignmentDetails.assignment.endDate}",
          style: TextStyleManager.getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s24),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "",
          style: TextStyleManager.getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
        ),
      ],
    );
  }
}
