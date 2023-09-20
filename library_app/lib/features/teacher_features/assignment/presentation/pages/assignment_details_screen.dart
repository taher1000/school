import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:library_app/core/constants.dart';
import 'package:library_app/features/teacher_features/assignment/domain/entities/response/assignment_details.dart';
import 'package:library_app/features/teacher_features/assignment/presentation/bloc/get_assignment_by_id_cubit.dart';
import 'package:library_app/features/teacher_features/assignment/presentation/widgets/assignment_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'dart:math' as math;

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
  // int selectedCat = 0;
  // int selectedColor = 0;
  int qty = 0;
  bool showDragWidget = false;
  Offset dragOffset = const Offset(0, 0);
  double targetDistance = 0.0;

  late AnimationController _imagePulseController;
  late AnimationController _qtyPulseController;

  GlobalKey fabKey = GlobalKey();
  GlobalKey imageKey = GlobalKey();

  Offset fabOffset() => (fabKey.currentContext!.findRenderObject() as RenderBox)
      .localToGlobal(Offset.zero);

  Offset imageOffset() =>
      (imageKey.currentContext!.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);

  _onLongPressStart(LongPressStartDetails details) {
    setState(() {
      dragOffset = Offset(imageOffset().dx - 30, imageOffset().dy - 180);
      showDragWidget = true;
      qty = 0;
    });
  }

  _onLongPressEnd(LongPressEndDetails details) {
    if (targetDistance > 80) {
      targetDistance = 140;
      dragOffset = Offset(fabOffset().dx - 85, fabOffset().dy - 270);
      addQty();
    } else {
      targetDistance = 0;
      dragOffset = Offset(imageOffset().dx, imageOffset().dy - 192);
      setState(() {});
    }

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        showDragWidget = false;
        targetDistance = 0;
      });
    });
  }

  _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    var position = details.globalPosition;
    setState(() {
      dragOffset = Offset(position.dx - 100, position.dy - 192);
    });

    double offDistance = (dragOffset - fabOffset()).distance;

    if (offDistance < 400 && offDistance > 250) {
      targetDistance = (400.0 - offDistance);
    }
  }

  addQty() async {
    setState(() {
      qty = 1;
    });
    await Future.delayed(const Duration(seconds: 1));
    _qtyPulseController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _qtyPulseController.reverse();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAssignmentByIdCubit>(context)
        .getAssignmentById(widget.assignmentId);
    _imagePulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _qtyPulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _sliderController = CarouselSliderController();
  }

  @override
  void dispose() {
    _imagePulseController.dispose();
    _qtyPulseController.dispose();
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
                return Hero(
                    tag: 'blue_card',
                    child: Material(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: ColorManager.darkPrimary,
                          borderRadius: BorderRadius.circular(value * 15),
                        ),
                      ),
                    ));
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
                                        ScaleTransition(
                                          scale: Tween<double>(
                                            begin: 1.0,
                                            end: 1.2,
                                          ).animate(_imagePulseController),
                                          child: GestureDetector(
                                            onLongPressStart: _onLongPressStart,
                                            onLongPressEnd: _onLongPressEnd,
                                            onLongPressMoveUpdate:
                                                _onLongPressMoveUpdate,
                                            child: SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: SizedBox(
                                                height: 300,
                                                child: CarouselSlider.builder(
                                                  unlimitedMode: true,
                                                  onSlideChanged: (value) {},
                                                  controller: _sliderController,
                                                  slideBuilder: (index) {
                                                    return Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: AppConstants
                                                          .colors[index],
                                                      child: Expanded(
                                                          child: Image.memory(
                                                              base64Decode(
                                                        state
                                                            .assignment
                                                            .books[index]
                                                            .image!,
                                                      ))),
                                                    );
                                                  },
                                                  slideTransform:
                                                      CubeTransform(),
                                                  slideIndicator:
                                                      CircularSlideIndicator(
                                                    padding: EdgeInsets.only(
                                                        bottom: 32),
                                                    indicatorBorderColor:
                                                        Colors.black,
                                                  ),
                                                  itemCount: state
                                                      .assignment.books.length,
                                                  initialPage: 0,
                                                  enableAutoSlider: false,
                                                ),
                                              ),
                                            ),
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
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: Stack(
                              key: fabKey,
                              alignment: AlignmentDirectional.center,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 60 + targetDistance,
                                  height: 60 + targetDistance,
                                  transform: Matrix4.rotationZ(
                                      targetDistance * math.pi / 90),
                                  transformAlignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/gradient.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 1.0,
                                    end: 1.4,
                                  ).animate(_qtyPulseController),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: qty > 0 ? 20 : 20,
                                    width: qty > 0 ? 20 : 20,
                                    transformAlignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: qty > 0
                                            ? ColorManager.darkPrimary
                                            : ColorManager.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (showDragWidget)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 100),
                            top: dragOffset.dy + targetDistance,
                            left: dragOffset.dx + targetDistance,
                            child: SizedBox(
                                height: (150 - targetDistance).abs(),
                                width: (150 - targetDistance).abs(),
                                child: Image.memory(
                                  base64Decode(
                                      state.assignment.books[0].image!),
                                )),
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
