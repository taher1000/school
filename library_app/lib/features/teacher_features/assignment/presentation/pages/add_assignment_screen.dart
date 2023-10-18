import '../../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../../../class_year/presentation/widgets/class_year_drop_down.dart';
import '../../domain/entities/request/book_collection_body.dart';
import '../bloc/add_assignment_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/buttons/rounded_button.dart';
import '../../../../../core/widgets/textfield/custom_textfield.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../books/presentation/cubit/book_selection_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/config/validation.dart';
import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/custom_horizontal_stepper.dart';
import '../../../../books/presentation/widgets/books_list_widget.dart';
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
  DateTime startsOn = DateTime.now();
  DateTime? endsOn;

  final startsOnDateController = TextEditingController();
  final endsOnDateController = TextEditingController();
  final titleController = TextEditingController();
  int currentStep = 0;
  List<BookCollection> books = [];
  @override
  void initState() {
    super.initState();
    startsOnDateController.text = dateFormat.format(startsOn);
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("create_reading_assignment"),
      body: BlocListener<AddAssignmentBloc, AddAssignmentState>(
        listener: (context, state) {
          if (state is AddNewAssignmentLoading) {
            context.loaderOverlay.show();
          }
          if (state is AddNewAssignmentSuccess) {
            context.loaderOverlay.hide();
            showCustomSnackBar(context, message: state.message);
            Navigator.pop(context);
          }
          if (state is AddNewAssignmentFailed) {
            context.loaderOverlay.hide();
            showCustomSnackBar(context, message: state.message);
          }
        },
        child: CustomHorizontalStepper(
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
                const Expanded(child: BooksItemsListWidget()),
                BlocBuilder<BookSelectionCubit, BookSelectionState>(
                  builder: (context, state) {
                    return CustomRoundedButton(
                        text: localize("next"),
                        onPressed: () {
                          if (state.books.isEmpty) {
                            showCustomSnackBar(context,
                                message: localize("please_select_book"));

                            return;
                          }

                          books.addAll(
                              BlocProvider.of<BookSelectionCubit>(context)
                                  .books);

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
                            maxHeight: MediaQuery.of(context).size.height / 3),
                        builder: (context) {
                          return CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.grey[200],
                              minimumDate: DateTime.now(),
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
                      // style: TextStyleManager.getMediumStyle(
                      //     color: ColorManager.black, fontSize: FontSize.s18),
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
                            maxHeight: MediaQuery.of(context).size.height / 3),
                        builder: (context) {
                          return CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.grey[200],
                            minimumDate:
                                endsOn ?? startsOn.add(Duration(days: 1)),
                            initialDateTime:
                                endsOn ?? startsOn.add(Duration(days: 1)),
                            onDateTimeChanged: (DateTime date) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                endsOnDateController.text =
                                    dateFormat.format(date);
                              });
                              // date.toUtc().toFormatedString()!;

                              setState(() {
                                endsOn = date;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                  Spacer(),
                  CustomRoundedButton(
                      text: localize("next"),
                      onPressed: () {
                        if (titleController.text.isEmpty) {
                          showCustomSnackBar(context,
                              message: "Please enter title");

                          return;
                        }
                        if (endsOn == null) {
                          showCustomSnackBar(context,
                              message: "Please select date");

                          return;
                        }

                        BlocProvider.of<AddAssignmentBloc>(context)
                            .add(UpdateAssignmentInfoEvent(
                          assignmentPostRequestBody: AssignmentPostRequestBody(
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
            ClassYearDropDownMenuList(),
          ],
        ),
      ),
    );
  }
}
