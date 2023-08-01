import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
    );
  }
}
