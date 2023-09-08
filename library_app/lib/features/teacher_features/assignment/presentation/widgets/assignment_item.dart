import 'package:library_app/core/entities/assignment/teacher_assignment.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../injection_container.dart';
import 'package:intl/intl.dart';

class AssignmentItem extends StatelessWidget {
  final TeacherAssignment assignment;
  const AssignmentItem({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy', 'en');

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: sharedPrefsClient == "ar"
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      onDismissed: (DismissDirection direction) {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            CustomNavigator.pushInSubNavigator(Routes.assignmentDetailsRoute,
                arguments: {'assignmentId': assignment.assignmentId});
          },
          title: Text(
            sharedPrefsClient.currentLanguage == 'en'
                ? assignment.englishName
                : assignment.arabicName,
            style: TextStyleManager.getMediumStyle(
                color: ColorManager.black, fontSize: FontSize.s18),
          ),
          subtitle: Text(
            'Due Date: ${dateFormat.format(assignment.startDate)} - ${dateFormat.format(assignment.endDate)}',
            style: TextStyleManager.getLightStyle(
                color: ColorManager.darkGrey, fontSize: FontSize.s12),
          ),
          leading: SvgPicture.asset(
            SvgAssets.assignment,
            color: ColorManager.darkPrimary,
            width: 30,
            height: 30,
          ),
          //   ),
        ),
      ),
    );
  }
}
