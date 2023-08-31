import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget widget;
  final Future<void> Function() onRefresh;
  const MyRefreshIndicator(
      {super.key, required this.widget, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
        onRefresh: onRefresh,
        builder: MaterialIndicatorDelegate(
          builder: (context, controller) {
            return Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            );
          },
          scrollableBuilder: (context, child, controller) {
            return Opacity(
              opacity: 1.0 - controller.value.clamp(0.0, 1.0),
              child: child,
            );
          },
        ),
        child: widget);
  }
}
