import 'package:flutter/material.dart';
import 'package:library_app/core/enums/request_status.dart';

import '../text/empty_widget.dart';
import '../loading/circular_progress_loader.dart';

class PaginationStatusWidget extends StatelessWidget {
  final RequestStatus state;
  final String errorMessage;
  final Widget widget;
  const PaginationStatusWidget({
    super.key,
    required this.state,
    required this.errorMessage,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case RequestStatus.loading:
        return const CustomLoader();
      case RequestStatus.error:
        return EmptyWidget(
          text: errorMessage,
        );

      case RequestStatus.success:
        return widget;
      default:
        return const CustomLoader();
    }
  }
}
