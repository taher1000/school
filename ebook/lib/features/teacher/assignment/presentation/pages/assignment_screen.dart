import 'package:ebook/core/navigation/navigator.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/textfield/custom_dropdown.dart';
import '../../../../../core/widgets/text/custom_text.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  State<TeacherAssignmentScreen> createState() =>
      _TeacherAssignmentScreenState();
}

class _TeacherAssignmentScreenState extends State<TeacherAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "Students Assignment",
      body: Column(
        children: [
          _buildMenuContainer(
            iconPath: FontAwesomeIcons.bookMedical,
            title: "انشاء واجب قرائي",
            route: Routes.addAssignmentRoute,
          ),
          _buildMenuContainer(
            iconPath: FontAwesomeIcons.calendarCheck,
            title: "متابعة الواجبات",
            route: Routes.assignmentFollowUpRoute,
          ),
          _buildMenuContainer(
            iconPath: FontAwesomeIcons.solidRectangleList,
            title: "قائمة الواجبات",
            route: Routes.assignmentListRoute,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuContainer(
      {required IconData iconPath,
      required String title,
      required String route}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1.0,
                color: ColorManager.darkGrey,
              )),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 55,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      color: ColorManager.secondryLight,
                      borderRadius: BorderRadius.circular(8.0)),
                  width: boxConstraints.maxWidth * (0.2),
                  child: FaIcon(iconPath,
                      color: ColorManager.darkPrimary, size: 26),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  title,
                  style: TextStyleManager.getSemiBoldStyle(
                      color: ColorManager.darkPrimary, fontSize: FontSize.s16),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: ColorManager.darkPrimary,
                  radius: 17.5,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 22.5,
                    color: ColorManager.white,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
