import 'package:ebook/features/students/presentation/bloc/get_students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widgets/buttons/custom_text_button.dart';
import '../../../../core/widgets/text/custom_text.dart';
import '../../../../core/widgets/textfield/custom_dropdown.dart';
import 'student_list_item.dart';

class StudentsListWidget extends StatefulWidget {
  final VoidCallback? onTapItem;
  final bool isSelectable;
  const StudentsListWidget(
      {super.key, this.isSelectable = true, this.onTapItem});

  @override
  State<StudentsListWidget> createState() => _StudentsListWidgetState();
}

class _StudentsListWidgetState extends State<StudentsListWidget> {
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Expanded(
      child: Column(
        children: [
          CustomTextButton(
            onPressed: selectAllAtOnceGo,
            child: Text(
              localize("select_all_students"),
              style: TextStyleManager.getMediumStyle(
                  color: ColorManager.darkGrey, fontSize: FontSize.s22),
            ),
          ),
          if (dropdownValue != null)
            Expanded(
              child: BlocBuilder<GetStudentsBloc, GetStudentsState>(
                builder: (context, state) {
                  if (state is GetAllStudentsLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      // padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        selectedItem[index] = selectedItem[index] ?? false;
                        bool? isSelectedData = selectedItem[index];
                        return StudentCard(
                          title: state.students.data![index].englishName,
                          subTitle: "${localize('level')}: م",
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
                                    isSelectItem =
                                        selectedItem.containsValue(true);
                                  });
                                } else {}
                              },
                          leading: _mainUI(isSelectedData!),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
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
