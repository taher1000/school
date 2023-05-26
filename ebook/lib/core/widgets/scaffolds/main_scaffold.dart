import 'package:flutter/material.dart';
import 'custom_scaffold_body.dart';
import 'scaffold_background.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;

  const MainScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ScaffoldBG(scaffoldHeight: .4),
          Align(
              alignment: Alignment.bottomCenter,
              child: ScaffoldBody(
                body: body,
              )),
        ],
      ),
    );
  }
}
