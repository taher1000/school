import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class AppUtils {
  dynamic bookLevelCheck(int? bookLevel) {
    return bookLevel == null || bookLevel == 0 ? "" : bookLevel;
  }

  String searchTextNullCheck(String? search) {
    return search ?? "";
  }

  void appendPage({
    required PagingController pagingController,
    required bool isLastPage,
    required dynamic data,
  }) {
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      // pageKey++;
      pagingController.nextPageKey = pagingController.nextPageKey! + 1;
      pagingController.appendPage(data, pagingController.nextPageKey!);
    }
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
