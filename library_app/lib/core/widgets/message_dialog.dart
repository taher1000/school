import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_localization.dart';
import 'buttons/rounded_button.dart';
import 'text/custom_text.dart';

class MessageDialogWidget extends StatefulWidget {
  const MessageDialogWidget({
    Key? key,
    required this.message,
    this.details = '',
    this.actions,
    this.htmlBody,
  }) : super(key: key);

  final String message;
  final String details;
  final Widget? actions;
  final String? htmlBody;

  @override
  State<MessageDialogWidget> createState() => _MessageDialogWidgetState();
}

class _MessageDialogWidgetState extends State<MessageDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Card(
          child: SizedBox(
            width: 385.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0.025.sh,
                          ),
                          if (widget.message.isNotEmpty)
                            CustomText(
                              widget.message,
                              style: TextStyle(fontSize: 23.sp, height: 1.5.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 0.025.sh),
                              textAlign: TextAlign.center,
                            ),
                          if (widget.details.isNotEmpty)
                            CustomText(
                              widget.details,
                              style: TextStyle(fontSize: 16.sp, height: 1.5.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 0.025.sh),
                              textAlign: TextAlign.center,
                            ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  widget.actions ??
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: CustomRoundedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          text: AppLocalization.of(context)
                              .getTranslatedValues("close"),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
