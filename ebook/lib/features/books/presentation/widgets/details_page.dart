import 'package:animate_do/animate_do.dart';
import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/features/books/presentation/widgets/book_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

import '../pages/books_screen.dart';
import 'back_icon_button.dart';
import 'circle_choice.dart';

const colors = [
  {"colorName": "yellow", "color": Color(0xFFF2D337)},
  {"colorName": "blue", "color": Color(0xFF6C9DFD)},
  {"colorName": "green", "color": Color(0xFF7DD222)},
];

class DetailsPage extends StatefulWidget {
  final Offset catListOffset;
  final int selectedCat;

  const DetailsPage(
      {super.key, required this.catListOffset, required this.selectedCat});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  int selectedCat = 0;
  int selectedColor = 0;
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
    selectedCat = widget.selectedCat;
    _imagePulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _qtyPulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _imagePulseController.dispose();
    _qtyPulseController.dispose();
    super.dispose();
  }

  List<String> title = ["تفاصيل", "استماع", "قراءة", "امتحان"];
  List<IconData> icons = [
    FontAwesomeIcons.info,
    FontAwesomeIcons.headphones,
    FontAwesomeIcons.bookOpen,
    FontAwesomeIcons.circleQuestion
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
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
            const BackIconButton(),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 50.h,
              left: MediaQuery.of(context).size.width * .1,
              child: categoryWithoutTag(),
            ),
            Positioned(
              top: widget.catListOffset.dy,
              child: categoryWithTag(),
            ),
            Positioned(
              top: 170.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: SlideInUp(
                delay: const Duration(milliseconds: 1200),
                duration: const Duration(milliseconds: 600),
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
                                          child: Image.asset(
                                            ImageAssets.book1,
                                            fit: BoxFit.cover,
                                            key: imageKey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const BookInfo(),
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
                                  image:
                                      AssetImage('assets/images/gradient.png'),
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
                          child: Image.asset(
                            ImageAssets.book1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryWithTag() {
    return FadeOut(
      child: Hero(
        tag: "cat",
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: categories.length,
                padding: const EdgeInsets.only(left: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CircleChoice(
                      title: title[index],
                      icon: icons[index],
                      onTap: () {
                        _imagePulseController.forward();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWithoutTag() {
    return SizedBox(
      height: 90,
      // width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: categories.length,
        // padding: const EdgeInsets.only(left: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SlideInUp(
            key: Key(index.toString()),
            delay: Duration(milliseconds: 200 + (100 * index)),
            from: widget.catListOffset.dy - 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCat = index;
                  });
                  _imagePulseController
                      .forward()
                      .then((value) => _imagePulseController.reverse());

                  // _imagePulseController.reverse();
                },
                child: CircleChoice(
                  title: title[index],
                  icon: icons[index],
                  isSelected: selectedCat == index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
