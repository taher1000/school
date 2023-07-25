import 'package:ebook/features/home/presentation/components/student_body.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/header_info_widget.dart';
import '../../../../core/widgets/info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widgets/main_info_container.dart';
import '../components/teacher_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        GradientBackgroundWidget(),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p40,
                  left: AppPadding.p16,
                  right: AppPadding.p16),
              child:
                  //StudentBodyComponent(),
                  TeacherBodyComponent(),
            )),
      ],
    );
  }
}
