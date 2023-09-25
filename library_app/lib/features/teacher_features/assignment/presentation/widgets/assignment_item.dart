import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_app/core/entities/assignment/teacher_assignment.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/core/widgets/buttons/rounded_button.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/buttons/cancel_button.dart';
import '../../../../../core/widgets/buttons/ok_button.dart';
import '../../../../../injection_container.dart';
import 'package:intl/intl.dart';

import '../bloc/delete_assignment/delete_assignment_cubit.dart';

class AssignmentItem extends StatefulWidget {
  final IndicatorController controller;
  final TeacherAssignment assignment;
  const AssignmentItem(
      {super.key, required this.assignment, required this.controller});

  @override
  State<AssignmentItem> createState() => _AssignmentItemState();
}

class _AssignmentItemState extends State<AssignmentItem> {
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy', 'en');
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: sharedPrefsClient == "ar"
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          title: localize('are_you_sure_you_want_to_delete'),
          btnOk: OKButton(
            onPressed: () {
              BlocProvider.of<DeleteAssignmentCubit>(context)
                  .deleteAssignment(widget.assignment.assignmentId);
              Navigator.pop(context);
              widget.controller.enableRefresh();
            },
          ),
          btnCancel: CancelButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
          ),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorManager.darkPrimary,
                fontWeight: FontWeight.bold,
              ),
          descTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorManager.black,
                fontWeight: FontWeight.bold,
              ),
        ).show();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            CustomNavigator.pushInSubNavigator(Routes.assignmentDetailsRoute,
                arguments: {'assignmentId': widget.assignment.assignmentId});
          },
          title: Text(
            sharedPrefsClient.currentLanguage == 'en'
                ? widget.assignment.englishName
                : widget.assignment.arabicName,
            style: TextStyleManager.getMediumStyle(
                color: sharedPrefsClient.theme == ThemeMode.light
                    ? ColorManager.black
                    : ColorManager.grey,
                fontSize: FontSize.s16.sp),
          ),
          subtitle: Text(
            'Due Date: ${dateFormat.format(widget.assignment.startDate)} - ${dateFormat.format(widget.assignment.endDate)}',
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
