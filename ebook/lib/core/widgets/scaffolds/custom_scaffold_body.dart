import 'package:flutter/material.dart';

import '../../resources/values_manager.dart';

class ScaffoldBody extends StatelessWidget {
  final Widget body;

  const ScaffoldBody({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: SizedBox(
        // color: Colors.amber,
        height: double.infinity,
        width: double.infinity,
        child: body,
      ),
    );
  }
}
