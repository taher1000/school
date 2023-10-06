import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/font_manager.dart';
import 'package:library_app/core/utils/utils.dart';
import 'package:library_app/injection_container.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/resources/routes_manager.dart';

class CustomCountDownWidget extends StatefulWidget {
  final int minutes;
  final String bookId;
  const CustomCountDownWidget({
    Key? key,
    required this.minutes,
    required this.bookId,
  }) : super(key: key);

  @override
  State<CustomCountDownWidget> createState() => _CustomCountDownWidgetState();
}

class _CustomCountDownWidgetState extends State<CustomCountDownWidget>
    with SingleTickerProviderStateMixin {
  late CustomTimerController _controller;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    _controller = CustomTimerController(
        vsync: this,
        begin: Duration(minutes: widget.minutes),
        end: const Duration(),
        initialState: CustomTimerState.finished,
        interval: CustomTimerInterval.milliseconds);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int? remainingTime;
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 80.w,
          child: TextButton(
            child: Text(
              localize("back"),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: FontSize.s20.sp,
                  ),
            ),
            onPressed: () async {
              await saveData();
              CustomNavigator.pushInSubNavigator(
                sharedPrefsClient.userRole == UserRole.teacher.value
                    ? Routes.homeRoute
                    : Routes.studentMyBooksRoute,
                replace: true,
              );
            },
          ),
        ),
        SizedBox(
          width: 40.w,
        ),
        FutureBuilder<Duration?>(
            future: getData(),
            builder: (context, AsyncSnapshot<Duration?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                _controller.begin =
                    snapshot.data ?? Duration(minutes: widget.minutes);
                _controller.start();
                return CustomTimer(
                    key: _key,
                    controller: _controller,
                    builder: (state, time) {
                      // Build the widget you want!🎉
                      return Text(
                          "${localize('remaining_time')}: ${time.hours}:${time.minutes}:${time.seconds}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: ColorManager.white,
                                fontSize: FontSize.s20.sp,
                              ));
                    });
              }
            }),
      ],
    );
  }

  Future<void> saveData() async {
    await sharedPrefsClient.prefs.setString(
        widget.bookId, _controller.remaining.value.duration.toString());
  }

  Future<Duration?> getData() async {
    final data = await sharedPrefsClient.prefs.getString(widget.bookId);
    if (data != null) {
      return AppUtils().parseDuration(data);
    } else {
      return null;
    }
  }
}
