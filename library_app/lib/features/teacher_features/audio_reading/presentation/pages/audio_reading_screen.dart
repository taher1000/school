import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../students/domain/entities/student.dart';

class AudioReadingScreen extends StatefulWidget {
  const AudioReadingScreen({super.key});

  @override
  State<AudioReadingScreen> createState() => _AudioReadingScreenState();
}

class _AudioReadingScreenState extends State<AudioReadingScreen> {
  List<Student> _students = <Student>[];

  @override
  void initState() {
    super.initState();
    _students = getStudentsData();
  }

  List<Student> getStudentsData() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("القراءة الصوتية"),
      body: Expanded(
        // height: 200,
        // width: 150,
        child: SizedBox(),
      ),
    );
  }
}
