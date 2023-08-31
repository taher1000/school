import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/config/validation.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../../core/widgets/textfield/custom_textfield.dart';
import '../../../../students/presentation/widgets/students_list.dart';

class TeacherEditStudentInfoScreen extends StatefulWidget {
  const TeacherEditStudentInfoScreen({super.key});

  @override
  State<TeacherEditStudentInfoScreen> createState() =>
      _TeacherEditStudentInfoScreenState();
}

class _TeacherEditStudentInfoScreenState
    extends State<TeacherEditStudentInfoScreen> {
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
  bool _isPlaying = true;

  late final CarouselSliderController _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "تعديل بيانات الطالب",
      body: StudentsListWidget(
        isSelectable: false,
        onTapItem: () async {
          await showMaterialModalBottomSheet(
            context: context,
            builder: (context) => Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Text("أختار المستوي القرائي للطالب",
                        textAlign: TextAlign.center,
                        style: TextStyleManager.getBlackStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s22)),
                  ),
                  SizedBox(
                    height: 300,
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
                  SizedBox(height: AppSize.s8),
                  CustomTextField(
                    hintText: 'اعادة تعيين كلمة المرور',
                    obscureText: true,
                    maxLines: 1,
                    isPass: true,
                    suffixIcon: Icon(Icons.visibility),
                    validator: (value) {
                      return Validation.isPassword(context, value!);
                    },
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
                ],
              ),
              // height: 250.h,
            ),
          );
        },
      ),
    );
  }
}
