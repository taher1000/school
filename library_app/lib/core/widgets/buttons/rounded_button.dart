import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/enums/request_status.dart';
import '../../blocs/app_theme_cubit/app_theme_cubit.dart';

import '../../resources/color_manager.dart';

class CustomRoundedButton extends StatelessWidget {
  final RequestStatus? requestStatus;
  final String text;
  final VoidCallback? onPressed;

  const CustomRoundedButton({
    super.key,
    required this.text,
    this.requestStatus = RequestStatus.success,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: requestStatus == RequestStatus.loading ? null : onPressed,
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: 55.h,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(4, 4),
                    blurRadius: 5.0)
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.25, 1.0],
                colors: state.themeMode == ThemeMode.light
                    ? [
                        ColorManager.darkPrimary,
                        ColorManager.secondry,
                      ]
                    : [
                        ColorManager.darkGrey,
                        ColorManager.greyDark,
                      ],
              ),
              // color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: requestStatus == RequestStatus.loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(text,
                      style: Theme.of(context).textTheme.headlineSmall),
            ),
          );
        },
      ),
    );
  }
}
