import 'package:flutter/material.dart';
import '../../resources/values_manager.dart';
import 'scaffold_with_background.dart';
import 'scaffold_background.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;

  const MainScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScaffoldBG(body: body),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: ScaffoldBody(
          //       body: body,
          //     )),
        ],
      ),
    );
  }
}

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
