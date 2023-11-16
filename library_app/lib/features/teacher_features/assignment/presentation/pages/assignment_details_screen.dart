import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import '../../../../../core/constants.dart';
import '../bloc/get_assignment_by_id_cubit.dart';
import '../widgets/assignment_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/scaffolds/main_scaffold.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  final String assignmentId;
  const AssignmentDetailsScreen({super.key, required this.assignmentId});

  @override
  _AssignmentDetailsScreenState createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAssignmentByIdCubit>(context)
        .getAssignmentById(widget.assignmentId);

    _sliderController = CarouselSliderController();
  }

  @override
  void dispose() {
    _sliderController.dispose();
    super.dispose();
  }

  late final CarouselSliderController _sliderController;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      // screenTitle: "",
      canPop: true,
      body: Stack(
        children: [
          TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 1, end: 0),
              builder: (context, double value, _) {
                return Material(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorManager.darkPrimary,
                      borderRadius: BorderRadius.circular(value * 15),
                    ),
                  ),
                );
              }),
          BlocConsumer<GetAssignmentByIdCubit, GetAssignmentByIdState>(
            listener: (context, state) {
              if (state is GetAssignmentByIdLoading) {
                context.loaderOverlay.show();
              }

              if (state is GetAssignmentByIdSuccess) {
                context.loaderOverlay.hide();
              }
            },
            builder: (context, state) {
              if (state is GetAssignmentByIdSuccess) {
                return Positioned(
                  top: 50.h,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SlideInUp(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 300),
                    from: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.0),
                              topRight: Radius.circular(35.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 4,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p24),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: CarouselSlider.builder(
                                            unlimitedMode: true,
                                            controller: _sliderController,
                                            slideBuilder: (index) {
                                              return Container(
                                                alignment: Alignment.center,
                                                color:
                                                    AppConstants.colors[index],
                                                child: Expanded(
                                                    child: state
                                                            .assignment
                                                            .books[index]
                                                            .image
                                                            .isEmpty
                                                        ? Image.asset(
                                                            ImageAssets.noImage,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            width: 0.35.sw,
                                                            height: 0.35.sw,
                                                          )
                                                        : Image.memory(
                                                            base64Decode(
                                                            state
                                                                .assignment
                                                                .books[index]
                                                                .image,
                                                          ))),
                                              );
                                            },
                                            slideTransform:
                                                const CubeTransform(),
                                            slideIndicator:
                                                CircularSlideIndicator(
                                              padding: const EdgeInsets.only(
                                                  bottom: 32),
                                              indicatorBorderColor:
                                                  Colors.white,
                                              currentIndicatorColor:
                                                  ColorManager.primary,
                                            ),
                                            itemCount:
                                                state.assignment.books.length,
                                            initialPage: 0,
                                            enableAutoSlider: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        AssignmentInfo(
                                            assignmentDetails:
                                                state.assignment),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
