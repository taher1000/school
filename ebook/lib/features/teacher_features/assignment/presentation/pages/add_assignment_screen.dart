import 'package:ebook/features/class_year/presentation/widgets/class_year_drop_down.dart';
import 'package:ebook/features/teacher_features/assignment/domain/entities/request/book_collection_body.dart';
import 'package:ebook/features/teacher_features/assignment/presentation/bloc/add_assignment_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../../core/widgets/textfield/custom_textfield.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../books/presentation/cubit/book_selection_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/config/validation.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/custom_horizontal_stepper.dart';
import '../../../../books/presentation/widgets/books_list_widget.dart';
import '../../../../students/presentation/widgets/students_list.dart';
import '../../domain/entities/request/assignment_post_request.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  TextEditingController date = TextEditingController();
  TextEditingController controller = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy', 'en');
  DateTime? startsOn;
  DateTime? endsOn;

  final startsOnDateController = TextEditingController();
  final endsOnDateController = TextEditingController();
  final titleController = TextEditingController();
  int currentStep = 0;
  List<BookCollection> books = [];

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return BlocListener<AddAssignmentBloc, AddAssignmentState>(
      listener: (context, state) {
        if (state is AddNewAssignmentLoading) {
          context.loaderOverlay.show();
        }
        if (state is AddNewAssignmentSuccess) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        }
        if (state is AddNewAssignmentFailed) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: CustomScaffold(
        screenTitle: localize("create_reading_assignment"),
        body: CustomHorizontalStepper(
            currentStep: currentStep,
            onStepTap: (index) {
              if (currentStep > index) {
                setState(() {
                  currentStep = index;
                });
              }
            },
            steps: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: AppMargin.m16),
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppConstants.bookLevelImages.length,
                      itemBuilder: (context, i) {
                        return Image.asset(
                            AppConstants.bookLevelImages.keys.toList()[i],
                            width: 30,
                            height: 30);
                      },
                    ),
                  ),
                  const BooksItemsListWidget(),
                  BlocBuilder<BookSelectionCubit, BookSelectionState>(
                    builder: (context, state) {
                      return CustomRoundedButton(
                          text: localize("next"),
                          onPressed: () {
                            if (state.books.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Please select book")));
                              return;
                            }
                            for (var i = 0; i < state.books.length; i++) {
                              books.add(BookCollection(
                                  bookId: state.books[i].id!,
                                  hasBookAudio: true,
                                  hasBookRead: true));
                            }
                            // BlocProvider.of<AddAssignmentBloc>(context).add(
                            //     UpdateAssignmentInfoEvent(
                            //         assignmentPostRequestBody:
                            //             AssignmentPostRequestBody(
                            //                 bookCollection: books)));
                            setState(() {
                              currentStep++;
                            });
                          });
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: titleController,
                      hintText: localize("assignment_title"),
                      label: Text(localize("assignment_title")),
                    ),
                    CustomTextField(
                      label: Text(
                        localize('start_on'),
                        style: TextStyleManager.getMediumStyle(
                            color: ColorManager.black, fontSize: FontSize.s18),
                      ),
                      controller: startsOnDateController,
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validation.isValid(context, value!),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      suffixIcon: const Icon(Icons.date_range),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? initialDate;
                        if (startsOnDateController.text.isNotEmpty) {
                          initialDate =
                              dateFormat.parse(startsOnDateController.text);
                          startsOnDateController.text =
                              dateFormat.format(initialDate);
                        }
                        showModalBottomSheet(
                          context: context,
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 3),
                          builder: (context) {
                            return CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.grey[200],
                                maximumDate: DateTime.now()
                                    .add(const Duration(seconds: 1)),
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime date) {
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    startsOnDateController.text =
                                        dateFormat.format(date);
                                  });
                                  // date.toUtc().toFormatedString()!;

                                  setState(() {
                                    startsOn = date;
                                  });
                                });
                          },
                        );
                      },
                    ),
                    CustomTextField(
                      label: Text(
                        localize('end_on'),
                        style: TextStyleManager.getMediumStyle(
                            color: ColorManager.black, fontSize: FontSize.s18),
                      ),
                      controller: endsOnDateController,
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validation.isValid(context, value!),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      suffixIcon: const Icon(Icons.date_range),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? initialDate;
                        if (endsOnDateController.text.isNotEmpty) {
                          initialDate =
                              dateFormat.parse(endsOnDateController.text);
                          endsOnDateController.text =
                              dateFormat.format(initialDate);
                        }
                        showModalBottomSheet(
                          context: context,
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 3),
                          builder: (context) {
                            return CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.grey[200],
                                maximumDate: DateTime.now()
                                    .add(const Duration(seconds: 1)),
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime date) {
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    endsOnDateController.text =
                                        dateFormat.format(date);
                                  });
                                  // date.toUtc().toFormatedString()!;

                                  setState(() {
                                    endsOn = date;
                                  });
                                });
                          },
                        );
                      },
                    ),
                    CustomRoundedButton(
                        text: localize("next"),
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please enter title")));
                            return;
                          }
                          if (startsOn == null || endsOn == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please select date")));
                            return;
                          }

                          BlocProvider.of<AddAssignmentBloc>(context)
                              .add(UpdateAssignmentInfoEvent(
                            assignmentPostRequestBody:
                                AssignmentPostRequestBody(
                                    englishName: titleController.text,
                                    arabicName: titleController.text,
                                    startDate: startsOn,
                                    endDate: endsOn,
                                    bookCollection: books),
                          ));
                          setState(() {
                            currentStep++;
                          });
                        }),
                  ],
                ),
              ),
              const ClassYearDropDownMenuList(),
            ]),
      ),
    );
  }
}
