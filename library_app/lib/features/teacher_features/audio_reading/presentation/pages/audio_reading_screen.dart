import 'package:flutter/material.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../students/domain/entities/student.dart';

class AudioReadingScreen extends StatefulWidget {
  const AudioReadingScreen({super.key});

  @override
  State<AudioReadingScreen> createState() => _AudioReadingScreenState();
}

class _AudioReadingScreenState extends State<AudioReadingScreen> {
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("القراءة الصوتية"),
      body: const Expanded(
        // height: 200,
        // width: 150,
        child: SizedBox(),
      ),
    );
  }
}
