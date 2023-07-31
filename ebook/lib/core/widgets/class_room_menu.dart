import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../resources/app_localization.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import 'buttons/custom_text_button.dart';
import 'cards/student_card.dart';
import 'text/custom_text.dart';
import 'textfield/custom_dropdown.dart';

class ClassRoomMenu extends StatefulWidget {
  final VoidCallback? onTapItem;
  final bool isSelectable;
  const ClassRoomMenu({super.key, this.isSelectable = true, this.onTapItem});

  @override
  State<ClassRoomMenu> createState() => _ClassRoomMenuState();
}

const List<String> list = <String>[
  'الصف الاول',
  'الصف الثاني',
  'الصف الثالث',
  'الصف الرابع',
  'كل الصفوف'
];

class _ClassRoomMenuState extends State<ClassRoomMenu> {
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomDropDownFormButton<String>(
            selectItem: dropdownValue,
            hint: 'اختار الصف',
            items: list
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Wrap(
                      children: [
                        CustomText(
                          e,
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )))
                .toList(),
            onChanged: (data) {
              setState(() {
                dropdownValue = data;
              });
            },
          ),
          if (widget.isSelectable)
            CustomTextButton(
              onPressed: selectAllAtOnceGo,
              child: Text(
                AppLocalization.of(context).getTranslatedValues("اختيار الكل"),
                style: TextStyleManager.getMediumStyle(
                    color: ColorManager.darkGrey, fontSize: FontSize.s22),
              ),
            ),
          if (dropdownValue != null)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                // padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  selectedItem[index] = selectedItem[index] ?? false;
                  bool? isSelectedData = selectedItem[index];
                  return StudentCard(
                    title: "الطالب رقم $index",
                    subTitle: "المستوي الاول",
                    onLongPress: () {
                      setState(() {
                        selectedItem[index] = !isSelectedData;
                        isSelectItem = selectedItem.containsValue(true);
                      });
                    },
                    onTap: widget.onTapItem ??
                        () {
                          if (!widget.isSelectable) {
                            CustomNavigator.pushInSubNavigator(
                                Routes.profileRoute);
                            return;
                          }
                          if (isSelectItem) {
                            setState(() {
                              selectedItem[index] = !isSelectedData!;
                              isSelectItem = selectedItem.containsValue(true);
                            });
                          } else {}
                        },
                    leading: _mainUI(isSelectedData!),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  selectAllAtOnceGo() {
    bool isFalseAvailable = selectedItem.containsValue(false);
    selectedItem.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
  }

  Widget _mainUI(bool isSelected) {
    if (isSelectItem && widget.isSelectable) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: ColorManager.darkPrimary,
      );
    } else {
      return CircleAvatar(
        backgroundColor: ColorManager.primary,
      );
    }
  }
}
