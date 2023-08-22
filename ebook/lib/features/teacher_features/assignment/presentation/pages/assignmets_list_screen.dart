import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/loading/grid_pagination_widget.dart';
import '../../../../../core/widgets/loading/grid_shimmer_loading.dart';
import '../../../../../core/widgets/text/custom_error_widget.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../domain/entities/assignment.dart';
import '../bloc/assignment_bloc.dart';
import '../widgets/assignments_list_pagination_widget.dart';

class AssignmentsListScreen extends StatefulWidget {
  const AssignmentsListScreen({super.key});

  @override
  State<AssignmentsListScreen> createState() => _AssignmentsListScreenState();
}

class _AssignmentsListScreenState extends State<AssignmentsListScreen> {
  @override
  void initState() {
    BlocProvider.of<AssignmentBloc>(context).add(FetchAssignments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy', 'en');

    return CustomScaffold(
        screenTitle: localize("قائمة الواجبات"),
        body: Column(children: [
          Expanded(
            child: AssignmentsPaginationWidget<Assignment>(
              loadMore: () {
                BlocProvider.of<AssignmentBloc>(context)
                    .add(FetchAssignments());
              },
              child: (Assignment assignment) {
                return
                    // Dismissible(
                    //   key: UniqueKey(),
                    //   direction: DismissDirection.horizontal,
                    //   background: const ColoredBox(
                    //     color: Colors.orange,
                    //     child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Padding(
                    //         padding: EdgeInsets.all(16.0),
                    //         child: Icon(Icons.edit, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    //   secondaryBackground: const ColoredBox(
                    //     color: Colors.red,
                    //     child: Align(
                    //       alignment: Alignment.centerRight,
                    //       child: Padding(
                    //         padding: EdgeInsets.all(16.0),
                    //         child: Icon(Icons.delete, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    //   onDismissed: (DismissDirection direction) {
                    //     print('Dismissed with direction $direction');
                    //   },
                    //   confirmDismiss: (DismissDirection direction) async {
                    //     if (direction == DismissDirection.endToStart) {
                    //       AwesomeDialog(
                    //           context: context,
                    //           animType: AnimType.scale,
                    //           dialogType: DialogType.warning,
                    //           body: Column(
                    //             children: [
                    //               Text(
                    //                 'Are you sure you want to delete?',
                    //                 style: TextStyleManager.getMediumStyle(
                    //                     color: ColorManager.darkPrimary),
                    //               ),
                    //             ],
                    //           )).show();
                    //     } else {}

                    //     // return confirmed;
                    //   },
                    //   child:
                    Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      CustomNavigator.pushInSubNavigator(
                          Routes.assignmentDetailsRoute,
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
                    leading: FaIcon(
                      FontAwesomeIcons.schoolFlag,
                      color: ColorManager.darkPrimary,
                    ),
                    //   ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
