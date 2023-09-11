import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../students/presentation/widgets/students_list.dart';

class ReadingLevelAdjustment extends StatefulWidget {
  const ReadingLevelAdjustment({super.key});

  @override
  State<ReadingLevelAdjustment> createState() => _ReadingLevelAdjustmentState();
}

class _ReadingLevelAdjustmentState extends State<ReadingLevelAdjustment> {
  // final List<String> letters = [
  //   "A",
  //   "B",
  //   "C",
  //   "D",
  //   "E",
  //   "F",
  //   "G",
  // ];
  final List<String> levelImages = [
    ImageAssets.charA,
    ImageAssets.charB,
    ImageAssets.charC,
    ImageAssets.charD,
    ImageAssets.charE,
    ImageAssets.charF,
    ImageAssets.charG,
    ImageAssets.charI,
    ImageAssets.charJ,
    ImageAssets.charK,
    ImageAssets.charL,
    ImageAssets.charM,
    ImageAssets.charN,
    ImageAssets.charO,
    ImageAssets.charP,
    ImageAssets.charQ,
    ImageAssets.charR,
    ImageAssets.charS,
  ];
  final List<Color> colors = [
    Colors.purple,
    Colors.purple,
    Colors.purple,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.blue,
    Colors.blue,
    Colors.green,
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.orange,
    Colors.orange,
    Colors.red,
    Colors.red,
    Colors.red,
  ];

  late final CarouselSliderController _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "تعديل المستوي القرائي للطلبة",
      body: Column(
        children: [
          StudentsListWidget(
            isSelectable: false,
            onTapItem: () async {
              await showMaterialModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: CarouselSlider.builder(
                          unlimitedMode: true,
                          onSlideChanged: (value) {},
                          controller: _sliderController,
                          slideBuilder: (index) {
                            return Container(
                              alignment: Alignment.center,
                              color: colors[index],
                              child: Expanded(
                                child: Image.asset(
                                  levelImages[index],
                                  // fit: BoxFit.fill,
                                  width: 2000,
                                  height: 2000,
                                ),
                              ),
                            );
                          },
                          slideTransform: CubeTransform(),
                          slideIndicator: CircularSlideIndicator(
                            padding: EdgeInsets.only(bottom: 32),
                            indicatorBorderColor: Colors.black,
                          ),
                          itemCount: levelImages.length,
                          initialPage: 0,
                          enableAutoSlider: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: Text("أختار المستوي القرائي للطالب",
                            style: TextStyleManager.getBlackStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s30)),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: CustomRoundedButton(
                            text: "حفظ",
                            onPressed: () async {
                              Navigator.pop(context);
                              await Fluttertoast.showToast(
                                  msg: AppLocalization.of(context)
                                      .getTranslatedValues(
                                          "لقد تم تعديل المستوي بنجاح"),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorManager.darkPrimary,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }),
                      ),
                      Spacer(),
                    ],
                  ),
                  // height: 250.h,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}