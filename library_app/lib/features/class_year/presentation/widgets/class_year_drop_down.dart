import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/buttons/rounded_button.dart';
import '../../domain/entities/class_year.dart';
import '../../../students/data/models/student.dart';
import '../../../students/presentation/bloc/get_students_bloc.dart';
import '../../../teacher_features/assignment/domain/entities/request/student_list.dart';
import '../../../teacher_features/assignment/presentation/bloc/add_assignment_bloc.dart';
import '../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../core/widgets/buttons/custom_text_button.dart';
import '../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../../../core/widgets/text/custom_text.dart';
import '../../../../core/widgets/textfield/custom_dropdown.dart';
import '../../../group_section/domain/entities/group_section.dart';
import '../../../group_section/presentation/cubit/group_section_cubit.dart';
import '../../../students/domain/entities/student.dart';
import '../../../students/presentation/widgets/student_list_item.dart';
import '../../../teacher_features/assignment/domain/entities/request/assignment_post_request.dart';
import '../cubit/class_year_cubit.dart';

class ClassYearDropDownMenuList extends StatelessWidget {
  const ClassYearDropDownMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClassYearCubit>(
          create: (context) => ClassYearCubit(getIt()),
        ),
        BlocProvider<GetStudentsBloc>(
          create: (context) => GetStudentsBloc(getIt()),
        ),
        BlocProvider<SectionGroupCubit>(
          create: (context) => SectionGroupCubit(getIt()),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
        child: ClassYearDropDownWithStudentsList(),
      ),
    );
  }
}

class ClassYearDropDownWithStudentsList extends StatefulWidget {
  const ClassYearDropDownWithStudentsList({super.key});

  @override
  State<ClassYearDropDownWithStudentsList> createState() =>
      _ClassYearDropDownWithStudentsListState();
}

class _ClassYearDropDownWithStudentsListState
    extends State<ClassYearDropDownWithStudentsList> {
  ClassYear? dropdownClassYear;
  SectionGroup? dropdownSectionGroup;
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};

  @override
  void initState() {
    BlocProvider.of<ClassYearCubit>(context).getClassYears();

    super.initState();
  }

  List<StudentList> studentsList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return Column(
      children: [
        BlocConsumer<ClassYearCubit, ClassYearState>(
          listener: (context, state) {
            if (state is GetClassYearsError) {
              showSnackBar(context,
                  message: state.message, backgroundColor: ColorManager.error);
            } else if (state is GetClassYearsLoading) {
              context.loaderOverlay.show();
            } else if (state is GetClassYearsLoaded) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is GetClassYearsLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                child: CustomDropDownFormButton(
                  label: localize('choose_class'),
                  selectItem: dropdownClassYear,
                  hint: localize('choose_class'),
                  items: state.classYears
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Wrap(
                            children: [
                              CustomText(
                                e.englishName,
                                style: TextStyleManager.getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s14),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (data) {
                    data as ClassYear;

                    setState(() {
                      dropdownClassYear = data;
                      dropdownSectionGroup = null;
                    });
                    BlocProvider.of<SectionGroupCubit>(context)
                        .getSectionGroups(dropdownClassYear!.id);
                    BlocProvider.of<GetStudentsBloc>(context).add(FetchStudents(
                      classYearID: dropdownClassYear!.id,
                    ));
                  },
                ),
              );
            } else if (state is GetClassYearsError) {
              return const Center(
                child: CustomText('Error'),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        BlocConsumer<SectionGroupCubit, SectionGroupState>(
          listener: (context, state) {
            if (state is GetSectionGroupsError) {
              showSnackBar(context,
                  message: state.message, backgroundColor: ColorManager.error);
            } else if (state is GetSectionGroupsLoading) {
              context.loaderOverlay.show();
            } else if (state is GetSectionGroupsLoaded) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is GetSectionGroupsLoaded) {
              return Column(
                children: [
                  CustomDropDownFormButton(
                    selectItem: dropdownSectionGroup,
                    hint: localize('choose_section'),
                    items: state.groupSections
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Wrap(
                              children: [
                                CustomText(
                                  e.sectionEnglishName,
                                  style: TextStyleManager.getBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s14),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (data) {
                      bool isFalseAvailable = selectedItem.containsValue(false);
                      selectedItem.updateAll((key, value) => isFalseAvailable);
                      setState(() {
                        isSelectItem = selectedItem.containsValue(false);
                      });
                      studentsList.clear();

                      data as SectionGroup;

                      setState(() {
                        dropdownSectionGroup = data;
                      });
                      BlocProvider.of<GetStudentsBloc>(context).add(
                          FetchStudents(
                              classYearID: dropdownClassYear!.id,
                              sectionID: dropdownSectionGroup!.id));
                    },
                  ),
                ],
              );
            } else if (state is GetSectionGroupsError) {
              return const Center(
                child: CustomText('Error'),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        Expanded(child: _buildStudentList()),
        // const Spacer(),
        CustomRoundedButton(
            text: localize("add_assignment"),
            onPressed: () {
              if (studentsList.isEmpty) {
                showSnackBar(context, message: "please_choose_students");
                return;
              }
              BlocProvider.of<AddAssignmentBloc>(context).add(
                AddNewAssignmentEvent(
                  assignmentPostRequestBody:
                      AssignmentPostRequestBody(studentList: studentsList),
                ),
              );
            })
      ],
    );
  }

  Widget _mainUI(bool isSelected) {
    if (isSelectItem) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: ColorManager.darkPrimary,
      );
    } else {
      return Icon(
        Icons.check_box_outline_blank,
        color: ColorManager.darkPrimary,
      );
    }
  }

  Widget _buildStudentList() {
    return BlocBuilder<GetStudentsBloc, GetStudentsState>(
      builder: (context, state) {
        if (state is GetAllStudentsLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p16.h),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextButton(
                  backgroundColor: ColorManager.darkGrey,
                  elevation: 10,
                  onPressed: () {
                    selectAllAtOnceGo(state.students.data);
                  },
                  child: Text(
                      AppLocalization.of(context)
                          .getTranslatedValues("select_all_students"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith()
                      // color: ColorManager.darkPrimary,
                      // fontSize: FontSize.s14.sp,
                      ),
                ),
                Expanded(
                  // height: MediaQuery.of(context).size.height * 0.4,
                  // width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                    itemCount: state.students.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      selectedItem[index] = selectedItem[index] ?? false;
                      bool? isSelectedData = selectedItem[index];
                      return StudentCard(
                        title: state.students.data[index].englishName,
                        subTitle:
                            state.students.data[index].classYearEnglishName,
                        onLongPress: () {
                          final stud = StudentList(
                              studentId: state.students.data[index].studentId,
                              classYearId:
                                  state.students.data[index].classYearId,
                              classSectionId:
                                  state.students.data[index].sectionId);
                          addStudent(index, isSelectedData, stud);
                        },
                        onTap: () {
                          // if (isSelectItem) {
                          final stud = StudentList(
                              studentId: state.students.data[index].studentId,
                              classYearId:
                                  state.students.data[index].classYearId,
                              classSectionId:
                                  state.students.data[index].sectionId);
                          addStudent(index, isSelectedData, stud);
                          // }
                        },
                        leading: _mainUI(isSelectedData!),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  selectAllAtOnceGo(List<StudentModel> students) {
    bool isFalseAvailable = selectedItem.containsValue(false);
    print(isFalseAvailable);
    selectedItem.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
    if (isFalseAvailable) {
      studentsList.clear();
      for (var i = 0; i < students.length; i++) {
        studentsList.add(StudentList(
            studentId: students[i].studentId,
            classYearId: students[i].classYearId,
            classSectionId: students[i].sectionId));
      }
    } else {
      studentsList.clear();
    }

    print(studentsList.length);
  }

  addStudent(int index, bool? isSelectedData, StudentList stud) {
    setState(() {
      selectedItem[index] = !isSelectedData!;
      isSelectItem = selectedItem.containsValue(true);
    });

    if (studentsList.contains(stud)) {
      studentsList
          .removeWhere((element) => element.studentId == stud.studentId);
    } else {
      studentsList.add(stud);
    }
  }
}
