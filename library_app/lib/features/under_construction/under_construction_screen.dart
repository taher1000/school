import 'package:flutter/material.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/widgets/scaffolds/custom_scaffold.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle: "Under Construction",
      body: Image.asset(ImageAssets.underConstruction),
    );
  }
}
