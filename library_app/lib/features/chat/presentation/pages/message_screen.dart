import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      // height: 850,
      screenTitle: "Taher Fawaz",
      body: MessageScreenBody(),
    );
  }
}
