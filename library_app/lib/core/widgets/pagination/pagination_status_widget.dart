import 'package:flutter/material.dart';
import 'package:library_app/core/enums/request_status.dart';

import '../text/custom_error_widget.dart';
import '../loading/circular_progress_loader.dart';

class LoadingStatusWidget extends StatelessWidget {
  final RequestStatus requestStatus;
  final String errorMessage;
  final Widget widget;
  const LoadingStatusWidget({
    super.key,
    required this.requestStatus,
    required this.errorMessage,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    switch (requestStatus) {
      case RequestStatus.loading:
        return const CustomLoader();
      case RequestStatus.error:
        return CustomErrorWidget(
          text: errorMessage,
        );

      case RequestStatus.success:
        return widget;
      case RequestStatus.initial:
        return widget;
      default:
        return const CustomLoader();
    }
  }
}
