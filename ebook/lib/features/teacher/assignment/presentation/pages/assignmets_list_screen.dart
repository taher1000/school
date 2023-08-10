import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:ebook/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/loading/pagination_widget.dart';
import '../../../../../core/widgets/loading/shimmer_loading.dart';
import '../../../../../core/widgets/text/custom_error_widget.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../domain/entities/assignment.dart';
import '../bloc/assignment_bloc.dart';

class AssignmentsListScreen extends StatelessWidget {
  const AssignmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return CustomScaffold(
        screenTitle: localize("قائمة الواجبات"),
        body: Expanded(
          child: PaginationWidget<Assignment>(
            loadMore: () {
              BlocProvider.of<AssignmentBloc>(context).add(FetchAssignments());
            },
            initialEmpty: const EmptyWidget(),
            initialLoading: const LoadingWidget(),
            initialError: const CustomErrorWidget(),
            child: (Assignment assignment) {
              return Card(
                child: ListTile(
                  title: Text(
                    sharedPrefsClient.currentLanguage == 'en'
                        ? assignment.englishName
                        : assignment.arabicName,
                    style: TextStyleManager.getMediumStyle(
                        color: ColorManager.black, fontSize: FontSize.s18),
                  ),
                  subtitle: Text(
                    'Due Date: ${assignment.startDate} - ${assignment.endDate}',
                    style: TextStyleManager.getLightStyle(
                        color: ColorManager.darkGrey, fontSize: FontSize.s12),
                  ),
                  // leading: CircleAvatar(
                  //   backgroundColor: ColorManager.secondry,
                  //   child: Text(
                  //     'class $index',
                  //     style: TextStyleManager.getMediumStyle(
                  //         color: ColorManager.white, fontSize: FontSize.s11),
                  //   ),
                  // ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: ColorManager.error)),
                ),
              );
            },
          ),
        )
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 9,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Card(
        //         child: ListTile(
        //           title: Text(
        //             'Assignment ',
        //             style: TextStyleManager.getMediumStyle(
        //                 color: ColorManager.black, fontSize: FontSize.s18),
        //           ),
        //           subtitle: Text(
        //             'Due Date: 12/12/2021',
        //             style: TextStyleManager.getLightStyle(
        //                 color: ColorManager.darkGrey, fontSize: FontSize.s12),
        //           ),
        //           leading: CircleAvatar(
        //             backgroundColor: ColorManager.secondry,
        //             child: Text(
        //               'class $index',
        //               style: TextStyleManager.getMediumStyle(
        //                   color: ColorManager.white, fontSize: FontSize.s11),
        //             ),
        //           ),
        //           trailing: IconButton(
        //               onPressed: () {},
        //               icon: Icon(Icons.delete, color: ColorManager.error)),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        );
  }
}
