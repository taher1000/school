import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/core/resources/values_manager.dart';
import 'package:library_app/core/widgets/cards/expansile_tile_card_widget.dart';
import 'package:library_app/features/teacher_features/assignment/domain/entities/response/follow_up_student.dart';
import 'package:library_app/features/teacher_features/assignment/presentation/bloc/delete_assignment/delete_assignment_cubit.dart';
import 'package:library_app/features/teacher_features/assignment/presentation/bloc/follow_up_assignments_students_bloc/follow_up_assignments_students_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../../core/resources/app_localization.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../../core/widgets/text/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowUpAssignmentsListBodyWidget extends StatelessWidget {
  const FollowUpAssignmentsListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    BlocProvider.of<FollowUpAssignmentsStudentsBloc>(context)
        .add(const FetchFollowUpAssignments());

    return MyRefreshIndicator(
      onRefresh: () {
        final Completer<void> completer = Completer<void>();
        BlocProvider.of<FollowUpAssignmentsStudentsBloc>(context).isRefresh =
            true;

        BlocProvider.of<FollowUpAssignmentsStudentsBloc>(context)
            .add(const FetchFollowUpAssignments());

        completer.complete();

        return completer.future;
      },
      widget: BlocConsumer<FollowUpAssignmentsStudentsBloc,
          FollowUpAssignmentsStudentsState>(
        listener: (context, state) {
          if (state is GetFollowUpAssignmentsLoading) {
            context.loaderOverlay.show();
          }
          if (state is GetFollowUpAssignmentsError) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is GetFollowUpAssignmentsLoaded) {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          if (state is GetFollowUpAssignmentsLoading) {
            return const ListShimmerLoadingWidget();
          }
          if (state is GetFollowUpAssignmentsLoaded) {
            if (state.followUpAssignments.data.isEmpty) {
              return const EmptyWidget();
            }
          }
          return Expanded(
              child: PagedListView<int, FollowUpStudent>(
                  pagingController:
                      BlocProvider.of<FollowUpAssignmentsStudentsBloc>(context)
                          .pagingController,
                  builderDelegate: PagedChildBuilderDelegate<FollowUpStudent>(
                      itemBuilder: (context, item, index) =>
                          ExpansileTileWidget(
                            title: item.englishName,
                            index: index + 1,
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
                                      color: ColorManager.darkPrimary,
                                      fontSize: FontSize.s18.sp),
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
                          ))));
        },
      ),
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
                  color: ColorManager.darkPrimary, fontSize: FontSize.s14.sp),
            ),
          ],
        ));
  }
}
