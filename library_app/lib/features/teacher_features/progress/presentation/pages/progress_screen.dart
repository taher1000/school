import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../students/presentation/widgets/students_list.dart';

class TeacherProgressScreen extends StatefulWidget {
  const TeacherProgressScreen({super.key});

  @override
  State<TeacherProgressScreen> createState() => _TeacherProgressScreenState();
}

const List<String> list = <String>[
  'الصف الاول',
  'الصف الثاني',
  'الصف الثالث',
  'الصف الرابع'
];

class _TeacherProgressScreenState extends State<TeacherProgressScreen> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      screenTitle: "Students Progress",
      body: Column(
        children: [
          StudentsListWidget(
            isSelectable: false,
          )
          // CustomDropDownFormButton<String>(
          //   selectItem: dropdownValue,
          //   hint: 'اختار الصف',
          //   items: list
          //       .map((e) => DropdownMenuItem<String>(
          //           value: e,
          //           child: Wrap(
          //             children: [
          //               CustomText(
          //                 e,
          //                 style: TextStyle(color: Colors.black),
          //                 overflow: TextOverflow.ellipsis,
          //               )
          //             ],
          //           )))
          //       .toList(),
          //   onChanged: (data) {
          //     setState(() {
          //       dropdownValue = data;
          //     });
          //   },
          // ),
          // if (dropdownValue != null)
          //   Expanded(
          //     child: ListView.builder(
          //       padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
          //       itemCount: 10,
          //       itemBuilder: (BuildContext context, int index) {
          //         return StudentCard(
          //           title: "الطالب رقم $index",
          //           subTitle: "المستوي الاول",
          //           leading: CircleAvatar(
          //             backgroundColor: Colors.grey,
          //           ),
          //           onLongPress: () {},
          //           onTap: () {
          //             CustomNavigator.pushInSubNavigator(Routes.profileRoute);
          //           },
          //         );
          //       },
          //     ),
          //   ),
        ],
      ),
    );
  }
}
